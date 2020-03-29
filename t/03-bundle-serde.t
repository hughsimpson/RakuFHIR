use v6.d;
use lib 'lib';

use JSON::Fast;
use Test;

use FHIR::Base;
use FHIR::DomainModel;
use FHIR::JsonSerdes;

plan 2;

my $b-str = slurp './resources/bundle.json';
my Bundle $bundle = jdecode $b-str;
my $bundle-json = from-json $b-str;
my $x = $bundle.entry[0].resource.identifier[0].system;
put $x;
is $x, "https://fhir.bbl.health/sid/babylon-patient-id", "the fields are all there";
is to-json(:sorted-keys, $bundle-json), to-json(:sorted-keys, from-json jencode $bundle), "nothing is lost in round-trip";

done-testing;
