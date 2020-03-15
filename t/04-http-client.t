use v6.d;
use lib 'lib';

use Test;

use FHIR::Base;
use FHIR::Client;

plan 2;

my &fetch-token = { "Bearer " }
my AsyncFHIRClient $cli .= new: :fhir-server<http://localhost:9091>, ;
my SyncFHIRClient $sync-cli .= new: :fhir-server<http://localhost:9091>;

nok $cli eq '', 'cli is empty string???';
nok $sync-cli eq '', 'sync-cli is empty string???';

done-testing;