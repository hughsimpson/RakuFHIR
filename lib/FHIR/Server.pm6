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

#sub type-from-string(Str $tpe --> Resource:U) {
#    ::("DomainModel::$tpe")
#}

sub init(AbstractStore $store, Str :$host = '0.0.0.0', Int :$port = 10000) is export {
    my $application = route {
        get -> {
            response.status = 404;
            content 'text/html', 'Not found';
        }

        get -> $tpe, $id {
            content 'application/fhir+json', $store.read($tpe, $id);
        }

        post -> $tpe {
            request-body -> $body {
                my Str $id = $store.insert($body);
                response.status = 201;
                response.append-header: Cro::HTTP::Header.new: :name<Location>, :value($id);
            }
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