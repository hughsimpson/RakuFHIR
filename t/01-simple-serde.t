use Test;
use JSON::Fast;
use lib 'lib';
use Base;
use DomainModel;
use JsonSerdes;

plan 2;

my UsageContext $x .= new(:code(Coding.new(:code("asd"), :system("dsa"))), :value(Reference.new(:reference("asdsd")) but ReferenceChoice));
my $expected-json = '{"code": {"code": "asd","system": "dsa"},"valueReference": {"reference": "asdsd"}}';
my $encoded-x = jencode $x;
my $normalised-encoded-x = to-json :sorted-keys, from-json $encoded-x;
my $normalised-expected-json = to-json :sorted-keys, from-json $encoded-x;

is $normalised-encoded-x, $normalised-expected-json, "serialized UsageContext matches expected json";
my $decoded = jdecodeAs $encoded-x, UsageContext;
is-deeply $decoded, $x, "Deserializing restores the same object";