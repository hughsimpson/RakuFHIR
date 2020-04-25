#!/usr/bin/env perl6
use v6.d;

use UUID;

use FHIR::Base;
use FHIR::DomainModel;
use FHIR::JsonSerdes;

unit module Store;

role AbstractStore is export {
    method insert(Resource:D $rsc --> Str) {
        ...
    }
    method update(Resource:D $rsc --> OperationOutcome) {
        ...
    }
    method delete(Str $tpe, Str $id --> Nil) {
        ...
    }
    method search(&filter --> Array[::Resource]) {
        ...
    }
    method read(Str $tpe, Str $id --> Resource) {
        ...
    }
    method vread(Str $tpe, Str $id, Int $vid --> Resource) {
        ...
    }
    method patch(Str $tpe, Str $id, &patch --> Nil) {
        ...
    }
}

class InMemory does AbstractStore is export {
    has %!resources;
    method insert(Resource:D $rsc --> Str) {
        my $id = ~UUID.new;
        my $rsc2 = $rsc.clone: :$id;
        %!resources{"{$rsc2.resourceType}/$id"} = [$rsc2];
        $id;
    }
    method update(Resource:D $rsc --> OperationOutcome) {
        my OperationOutcome_Issue @issues;
        my Int $status = 202;
        my $el := %!resources{"{$rsc.resourceType}/{$rsc.id}"};
        $status = 422 and push @issues, OperationOutcome_Issue.new(
                :code<not-found>, :severity<error>, :diagnostics{"Cannot find resource {$rsc.id} to update"}
                ) unless $el.defined;
        $el.push: $rsc;
        push @issues, OperationOutcome_Issue.new:
                :code<informational>, :severity<information>, :diagnostics("New version id is {$el - 1}");
        $el.defined ?? OperationOutcome.new(:issue(@issues)) !! die "cannot update missing resource";
    }
    method delete(Str $tpe, Str $id --> Nil) {
        %!resources{"$tpe/$id"}:delete
    }
    method search(&filter --> Array[::Resource]) {
        %!resources.values.grep(&filter)
    }
    method read(Str $tpe, Str $id --> Resource) {
        my $el := %!resources{"$tpe/$id"};
        $el.defined ?? $el[*-1] !! ::("DomainModel::$tpe")
    }
    method vread(Str $tpe, Str $id, Int $vid --> Resource) {
        %!resources{"$tpe/$id"}[$vid] // ::("DomainModel::$tpe")
    }
    method patch(Str $tpe, Str $id, &patch --> Nil) {
        my $el := %!resources{"$tpe/$id"};
        $el.defined ?? { $el.push: patch $el[*-1] } !! die "cannot update missing resource";
    }
}


