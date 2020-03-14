use Cro::HTTP::BodyParsers;
use Cro::HTTP::BodySerializers;
use Cro::HTTP::Client;

use FHIR::Base;
use FHIR::DomainModel;
use FHIR::JsonSerdes;

unit module Client;

class FHIRJsonSerializer does Cro::HTTP::BodySerializer {
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
        my $json = jencode($body, :!pretty).encode('utf-8');
        self!set-content-length($message, $json.bytes);
        supply { emit $json }
    }
}

class FHIRJsonParser does Cro::BodyParser {
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

class FHIRClient {
    has Str $.base-uri;
    #TODO: Auth
    has Cro::HTTP::Client $!client .= new: $base-uri, :content-type<application/fhir+json>, # :push-promises, #TODO: enable?
            body-serializers => [ FHIRJsonSerializer ], body-parsers => [ FHIRJsonParser ];

    #`[ Common params:
_format 	Override the HTTP content negotiation - see immediately below
_pretty 	Ask for a pretty printed response for human convenience - see below
_summary 	Ask for a predefined short form of the resource in response - see Search Summary
_elements 	Ask for a particular set of elements to be returned - see Search Elements
    ]
    method read(Resource:U $type, Str $id --> Promise) {
        $client.get: "/{$type.resourceType}/$id", query => { _summary => 'false' } #  _summary eq true, false, text, count or data.
    }
    method vread(Resource:U $type, Str $id, Str $vid --> Promise) {
        $client.get: "/{$type.resourceType}/$id/_history/$vid";
    }
    method update(Resource:D $resource --> Promise) {
        return Promise.broken(X::AdHoc.new(payload => "Cannot update a resource without an id")) unless $resource.id.defined;
        $client.put: "/{$resource.resourceType}/{$resource.id}", :body($resource);
    }
    method patch(Resource:U $type, Str $id, Parameters $patch --> Promise) { # IDK what $patch shou be? probably parameters as here https://www.hl7.org/fhir/fhirpatch.html so that's what they are for now
        $client.patch: "/{$type.resourceType}/{$id}", :body($patch);
    }
    multi method delete(Resource:U $type, Str $id --> Promise) {
        $client.delete: "/{$type.resourceType}/{$id}";
    }
    multi method delete(Resource:D $resource --> Promise) {
        return Promise.broken(X::AdHoc.new(payload => "Cannot delete a resource without an id")) unless $resource.id.defined;
        delete: $resource.WHAT, $resource.id;
    }
    method create(Resource:D $resource --> Promise) {
        $client.post("/{$resource.resourceType}", :body($resource)).then({ .header('Location') });
    }
    method search(Resource:U $type --> Promise) {
        $client.post("/{$resource.resourceType}", :body($resource)).then({ .header('Location') });
    }
    #`[
    read	Read the current state of the resource
vread	Read the state of a specific version of the resource
update	Update an existing resource by its id (or create it if it is new)
patch	Update an existing resource by posting a set of changes to it
delete	Delete a resource
history	Retrieve the change history for a particular resource
Type Level Interactions
create	Create a new resource with a server assigned id
search	Search the resource type based on some filter criteria
history	Retrieve the change history for a particular resource type
Whole System Interactions
capabilities	Get a capability statement for the system
batch/transaction	Update, create or delete a set of resources in a single interaction
history	Retrieve the change history for all resources
search
]
}


