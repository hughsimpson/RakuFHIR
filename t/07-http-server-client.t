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

plan 10;

# Initialise server
my AbstractStore $store = InMemory.new;
nok $store =:= Nil, 'store is not empty';
my $server = start init $store, :host<localhost>, :8082port;
nok $server =:= Nil, 'server is not empty';
my $p = start sleep 5;
await $p;

# Initialise client
my SyncFHIRClient $cli .= new: :fhir-server<http://localhost:8082>;
nok $cli =:= Nil, 'client is not empty';

# Test resource creation
my Observation $obs .= new: :status<final>, :code(CodeableConcept.new: :coding([Coding.new: :code<abc>, :system<http://foo.bar/baz>]));
my $loc = $cli.create($obs);
does-ok $loc, Str, "received a string response with the id";

# Test resource retrieval
my Observation $obs-with-id = $obs.clone(:id($loc));
my Observation $r = $cli.read: Observation, $loc;
ok $r eqv $obs-with-id, "read the response back (1)";

# Test resource version retrieval
my Observation $retrieved2 = $cli.vread: Observation, $loc, ~0;
ok $retrieved2 eqv $obs-with-id, "read the versioned response back (1)";

# Test resource version update
my Observation $updated = $obs-with-id.clone: :method(CodeableConcept.new: :text<foooooo>);
my OperationOutcome $r3 = $cli.update: $updated;
my OperationOutcome $expected-outcome = OperationOutcome.new:
        issue => [OperationOutcome_Issue.new: :code<informational>, :severity<information>, :diagnostics("New version id is 1")];
ok $r3 eqv $expected-outcome, "get the OperationOutcome back";

# Test resource retrieval
my Observation $r4 = $cli.read: Observation, $loc;
ok $r4 eqv $updated, "read the response back (2)";

# Test resource version retrieval
my Observation $r5 = $cli.vread: Observation, $loc, ~0;
my Observation $r6 = $cli.vread: Observation, $loc, ~1;
ok $r5 eqv $r, "read the versioned response back (2)";
ok $r6 eqv $updated, "read the versioned response back (3)";

done-testing;
