#!/usr/bin/env perl6
use v6.d;

use Test;

use lib 'lib';

use FHIR::Server;
use FHIR::Store;

plan 2;

my SyncFHIRClient $sync-cli .= new: :fhir-server<http://localhost:9091>;
my AbstractStore $store = InMemory.new;
nok $store =:= Nil, 'store is not empty';
my $server = start $store, :8082port;
nok $server =:= Nil, 'server is not empty';

done-testing;