use Test;

use lib 'lib';
use Base;
use DomainModel;

plan 20;

my $undecorated = 'asd';

nok $undecorated ~~ PrimitiveElement, "Undecorated element should not match (PrimitiveElement)";

my $id = 'ID-123';
my $withId = 'asd' but PrimitiveElementId(:$id);

is $withId, $undecorated, "Under normal operation, primitive element ids should be ignored";
does-ok $withId, PrimitiveElement, "Decorated element with id should match (PrimitiveElement)";
does-ok $withId, PrimitiveElementId, "Decorated element with id should do (PrimitiveElementId)";
is $withId.id, $id, "Id of PrimitiveElementId element should be retrievable with .id";

my Extension $ext1 .= new: :url('http://example.com'), :value(123 but PositiveIntChoice);
my Extension $ext2 .= new: :url('http://example.com/foobar'), :value(123 but UnsignedIntChoice);
my Extension @extension = $ext1, $ext2;

my $withExtensions = 'asd' but PrimitiveElementExtension(:@extension);

is $withExtensions, $undecorated, "Under normal operation, primitive element extensions should be ignored";
does-ok $withExtensions, PrimitiveElement, "Decorated element with extensions should match (PrimitiveElement)";
does-ok $withExtensions, PrimitiveElementExtension, "Decorated element with extensions should do (PrimitiveElementExtension)";
ok $withExtensions ~~ PrimitiveElement, "smart match works as expected (PrimitiveElementExtension ~~ PrimitiveElement)";
is-deeply $withExtensions.extension, @extension, "Extensions of PrimitiveElementExtension element should be retrievable with .extension";

my $withBoth = ('asd' but PrimitiveElementId(:$id)) but PrimitiveElementExtension(:@extension);
is $withBoth, $undecorated, "Under normal operation, primitive element with both id and extension specified should still act as the primitive value";
does-ok $withBoth, PrimitiveElement, "Decorated element with id+extension should match (PrimitiveElement)";
does-ok $withBoth, PrimitiveElementId, "Decorated element with id+extension should do (PrimitiveElementId)";
does-ok $withBoth, PrimitiveElementExtension, "Decorated element with id+extension should do (PrimitiveElementExtension)";
is $withBoth.id, $id, "Id of element with id+extension should be retrievable with .id";
is-deeply $withBoth.extension, @extension, "Extensions of element with id+extension should be retrievable with .extension";

# Naively we would want to do
#my Str $empty = Str but PrimitiveElementId(:$id);
# however, we can't mix roles into undefined objects.
my $empty = PrimitiveElementId.new(:$id);
nok $empty ~~ Primitive, "Empty element is not a Primitive";
does-ok $empty, PrimitiveElement, "Decorated empty element with id should match (PrimitiveElement)";
does-ok $empty, PrimitiveElementId, "Decorated empty element with id should do (PrimitiveElementId)";
is $empty.id, $id, "Id of empty PrimitiveElementId element should be retrievable with .id";



done-testing;