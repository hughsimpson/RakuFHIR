#!/usr/bin/env perl6
use v6.d;

use Cro::HTTP::Router;
use Cro::HTTP::Server;

use FHIR::Base;
use FHIR::Client;
use FHIR::DomainModel;
use FHIR::JsonSerdes;
use FHIR::Store;

unit module Server;


sub init(AbstractStore $store, Str :$host = '0.0.0.0', Int :$port = 10000) is export {
    my $application = route {
        get -> {
            response.status = 404;
            content 'text/html', 'Not found';
        }

        get -> $tpe, $id {
            my $rsc = $store.read: $tpe, $id;
            response.status = 404 unless $rsc;
            content 'application/fhir+json', $rsc;
        }

        get -> $tpe, $id, "_history", $vid {
            my $rsc = $store.vread: $tpe, $id, +$vid;
            response.status = 404 unless $rsc;
            content 'application/fhir+json', $rsc;
        }

        post -> $tpe {
            request-body -> $body {
                my Str $id = $store.insert($body);
                response.status = 201;
                response.append-header: Cro::HTTP::Header.new: :name<Location>, :value($id);
            }
        }

        put -> $tpe, $id {
            request-body -> $body {
                my OperationOutcome $outcome = $store.update($body.clone: :$id);
                response.status = 201;
                response.append-header: Cro::HTTP::Header.new: :name<Location>, :value($id);
                content 'application/fhir+json', $outcome;
            }
        }

        delete -> $tpe, $id {
            my $outcome = $store.delete: $tpe, $id;
            response.status = 200;
            content 'application/fhir+json', $outcome;
        }
    }

    my Cro::Service $service = Cro::HTTP::Server.new: :$host, :$port, :$application,
            body-parsers => [ FHIRJsonParser ], body-serializers => [ FHIRJsonSerializer ];

    $service.start;

    react whenever signal(SIGINT) {
        $service.stop;
        put "shutting down FHIR server on $host $port";
        exit;
    }

    $service;
}