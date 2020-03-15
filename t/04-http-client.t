use v6.d;
use lib 'lib';

use Test;

use FHIR::Base;
use FHIR::Client;

plan 1;

my AsyncFHIRClient $cli .= new: :base-uri<http://localhost:9091>;

nok $cli eq '', 'cli is empty string???';

done-testing;