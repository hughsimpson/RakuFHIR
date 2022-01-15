#!/usr/bin/env perl6
use v6.d;

use Cro::HTTP::BodyParsers;
use Cro::HTTP::BodySerializers;
use Cro::HTTP::Client;

use FHIR::Base;
use FHIR::DomainModel;
use FHIR::JsonSerdes;

unit module Client;

class FHIRJsonSerializer does Cro::HTTP::BodySerializer is export {
    method is-applicable(Cro::HTTP::Message $message, $body --> Bool) {
        with $message.content-type {
            (.type eq 'application' && (.subtype eq 'json' or .subtype eq 'fhir+json' or .subtype eq 'json+fhir') || .suffix eq 'json') &&
                    ($body ~~ FHIR)
        }
        else {
            False
        }
    }

    method serialize(Cro::HTTP::Message $message, $body --> Supply) {
        my $json = $body.Str.encode('utf-8');
        self!set-content-length($message, $json.bytes);
        supply { emit $json }
    }
}

class FHIRJsonParser does Cro::BodyParser is export {
    method is-applicable(Cro::HTTP::Message $message --> Bool) {
        with $message.content-type {
            .type eq 'application' && (.subtype eq 'json' or .subtype eq 'fhir+json' or .subtype eq 'json+fhir') || .suffix eq 'json'
        }
        else {
            False
        }
    }

    method parse(Cro::HTTP::Message $message --> Promise) {
        Promise(supply {
            my $payload = Blob.new;
            whenever $message.body-byte-stream -> $blob {
                $payload ~= $blob;
                LAST emit jdecode($payload.decode('utf-8'));
            }
        })
    }
}

sub return-empty(--> Array) { [] }
class AsyncFHIRClient is export {
    has Str $.fhir-server is required;
    has Cro::Uri $!base-uri .= parse: $!fhir-server;
    has Str $!path-prefix = $!base-uri.path;

    has &.extra-headers is default(&return-empty);

    has Cro::HTTP::Client $!client .= new: :$!base-uri, :content-type<application/fhir+json>, # :push-promises, #TODO: enable?
            body-serializers => [ FHIRJsonSerializer.new ], body-parsers => [ FHIRJsonParser.new ], headers => &!extra-headers();

    method read(Resource:U $type, Str $id --> Promise) {
        $!client.get("$!path-prefix/{$type.resourceType}/$id", query => { _summary => 'false' }).then(*.result.body) #  _summary eq true, false, text, count or data.
    }
    method vread(Resource:U $type, Str $id, Str $vid --> Promise) {
        $!client.get("$!path-prefix/{$type.resourceType}/$id/_history/$vid").then(*.result.body);
    }
    method update(Resource:D $resource --> Promise) {
        return Promise.broken(X::AdHoc.new(payload => "Cannot update a resource without an id"))
                unless $resource.id.defined;
        $!client.put("$!path-prefix/{$resource.resourceType}/{$resource.id}", :body($resource)).then(*.result.body);
    }
    method patch(Resource:U $type, Str $id, Parameters $patch --> Promise) { # IDK what $patch should be? probably parameters as here https://www.hl7.org/fhir/fhirpatch.html so that's what they are for now
        $!client.patch("$!path-prefix/{$type.resourceType}/{$id}", :body($patch)).then({Nil});
    }
    multi method delete(Resource:U $type, Str $id --> Promise) {
        $!client.delete("$!path-prefix/{$type.resourceType}/{$id}").then({Nil});
    }
    multi method delete(Resource:D $resource --> Promise) {
        return Promise.broken(X::AdHoc.new(payload => "Cannot delete a resource without an id"))
                unless $resource.id.defined;
        delete: $resource.WHAT, $resource.id;
    }
    method create(Resource:D $resource --> Promise) {
        $!client.post("$!path-prefix/{$resource.resourceType}", :body($resource)).then(*.result.header('Location'));
    }
    method search(Resource:U $type, %params = {} --> Promise) {
        $!client.get("$!path-prefix/{$type.resourceType}", query => %params).then(*.result.body);
    }
    method capabilities(--> Promise) {
        $!client.get("$!path-prefix/metadata").then(*.result.body);
    }
    method batch(Bundle $bundle --> Promise) {
        return Promise.broken(X::AdHoc.new(payload => "Cannot submit a bundle with transaction type {$bundle.type}"))
                unless $bundle.type ~~ 'batch' | 'transaction';
        $!client.post("$!path-prefix", :body($bundle)).then(*.result.body);
    }
    multi method history(%params = {} --> Promise) {
        $!client.get("$!path-prefix/_history", query => %params).then(*.result.body);
    }
    multi method history(Resource:U $type, %params = {} --> Promise) {
        $!client.get("$!path-prefix/{$type.resourceType}/_history", query => %params).then(*.result.body);
    }
    multi method history(Resource:U $type, Str $id, %params = {} --> Promise) {
        $!client.get("$!path-prefix/{$type.resourceType}/$id/_history", query => %params).then(*.result.body);
    }
    multi method history(Resource:D $resource, %params = {} --> Promise) {
        return Promise.broken(X::AdHoc.new(payload => "Cannot get the history of a resource without an id"))
                unless $resource.id.defined;
        history: $resource.WHAT, $resource.id, %params;
    }
}

class SyncFHIRClient is export {
    has Str $.fhir-server is required;
    has Array &.extra-headers is default(&return-empty);
    has AsyncFHIRClient $!client = AsyncFHIRClient.new: :$!fhir-server, :&!extra-headers;

    # Should return `T` but rakudo throws a X::TypeCheck::Return even though the response is the correct type :'(
    method read(Resource:U ::T, Str $id --> Resource) {
        await await $!client.read: T, $id;
    }
    method vread(Resource:U ::T, Str $id, Str $vid --> Resource) {
        await await $!client.vread: T, $id, $vid;
    }
    method update(Resource:D $resource --> OperationOutcome) {
        await await $!client.update: $resource;
    }
    method patch(Resource:U $type, Str $id, Parameters $patch --> Nil) {
        await $!client.patch: $type, $id, $patch;
    }
    multi method delete(Resource:U $type, Str $id --> Nil) {
        await $!client.delete: $type, $id;
    }
    multi method delete(Resource:D $resource --> Nil) {
        await $!client.delete: $resource;
    }
    method create(Resource:D $resource --> Str) {
        await $!client.create: $resource;
    }
    method search(Resource:U $type, %params = {} --> Bundle) {
        await await $!client.search: $type, %params;
    }
    method capabilities(--> CapabilityStatement) {
        await await $!client.capabilities;
    }
    method batch(Bundle $bundle --> Bundle) {
        await await $!client.batch: $bundle;
    }
    multi method history(%params = {} --> Bundle) {
        await await $!client.history: %params;
    }
    multi method history(Resource:U $type, %params = {} --> Bundle) {
        await await $!client.history: $type, %params;
    }
    multi method history(Resource:U $type, Str $id, %params = {} --> Bundle) {
        await await $!client.history: $type, $id, %params;
    }
    multi method history(Resource:D $resource, %params = {} --> Bundle) {
        await await $!client.history: $resource, %params;
    }
}
