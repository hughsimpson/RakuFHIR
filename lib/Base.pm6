use JSON::Fast;

unit module Base;

subset Markdown of Str is export;
subset Base64Binary of Buf is export;
subset Canonical of Str is export;
subset Code of Str is export;
subset Id of Str is export;
subset OID of Str is export;
subset UriStr of Str is export;
subset UrlStr of Str is export;
subset UUID of Str is export;
subset XHTML of Str is export;

subset PositiveInt of Int is export where * > 0;
subset UnsignedInt of Int is export where * >= 0;

subset Primitive of Any is export where * ~~ Str|Real|Date|DateTime|Bool|Buf;

role FHIR is export {
    proto method resourceType(--> Str) {
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
