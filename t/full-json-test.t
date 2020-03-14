use Test;
use JSON::Fast;

use lib 'lib';
use Base;
use DomainModel;
use JsonSerdes;

constant DEBUG = False;

sub normalise-json(Str $s) {
    my $x = from-json $s.subst( '.000', '');
    # We set ms precision, which isn't in some of the input json, so here we normalise to stop the tests throwing spurious failures on every 'date' field
    to-json :sorted-keys, $x
}

sub test-model(IO::Path $loc) {
    put "looking at {$loc.basename}";
    my Str $slurped = $loc.slurp;
    my Str $normalised = normalise-json $slurped;
    my StructureDefinition $decoded = jdecode $slurped;
    my Str $encoded = normalise-json jencode $decoded;
    if $decoded.kind ~~ 'primitive-type' {
        is "", "", "{$loc.basename} skipped, since primitive";
    } else {
        if DEBUG {
            spurt "encoded.json", $encoded;
            spurt "orig.json", $normalised;
            is qx`jd orig.json encoded.json`, "", "{$loc.basename} works";
        } else {
            is $encoded, $normalised, "{$loc.basename} works";
        }
    }
    #    is $encoded, $normalised;
}

put 'loading defs';
my IO::Path @models = grep { /.+ '.json'$/ }, |'./resources'.IO.dir;

put "prepped for {+@models} models";

plan +@models;

my $start = now;
for @models -> $model {
    test-model $model;
}
my $end = now;

put "Done in {$end - $start}s";

done-testing;
