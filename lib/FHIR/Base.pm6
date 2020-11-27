#!/usr/bin/env perl6
use v6.d;

use JSON::Fast;

unit module Base;

subset Base64Binary of Buf is export;

subset Markdown of Str is export;
subset Canonical of Str is export;
subset FHIRCode of Str is export;
subset Id of Str is export;
subset OID of Str is export;
subset UriStr of Str is export;
subset UrlStr of Str is export;
subset Uuid of Str is export;
subset XHTML of Str is export;

subset PositiveInt of Int is export where * > 0;
subset UnsignedInt of Int is export where * >= 0;

subset Primitive of Any is export where * ~~ Str|Real|Date|DateTime|Bool|Buf;

my $RscType;
my $ElemType;
sub Rsc {
    return $RscType if $RscType;
    require ::FHIR::DomainModel;
    $RscType = ::('DomainModel::Resource');
    $RscType
};
sub Elem {
    return $ElemType if $ElemType;
    require ::FHIR::DomainModel;
    $ElemType = ::('DomainModel::Element');
    $ElemType
};
my &encoder;
my &decoder;
my &decoderAs;

role FHIR is export {
    proto method resourceType(--> Str) {}
    sub dec(Str $s) {
        return decoder $s if &decoder;
        require ::FHIR::JsonSerdes <&jdecode>;
        &decoder = &jdecode;
        decoder $s
    };
    sub decAs(Str $s, FHIR:U $c) {
        return decoderAs $s, $c if &decoderAs;
        require ::FHIR::JsonSerdes <&jdecodeAs>;
        &decoderAs = &jdecodeAs;
        decoderAs $s, $c
    };
    sub enc(FHIR:D $fhir) {
        return encoder $fhir if &encoder;
        require ::FHIR::JsonSerdes <&jencode>;
        &encoder = &jencode;
        encoder $fhir
    }
    multi method COERCE(Str $value) {
        if self ~~ Rsc() { dec $value }
        elsif self ~~ Elem() { decAs $value, self }
        else { die "Cannot convert Str to {self.raku} (self ~~ {Rsc().raku}) = {self ~~ Rsc()}; self ~~ {Elem().raku}) = {self ~~ Elem()})" }
    }
    multi method COERCE($value) {
        do given $value {
            when [Str, FHIR:U] { decAs .[0], .[1] }
            when [FHIR:U, Str] { decAs .[1], .[0] }
            default { die "Cannot convert $_ to FHIR" }
        }
    }
    method Str {
        enc(self);
    }
}


role ChoiceField is export {
    proto method suffix(){
        ;
    }
}
role Base64BinaryChoice  does ChoiceField is export {
    method suffix(--> 'Base64Binary'){
        ;
    }
}
role BooleanChoice  does ChoiceField is export {
    method suffix(--> 'Boolean'){
        ;
    }
}
role CanonicalChoice  does ChoiceField is export {
    method suffix(--> 'Canonical'){
        ;
    }
}
role CodeChoice  does ChoiceField is export {
    method suffix(--> 'Code'){
        ;
    }
}
role DateChoice  does ChoiceField is export {
    method suffix(--> 'Date'){
        ;
    }
}
role DateTimeChoice  does ChoiceField is export {
    method suffix(--> 'DateTime'){
        ;
    }
}
role DecimalChoice  does ChoiceField is export {
    method suffix(--> 'Decimal'){
        ;
    }
}
role IdChoice  does ChoiceField is export {
    method suffix(--> 'Id'){
        ;
    }
}
role InstantChoice  does ChoiceField is export {
    method suffix(--> 'Instant'){
        ;
    }
}
role IntegerChoice  does ChoiceField is export {
    method suffix(--> 'Integer'){
        ;
    }
}
role MarkdownChoice  does ChoiceField is export {
    method suffix(--> 'Markdown'){
        ;
    }
}
role OidChoice  does ChoiceField is export {
    method suffix(--> 'Oid'){
        ;
    }
}
role PositiveIntChoice  does ChoiceField is export {
    method suffix(--> 'PositiveInt'){
        ;
    }
}
role StringChoice  does ChoiceField is export {
    method suffix(--> 'String'){
        ;
    }
}
role TimeChoice  does ChoiceField is export {
    method suffix(--> 'Time'){
        ;
    }
}
role UnsignedIntChoice  does ChoiceField is export {
    method suffix(--> 'UnsignedInt'){
        ;
    }
}
role UriChoice  does ChoiceField is export {
    method suffix(--> 'Uri'){
        ;
    }
}
role UrlChoice  does ChoiceField is export {
    method suffix(--> 'Url'){
        ;
    }
}
role UuidChoice  does ChoiceField is export {
    method suffix(--> 'Uuid'){
        ;
    }
}
role AddressChoice  does ChoiceField is export {
    method suffix(--> 'Address'){
        ;
    }
}
role AgeChoice  does ChoiceField is export {
    method suffix(--> 'Age'){
        ;
    }
}
role AnnotationChoice  does ChoiceField is export {
    method suffix(--> 'Annotation'){
        ;
    }
}
role AttachmentChoice  does ChoiceField is export {
    method suffix(--> 'Attachment'){
        ;
    }
}
role CodeableConceptChoice  does ChoiceField is export {
    method suffix(--> 'CodeableConcept'){
        ;
    }
}
role CodingChoice  does ChoiceField is export {
    method suffix(--> 'Coding'){
        ;
    }
}
role ContactPointChoice  does ChoiceField is export {
    method suffix(--> 'ContactPoint'){
        ;
    }
}
role CountChoice  does ChoiceField is export {
    method suffix(--> 'Count'){
        ;
    }
}
role DistanceChoice  does ChoiceField is export {
    method suffix(--> 'Distance'){
        ;
    }
}
role DurationChoice  does ChoiceField is export {
    method suffix(--> 'Duration'){
        ;
    }
}
role HumanNameChoice  does ChoiceField is export {
    method suffix(--> 'HumanName'){
        ;
    }
}
role IdentifierChoice  does ChoiceField is export {
    method suffix(--> 'Identifier'){
        ;
    }
}
role MoneyChoice  does ChoiceField is export {
    method suffix(--> 'Money'){
        ;
    }
}
role PeriodChoice  does ChoiceField is export {
    method suffix(--> 'Period'){
        ;
    }
}
role QuantityChoice  does ChoiceField is export {
    method suffix(--> 'Quantity'){
        ;
    }
}
role RangeChoice  does ChoiceField is export {
    method suffix(--> 'Range'){
        ;
    }
}
role RatioChoice  does ChoiceField is export {
    method suffix(--> 'Ratio'){
        ;
    }
}
role ReferenceChoice  does ChoiceField is export {
    method suffix(--> 'Reference'){
        ;
    }
}
role SampledDataChoice  does ChoiceField is export {
    method suffix(--> 'SampledData'){
        ;
    }
}
role SignatureChoice  does ChoiceField is export {
    method suffix(--> 'Signature'){
        ;
    }
}
role TimingChoice  does ChoiceField is export {
    method suffix(--> 'Timing'){
        ;
    }
}
role ContactDetailChoice  does ChoiceField is export {
    method suffix(--> 'ContactDetail'){
        ;
    }
}
role ContributorChoice  does ChoiceField is export {
    method suffix(--> 'Contributor'){
        ;
    }
}
role DataRequirementChoice  does ChoiceField is export {
    method suffix(--> 'DataRequirement'){
        ;
    }
}
role ExpressionChoice  does ChoiceField is export {
    method suffix(--> 'Expression'){
        ;
    }
}
role ParameterDefinitionChoice  does ChoiceField is export {
    method suffix(--> 'ParameterDefinition'){
        ;
    }
}
role RelatedArtifactChoice  does ChoiceField is export {
    method suffix(--> 'RelatedArtifact'){
        ;
    }
}
role TriggerDefinitionChoice  does ChoiceField is export {
    method suffix(--> 'TriggerDefinition'){
        ;
    }
}
role UsageContextChoice  does ChoiceField is export {
    method suffix(--> 'UsageContext'){
        ;
    }
}
role DosageChoice  does ChoiceField is export {
    method suffix(--> 'Dosage'){
        ;
    }
}
role MetaChoice  does ChoiceField is export {
    method suffix(--> 'Meta'){
        ;
    }
}
