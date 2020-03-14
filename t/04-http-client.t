use Test;

use FHIR::Client;

plan 1;

my FHIRClient $cli .= new: :base-uri<http://localhost:9091>;

is $cli, '', 'cli is empty string???';

done-testing;