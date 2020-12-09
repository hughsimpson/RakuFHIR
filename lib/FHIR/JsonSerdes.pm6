#!/usr/bin/env perl6
use v6.d;

use JSON::Fast;
use Base64;

use FHIR::Base;
use FHIR::DomainModel;

unit module JsonSerdes;

INIT {
    initialise-coercion-methods &jdecode, &jdecodeAs, &jencode;
}

sub is-primitive-suffix(Str $s --> Bool) {
    $s ~~
            'Base64Binary'|'Boolean'|'Canonical'|'Code'|'Date'|'DateTime'|'Decimal'|'Id'|'Instant'|'Integer'|'Markdown'|
            'Oid'|'PositiveInt'|'String'|'Time'|'UnsignedInt'|'Uri'|'Url'|'Uuid'
}

        # Encoding
sub wrapWithChoice($raw, Str $suffix --> ChoiceField) is export {
    given $suffix {
        when 'Base64Binary' { $raw but Base64BinaryChoice }
        when 'Boolean' { $raw but BooleanChoice }
        when 'Canonical' { $raw but CanonicalChoice }
        when 'Code' { $raw but CodeChoice }
        when 'Date' { $raw but DateChoice }
        when 'DateTime' { $raw but DateTimeChoice }
        when 'Decimal' { $raw but DecimalChoice }
        when 'Id' { $raw but IdChoice }
        when 'Instant' { $raw but InstantChoice }
        when 'Integer' { $raw but IntegerChoice }
        when 'Markdown' { $raw but MarkdownChoice }
        when 'Oid' { $raw but OidChoice }
        when 'PositiveInt' { $raw but PositiveIntChoice }
        when 'String' { $raw but StringChoice }
        when 'Time' { $raw but TimeChoice }
        when 'UnsignedInt' { $raw but UnsignedIntChoice }
        when 'Uri' { $raw but UriChoice }
        when 'Url' { $raw but UrlChoice }
        when 'Uuid' { $raw but UuidChoice }
        when 'Address' { $raw but AddressChoice }
        when 'Age' { $raw but AgeChoice }
        when 'Annotation' { $raw but AnnotationChoice }
        when 'Attachment' { $raw but AttachmentChoice }
        when 'CodeableConcept' { $raw but CodeableConceptChoice }
        when 'Coding' { $raw but CodingChoice }
        when 'ContactPoint' { $raw but ContactPointChoice }
        when 'Count' { $raw but CountChoice }
        when 'Distance' { $raw but DistanceChoice }
        when 'Duration' { $raw but DurationChoice }
        when 'HumanName' { $raw but HumanNameChoice }
        when 'Identifier' { $raw but IdentifierChoice }
        when 'Money' { $raw but MoneyChoice }
        when 'Period' { $raw but PeriodChoice }
        when 'Quantity' { $raw but QuantityChoice }
        when 'Range' { $raw but RangeChoice }
        when 'Ratio' { $raw but RatioChoice }
        when 'Reference' { $raw but ReferenceChoice }
        when 'SampledData' { $raw but SampledDataChoice }
        when 'Signature' { $raw but SignatureChoice }
        when 'Timing' { $raw but TimingChoice }
        when 'ContactDetail' { $raw but ContactDetailChoice }
        when 'Contributor' { $raw but ContributorChoice }
        when 'DataRequirement' { $raw but DataRequirementChoice }
        when 'Expression' { $raw but ExpressionChoice }
        when 'ParameterDefinition' { $raw but ParameterDefinitionChoice }
        when 'RelatedArtifact' { $raw but RelatedArtifactChoice }
        when 'TriggerDefinition' { $raw but TriggerDefinitionChoice }
        when 'UsageContext' { $raw but UsageContextChoice }
        when 'Dosage' { $raw but DosageChoice }
        when 'Meta' { $raw but MetaChoice }
    }
}

sub fhir-obj-to-json(FHIR $obj --> Str) {
    my Str $resourceType := $obj.resourceType.defined ?? qq`"resourceType":"{$obj.resourceType}",` !! '';
    '{' ~ $resourceType ~ $obj.^attributes
            .flatmap( -> $att { valueToField $att, $att.get_value($obj)})
            .grep({.value.defined and .value !~~ Nil})
            .map({qq`"{.key}": {.value}`})
            .join(',') ~ '}'
}

multi valueToField(Attribute $att, Nil --> Array) {
    []
}

multi valueToField(Attribute $att, PrimitiveElement $v --> Array) {
    my $k := $att.name.split('!')[1];
    my $key := $v.defined && $att.type ~~ ChoiceField ?? $k ~ $v.suffix !! $k;
    my @extra-fields = [];
    if $v ~~ PrimitiveElementId {
        my $vid := $v.id;
        @extra-fields.push: q:s`"id":"$vid"`
    }
    if $v ~~ PrimitiveElementExtension {
        my $vextension := jencode $v.extension;
        @extra-fields.push: q:s`"extension":$vextension`
    };
    my $ped-str := '{' ~ @extra-fields.join(",") ~ '}';
    my Pair $extra-field := "_$key" => $ped-str;
    my Pair $field := $key => $v ~~ PhantomValue ?? Nil !! jencode $v;
    $extra-field ?? [$field, $extra-field] !! [$field];
}

multi valueToField(Attribute $att, $v --> Array) {
    my $k := $att.name.split('!')[1];
    my $key := $v.defined && $v ~~ ChoiceField ?? $k ~ $v.suffix !! $k;
    [$key => jencode $v];
}

sub jencode($fhir --> Str) is export {
    do given $fhir {
        when $_ ~~ Nil or !.defined { Nil }
        when FHIR { fhir-obj-to-json $fhir }
        when Buf { to-json encode-base64($_, :str) }
        when Date|DateTime|Bool|Numeric|Str { to-json $_ }
        when Array { $_ > 0 ??  '[' ~ .map(&jencode).join(',') ~ ']' !! Nil }
        default {
            warn "trying to encode $fhir but don't know what it is...";
            Nil
        }
    }
}

        # Decoding
sub jdecode(Str $json --> FHIR) is export {
    my %parsed := from-json $json;
    jdestructure %parsed;
}

sub jdecode-array(Str $json) is export {
    my @parsed := |from-json $json;
    @parsed.map: &jdestructure;
}

sub jdecodeAs(Str $json, FHIR:U $TARGET --> FHIR) is export {
    my %parsed := from-json $json;
    decodeAs %parsed, $TARGET;
}
multi jdec-choice(Str, Nil --> Nil) {

}
multi jdec-choice(Str $suffix, Array $x --> Array) {
    $x.map: { jdec-choice $suffix, $_ }
}
multi jdec-choice(Str $suffix, Hash $x --> ChoiceField) {
    given $suffix {
        when "Address"|"Age"|"Annotation"|"Attachment"|"CodeableConcept"|"Coding"|"ContactDetail"|"ContactPoint"|"Contributor"|
                "Count"|"DataRequirement"|"Distance"|"Dosage"|"Duration"|"Expression"|"HumanName"|"Identifier"|"Money"|
                "ParameterDefinition"|"Period"|"Quantity"|"Range"|"Ratio"|"Reference"|"RelatedArtifact"|"SampledData"|
                "Signature"|"Timing"|"TriggerDefinition"|"UsageContext" {
            wrapWithChoice (decodeAs $x, ::("DomainModel::$suffix")), $suffix
        }
        default { Nil }
    }
}
multi jdec-choice("Boolean", Bool $x --> ChoiceField) {
    $x but BooleanChoice
}
multi jdec-choice(Str $suffix, Real $x --> ChoiceField) {
    given $suffix {
        when "UnsignedInt" { $x but UnsignedIntChoice }
        when "Integer" { $x but IntegerChoice }
        when "PositiveInt" { $x but PositiveIntChoice }
        when "Decimal" { $x but DecimalChoice }
        default { die "$suffix is not a recognised choice prefix for a numeric value" }
    }
}
multi jdec-choice(Str $suffix, Str $x --> ChoiceField) {
    given $suffix {
        when "Base64Binary" { $x but Base64BinaryChoice }
        when "Canonical" { $x but CanonicalChoice }
        when "Code" { $x but CodeChoice }
        when "Id" { $x but IdChoice }
        when "Markdown" { $x but MarkdownChoice }
        when "String" { $x but StringChoice }
        when "Oid" { $x but OidChoice }
        when "Uri" { $x but UriChoice }
        when "Url" { $x but UrlChoice }
        when "Uuid" { $x but UuidChoice }
        when "Date" { dec-date($x) but DateChoice }
        when "Instant" { DateTime.new($x, :formatter(&dt-formatter)) but InstantChoice }
        when "Time" { Instant.new($x) but TimeChoice }
        when "DateTime" { dec-datetime($x) but DateTimeChoice }
        default { die "$suffix is not a recognised choice prefix for a stringy value" }
    }
}
multi jdec-choice(Str $suffix, $x --> ChoiceField) {
    die "$suffix is not a recognised choice prefix for $x"
}
sub dec-date(Str $s --> Date) {
    given $s {
        when /^ \d ** 4 $/ { Date.new: +$s, 1, 1, formatter => { sprintf "%04d", .year } }
        when /^ \d ** 4 '-' \d ** 2 $/ { Date.new: $s ~ '-01', formatter => { sprintf "%04d-%02d", .year, .month } }
        default { Date.new: $s }
    }
}
sub mk-dt-formatter(Int $second-resolution --> Block) {
    my Str $fmt-str := $second-resolution == 0 ??
            '%04d-%02d-%02dT%02d:%02d:%02d%s' !!
            q:c`%04d-%02d-%02dT%02d:%02d:%0{$second-resolution + 3}.{$second-resolution}f%s`;
    -> DateTime $_ { sprintf $fmt-str, .year, .month, .day, .hour, .minute, .second, .&dt-offset }
}
my &dt-formatter := mk-dt-formatter 3;
sub dt-offset(DateTime $d --> Str) {
    given $d.offset-in-hours {
        when 0 { 'Z' }
#        when * % 1 { ... } # TODO -- minute offsets
        when * > 0 { sprintf "+%02d:00", $_ }
        when * < 0 { sprintf "%03d:00", $_ }
    }
}
sub dec-datetime(Str $s --> DateTime) {
    given $s {
        when /^ \d ** 4 $/ { DateTime.new: +$s, 1, 1, 0, 0, 0, formatter => { sprintf "%04d", .year } }
        when /^ (\d ** 4) '-' (\d ** 2) $/ { DateTime.new: $0, $1, 1, 0, 0, 0, formatter => { sprintf "%04d-%02d", .year, .month } }
        when /^(\d ** 4) '-' (\d ** 2) '-' (\d ** 2) $/ { DateTime.new: $0, $1, $2, 0, 0, 0, formatter => { sprintf "%04d-%02d-%02d", .year, .month, .day } }
        when /^ \d ** 4 '-' \d\d '-' \d\d 'T' \d\d ':' \d\d ':' \d\d ['Z' | '-' .+ | '+' .+]  $/ { DateTime.new: $s, formatter => mk-dt-formatter(0) }
        when /^ \d ** 4 '-' \d\d '-' \d\d 'T' \d\d ':' \d\d ':' \d\d '.' (\d+) ['Z' | '-' .+ | '+' .+]  $/ { DateTime.new: $s, formatter => mk-dt-formatter(+(~$0).comb) }
        default { DateTime.new: $s, formatter => &dt-formatter }
    }
}
multi jdec-arg(Hash $x) {
    jdestructure $x;
}
multi jdec-arg(Array $x) {
    $x.map: &jdec-arg;
}
multi jdec-arg($x) {
    $x;
}
sub jdestructure(%json --> FHIR) is export {
    my $resourceType := %json<resourceType>;
    die 'We cannot generically destructure FHIR without a resource type' unless $resourceType;
    my @mps = %json<meta><profile>.grep(?*);
    my $CONSTRUCTOR;
    # TODO: Order @mps first
    for @mps.map(*.split("/")[*-1]) {
        $CONSTRUCTOR //= ::("DomainModel::$_");
    }
    $CONSTRUCTOR //= ::("DomainModel::$resourceType");
    CATCH { default { put "failed to build a1  ";
    .say;}}
    CONTROL { default { put "failed to build a2";
    .say;}}
    decodeAs %json, $CONSTRUCTOR;
}
multi decodeAs(Array:D $json, Positional:U $CONSTRUCTOR --> Slip:D) {
    |@$json.map: { decodeAs $_, $CONSTRUCTOR.of }
}
multi decodeAs(Hash:D $json, FHIR:U $CONSTRUCTOR --> FHIR:D) {
    decodeAsHash $json, $CONSTRUCTOR
}
multi decodeAs(Any:D $json, $TPE) {
    given $TPE {
        when Base64Binary { decode-base64($json, :bin) }
        when Canonical | FHIRCode | Id | Markdown | Str | OID | UriStr | UrlStr | Uuid { $json }
        when Real { $json }
        when Bool { $json }
        when Date { dec-date($json) }
        # TODO: This
        #        when Time { Instant.new($json) }
        when DateTime { dec-datetime $json }
        default { die "can't understand what a $TPE is" }
    }
}

sub decodeAsHash(Hash:D $json, FHIR:U $CONSTRUCTOR --> FHIR:D) {
    my %args := {};
    my @atts = $CONSTRUCTOR.^attributes;
    my %atts := @atts.categorize({.type ~~ ChoiceField});
    if %atts{False} {for @(%atts{False}) -> $att {
        my ($sig, $key) := $att.name.split('!');
        my $val = $json{$key};
        if $att.type ~~ Primitive {
            my $el_val := $json{"_$key"};
            if $el_val {
                my $id := $el_val<id>;
                my Extension @extension = |$el_val<extension>.grep(?*).map: { decodeAs $_, Extension }
                if not $val.defined {
                    for @extension
                            .grep(*.url eq 'http://hl7.org/fhir/StructureDefinition/structuredefinition-json-type')
                            .map(*.value)
                            .grep(* ~~ $att.type) { $val = $_ but PhantomValue }
                }
                my $decoded = decodeAs $val, $att.type;
                if $decoded.defined {
                    if $id.defined { $decoded = $decoded but PrimitiveElementId(:$id) }
                    if @extension { $decoded = $decoded but PrimitiveElementExtension(:@extension) }
                    %args{$key} := $decoded;
                }
            } elsif $val.defined {
                %args{$key} := decodeAs $val, $att.type;
            }
        }
        elsif $att.type ~~ Resource {
            given $val {
                when Array { %args{$key} := $val.map: &jdestructure  }
                when Hash { %args{$key} := jdestructure $val }
            }
        }
        elsif $val.defined {
            %args{$key} := decodeAs $val, $att.type;
        }
    }}
    if %atts{True} {for @(%atts{True}) -> $att {
        my ($sig, $key) := $att.name.split('!');
        my @candidates = $json.keys.grep: {.starts-with($key)}
        my @el_candidates = $json.keys.grep: {.starts-with("_$key")}
        my @suffixes = unique |@candidates.map(*.subst($key,'')), |@el_candidates.map(*.subst("_$key",''));
        # TODO: For now assume that it's invalid for another field to start with the name of a choice field
        given @suffixes.head {
            if .defined {
                my $full-key := $key ~ $_;
                my $val = $json{$full-key};
                my $el_val := is-primitive-suffix($_) && $json{"_$full-key"};
                my Str $id;
                my Extension @extension;
                if $el_val {
                    $id = $el_val<id>;
                    @extension = |$el_val<extension>.grep(?*).map: { decodeAs $_, Extension};
                    if not $val.defined {
                        for @extension
                                .grep(*.url eq 'http://hl7.org/fhir/StructureDefinition/structuredefinition-json-type')
                                .map(*.value)
                                .grep(* ~~ $att.type) { $val = $_ but PhantomValue }
                    }
                }
                my $res = jdec-choice $_, $val;
                if $res.defined {
                    if $id.defined { $res = $res but PrimitiveElementId(:$id) }
                    if @extension { $res = $res but PrimitiveElementExtension(:@extension) }
                    %args{$key} = $res;
                }
            }
        }
    }}
    %args .= grep(*.value.defined);
    CATCH { default { .say;
    put "failed to build a3 {$CONSTRUCTOR.^name} with {(try to-json %args) or "<failed>"} from {(try to-json $json) or "<failed>"} "}}
    CONTROL { default { .say;
    put "failed to build a4 {$CONSTRUCTOR.^name} with {try to-json %args or "<failed>"} from {(try to-json $json) or "<failed>"} "}}
    $CONSTRUCTOR.new(|%args.Map) || Nil;
}
