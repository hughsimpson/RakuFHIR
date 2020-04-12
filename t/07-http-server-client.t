#!/usr/bin/env perl6
use v6.d;

use Test;

use lib 'lib';

use FHIR::Base;
use FHIR::DomainModel;
use FHIR::JsonSerdes;
use FHIR::Client;
use FHIR::Server;
use FHIR::Store;

plan 5;

my AbstractStore $store = InMemory.new;
nok $store =:= Nil, 'store is not empty';
my $server = start init $store, :host<localhost>, :8082port;
nok $server =:= Nil, 'server is not empty';

my $p = start sleep 5;
await $p;
my SyncFHIRClient $cli .= new: :fhir-server<http://localhost:8082>;
nok $cli =:= Nil, 'client is not empty';

my Observation $obs .= new: :status<final>, :code(CodeableConcept.new: :coding([Coding.new: :code<abc>, :system<http://foo.bar/baz>]));
my $loc = $cli.create($obs);

does-ok $loc, Str, "received a string response with the id";
my Observation $retrieved = $cli.read: Observation, $loc;
ok $retrieved eqv $obs.clone(:id($loc)), "read the response back";


done-testing;