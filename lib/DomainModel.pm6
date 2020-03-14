use Base;

unit module DomainModel;

class Extension { ... }
class Meta { ... }
class Coding { ... }
class Attachment { ... }
class Quantity { ... }
class Identifier { ... }
class ContactDetail { ... }
class ContactPoint { ... }
class ElementDefinition { ... }
class Dosage { ... }
class TestReport_Setup_Action_Assert { ... }
class TestReport_Setup_Action_Operation { ... }
class TestScript_Setup_Action_Assert { ... }
class TestScript_Setup_Action_Operation { ... }
class ExampleScenario_Instance_ContainedInstance { ... }
class ExampleScenario_Process_Step { ... }
class ExampleScenario_Process { ... }
class Observation_ReferenceRange { ... }
class QuestionnaireResponse_Item { ... }
class GraphDefinition_Link { ... }
class MedicinalProductIngredient_SpecifiedSubstance_Strength { ... }
class ValueSet_Compose_Include_Concept_Designation { ... }
class Address  { ... }
class Age  { ... }
class CodeableConcept  { ... }
class Contributor  { ... }
class Count  { ... }
class DataRequirement  { ... }
class Distance  { ... }
class Expression  { ... }
class HumanName  { ... }
class Money  { ... }
class ParameterDefinition  { ... }
class Ratio  { ... }
class Reference  { ... }
class Timing  { ... }
class TriggerDefinition  { ... }

role PrimitiveElement is export { }
role PrimitiveElementId does PrimitiveElement is export { has Str $.id  }
role PrimitiveElementExtension does PrimitiveElement is export { has Array[::Extension] $.extension }
role PhantomValue is export { }

class Resource is FHIR is export {
  method resourceType(--> 'Resource') {}
  has Id $.id;
  has Meta $.meta;
  has Code $.language;
  has UriStr $.implicitRules;
}

class Element is FHIR is export {
  has Str $.id;
  has Extension @.extension;
}

class UsageContext is Element is export {
  has Coding $.code is required;
  has ChoiceField $.value is required where CodeableConcept|Quantity|Range|Reference;
}

class Annotation is Element is export {
  has DateTime $.time;
  has Markdown $.text is required;
  has ChoiceField $.author where Reference|Str;
}

class Period is Element is export {
  has DateTime $.end;
  has DateTime $.start;
}

class BackboneElement is Element is export {
  has Extension @.modifierExtension;
}

class RelatedArtifact is Element is export {
  has UrlStr $.url;
  has Code $.type is required;
  has Str $.label;
  has Str $.display;
  has Markdown $.citation;
  has Attachment $.document;
  has Canonical $.resource;
}

class SampledData is Element is export {
  has Str $.data;
  has Quantity $.origin is required;
  has Real $.period is required;
  has Real $.factor;
  has Real $.lowerLimit;
  has Real $.upperLimit;
  has PositiveInt $.dimensions is required;
}
class Parameters_Parameter is FHIR is export {
  has Str $.id;
  has Str $.name is required;
  has Parameters_Parameter @.part;
  has ChoiceField $.value where Address|Age|Annotation|Attachment|Base64Binary|Bool|Canonical|Code|CodeableConcept|Coding|ContactDetail|ContactPoint|Contributor|Count|DataRequirement|Distance|Dosage|Real|Duration|Expression|Date|DateTime|HumanName|Id|Identifier|Int|Instant|Markdown|Money|OID|ParameterDefinition|Period|PositiveInt|Quantity|Range|Ratio|Reference|RelatedArtifact|SampledData|Signature|Str|Timing|TriggerDefinition|UUID|UnsignedInt|UriStr|UrlStr|UsageContext|DateTime;
  has Resource $.resource;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Parameters is Resource is export {
  method resourceType(--> 'Parameters') {}
  has Parameters_Parameter @.parameter;
}

class Attachment is Element is export {
  has UrlStr $.url;
  has Base64Binary $.data;
  has UnsignedInt $.size;
  has Base64Binary $.hash;
  has Str $.title;
  has Code $.language;
  has DateTime $.creation;
  has Code $.contentType;
}
class DataRequirement_Sort is FHIR is export {
  has Str $.id;
  has Str $.path is required;
  has Extension @.extension;
  has Code $.direction is required;
}

class DataRequirement_CodeFilter is FHIR is export {
  has Str $.id;
  has Str $.path;
  has Coding @.code;
  has Canonical $.valueSet;
  has Extension @.extension;
  has Str $.searchParam;
}

class DataRequirement_DateFilter is FHIR is export {
  has Str $.id;
  has Str $.path;
  has ChoiceField $.value where Duration|DateTime|Period;
  has Extension @.extension;
  has Str $.searchParam;
}

class DataRequirement is Element is export {
  has Code $.type is required;
  has PositiveInt $.limit;
  has Canonical @.profile;
  has ChoiceField $.subject where CodeableConcept|Reference;
  has Str @.mustSupport;
  has DataRequirement_Sort @.sort;
  has DataRequirement_CodeFilter @.codeFilter;
  has DataRequirement_DateFilter @.dateFilter;
}

class Range is Element is export {
  has Quantity $.low;
  has Quantity $.high;
}

class Money is Element is export {
  has Real $.value;
  has Code $.currency;
}
class Bundle_Link is FHIR is export {
  has Str $.id;
  has UriStr $.url is required;
  has Str $.relation is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Bundle_Entry_Search is FHIR is export {
  has Str $.id;
  has Code $.mode;
  has Real $.score;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Bundle_Entry_Request is FHIR is export {
  has Str $.id;
  has UriStr $.url is required;
  has Code $.method is required;
  has Str $.ifMatch;
  has Extension @.extension;
  has Str $.ifNoneMatch;
  has Str $.ifNoneExist;
  has DateTime $.ifModifiedSince;
  has Extension @.modifierExtension;
}

class Bundle_Entry_Response is FHIR is export {
  has Str $.id;
  has Str $.etag;
  has Str $.status is required;
  has Resource $.outcome;
  has UriStr $.location;
  has Extension @.extension;
  has DateTime $.lastModified;
  has Extension @.modifierExtension;
}
class Bundle_Entry is FHIR is export {
  has Str $.id;
  has Bundle_Link @.link;
  has UriStr $.fullUrl;
  has Resource $.resource;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has Bundle_Entry_Search $.search;
  has Bundle_Entry_Request $.request;
  has Bundle_Entry_Response $.response;
}

class Bundle is Resource is export {
  method resourceType(--> 'Bundle') {}
  has Code $.type is required;
  has UnsignedInt $.total;
  has DateTime $.timestamp;
  has Signature $.signature;
  has Identifier $.identifier;
  has Bundle_Link @.link;
  has Bundle_Entry @.entry;
}

class Reference is Element is export {
  has UriStr $.type;
  has Str $.display;
  has Str $.reference;
  has Identifier $.identifier;
}

class Expression is Element is export {
  has Id $.name;
  has Code $.language is required;
  has UriStr $.reference;
  has Str $.expression;
  has Str $.description;
}

class Contributor is Element is export {
  has Code $.type is required;
  has Str $.name is required;
  has ContactDetail @.contact;
}

class Address is Element is export {
  has Code $.use;
  has Code $.type;
  has Str $.text;
  has Str @.line;
  has Str $.city;
  has Str $.state;
  has Period $.period;
  has Str $.country;
  has Str $.district;
  has Str $.postalCode;
}

class Narrative is Element is export {
  has XHTML $.div is required;
  has Code $.status is required;
}

class Quantity is Element is export {
  has Str $.unit;
  has Code $.code;
  has Real $.value;
  has UriStr $.system;
  has Code $.comparator;
}

class ContactDetail is Element is export {
  has Str $.name;
  has ContactPoint @.telecom;
}

class ContactPoint is Element is export {
  has Code $.use;
  has PositiveInt $.rank;
  has Str $.value;
  has Code $.system;
  has Period $.period;
}

class CodeableConcept is Element is export {
  has Str $.text;
  has Coding @.coding;
}

class Coding is Element is export {
  has Code $.code;
  has UriStr $.system;
  has Str $.version;
  has Str $.display;
  has Bool $.userSelected;
}

class ParameterDefinition is Element is export {
  has Code $.use is required;
  has Int $.min;
  has Str $.max;
  has Code $.name;
  has Code $.type is required;
  has Canonical $.profile;
  has Str $.documentation;
}

class Ratio is Element is export {
  has Quantity $.numerator;
  has Quantity $.denominator;
}

class Binary is Resource is export {
  method resourceType(--> 'Binary') {}
  has Base64Binary $.data;
  has Code $.contentType is required;
  has Reference $.securityContext;
}

class Extension is Element is export {
  has Str $.url is required;
  has ChoiceField $.value where Address|Age|Annotation|Attachment|Base64Binary|Bool|Canonical|Code|CodeableConcept|Coding|ContactDetail|ContactPoint|Contributor|Count|DataRequirement|Distance|Dosage|Real|Duration|Expression|Date|DateTime|HumanName|Id|Identifier|Int|Instant|Markdown|Money|OID|ParameterDefinition|Period|PositiveInt|Quantity|Range|Ratio|Reference|RelatedArtifact|SampledData|Signature|Str|Timing|TriggerDefinition|UUID|UnsignedInt|UriStr|UrlStr|UsageContext|DateTime;
}

class Signature is Element is export {
  has Reference $.who is required;
  has Coding @.type is required;
  has DateTime $.when is required;
  has Base64Binary $.data;
  has Code $.sigFormat;
  has Reference $.onBehalfOf;
  has Code $.targetFormat;
}

class DomainResource is Resource is export {
  method resourceType(--> 'DomainResource') {}
  has Narrative $.text;
  has Resource @.contained;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Identifier is Element is export {
  has Code $.use;
  has CodeableConcept $.type;
  has Str $.value;
  has UriStr $.system;
  has Period $.period;
  has Reference $.assigner;
}

class Meta is Element is export {
  has Coding @.tag;
  has UriStr $.source;
  has Canonical @.profile;
  has Coding @.security;
  has Id $.versionId;
  has DateTime $.lastUpdated;
}

class TriggerDefinition is Element is export {
  has Code $.type is required;
  has Str $.name;
  has DataRequirement @.data;
  has ChoiceField $.timing where Date|DateTime|Reference|Timing;
  has Expression $.condition;
}

class HumanName is Element is export {
  has Code $.use;
  has Str $.text;
  has Str @.given;
  has Str $.family;
  has Str @.prefix;
  has Str @.suffix;
  has Period $.period;
}

class PaymentNotice is DomainResource is export {
  method resourceType(--> 'PaymentNotice') {}
  has Reference $.payee;
  has Code $.status is required;
  has Money $.amount is required;
  has Reference $.request;
  has DateTime $.created is required;
  has Reference $.payment is required;
  has Reference $.response;
  has Reference $.provider;
  has Reference $.recipient is required;
  has Identifier @.identifier;
  has Date $.paymentDate;
  has CodeableConcept $.paymentStatus;
}
class AllergyIntolerance_Reaction is FHIR is export {
  has Str $.id;
  has Annotation @.note;
  has DateTime $.onset;
  has Code $.severity;
  has Extension @.extension;
  has CodeableConcept $.substance;
  has Str $.description;
  has CodeableConcept @.manifestation is required;
  has CodeableConcept $.exposureRoute;
  has Extension @.modifierExtension;
}

class AllergyIntolerance is DomainResource is export {
  method resourceType(--> 'AllergyIntolerance') {}
  has Code $.type;
  has CodeableConcept $.code;
  has Annotation @.note;
  has Reference $.patient is required;
  has Code @.category;
  has ChoiceField $.onset where Age|DateTime|Period|Range|Str;
  has Reference $.recorder;
  has Reference $.asserter;
  has Reference $.encounter;
  has Identifier @.identifier;
  has Code $.criticality;
  has DateTime $.recordedDate;
  has CodeableConcept $.clinicalStatus;
  has DateTime $.lastOccurrence;
  has CodeableConcept $.verificationStatus;
  has AllergyIntolerance_Reaction @.reaction;
}

class EventDefinition is DomainResource is export {
  method resourceType(--> 'EventDefinition') {}
  has UriStr $.url;
  has Str $.name;
  has DateTime $.date;
  has Str $.title;
  has Str $.usage;
  has CodeableConcept @.topic;
  has Code $.status is required;
  has ContactDetail @.author;
  has ContactDetail @.editor;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has TriggerDefinition @.trigger is required;
  has Str $.subtitle;
  has ContactDetail @.reviewer;
  has ContactDetail @.endorser;
  has Str $.publisher;
  has Markdown $.copyright;
  has Identifier @.identifier;
  has ChoiceField $.subject where CodeableConcept|Reference;
  has UsageContext @.useContext;
  has Markdown $.description;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has Date $.approvalDate;
  has Date $.lastReviewDate;
  has Period $.effectivePeriod;
  has RelatedArtifact @.relatedArtifact;
}

class Evidence is DomainResource is export {
  method resourceType(--> 'Evidence') {}
  has UriStr $.url;
  has Str $.name;
  has DateTime $.date;
  has Annotation @.note;
  has Str $.title;
  has CodeableConcept @.topic;
  has Code $.status is required;
  has ContactDetail @.author;
  has ContactDetail @.editor;
  has Str $.version;
  has ContactDetail @.contact;
  has Reference @.outcome;
  has Str $.subtitle;
  has ContactDetail @.reviewer;
  has ContactDetail @.endorser;
  has Str $.publisher;
  has Markdown $.copyright;
  has Identifier @.identifier;
  has Str $.shortTitle;
  has UsageContext @.useContext;
  has Markdown $.description;
  has CodeableConcept @.jurisdiction;
  has Date $.approvalDate;
  has Date $.lastReviewDate;
  has Period $.effectivePeriod;
  has RelatedArtifact @.relatedArtifact;
  has Reference @.exposureVariant;
  has Reference $.exposureBackground is required;
}
class Substance_Instance is FHIR is export {
  has Str $.id;
  has DateTime $.expiry;
  has Quantity $.quantity;
  has Extension @.extension;
  has Identifier $.identifier;
  has Extension @.modifierExtension;
}

class Substance_Ingredient is FHIR is export {
  has Str $.id;
  has Ratio $.quantity;
  has Extension @.extension;
  has ChoiceField $.substance is required where CodeableConcept|Reference;
  has Extension @.modifierExtension;
}

class Substance is DomainResource is export {
  method resourceType(--> 'Substance') {}
  has CodeableConcept $.code is required;
  has Code $.status;
  has CodeableConcept @.category;
  has Identifier @.identifier;
  has Str $.description;
  has Substance_Instance @.instance;
  has Substance_Ingredient @.ingredient;
}

class ServiceRequest is DomainResource is export {
  method resourceType(--> 'ServiceRequest') {}
  has CodeableConcept $.code;
  has Annotation @.note;
  has Code $.status is required;
  has Code $.intent is required;
  has Reference @.basedOn;
  has Reference $.subject is required;
  has Reference @.replaces;
  has CodeableConcept @.category;
  has Code $.priority;
  has Reference @.specimen;
  has CodeableConcept @.bodySite;
  has Reference $.encounter;
  has Reference $.requester;
  has Reference @.performer;
  has Reference @.insurance;
  has Identifier @.identifier;
  has DateTime $.authoredOn;
  has CodeableConcept @.reasonCode;
  has Identifier $.requisition;
  has CodeableConcept @.orderDetail;
  has ChoiceField $.quantity where Quantity|Range|Ratio;
  has ChoiceField $.asNeeded where Bool|CodeableConcept;
  has Bool $.doNotPerform;
  has CodeableConcept @.locationCode;
  has ChoiceField $.occurrence where DateTime|Period|Timing;
  has CodeableConcept $.performerType;
  has Reference @.supportingInfo;
  has UriStr @.instantiatesUri;
  has Reference @.reasonReference;
  has Reference @.relevantHistory;
  has Reference @.locationReference;
  has Str $.patientInstruction;
  has Canonical @.instantiatesCanonical;
}
class AdverseEvent_SuspectEntity_Causality is FHIR is export {
  has Str $.id;
  has Reference $.author;
  has CodeableConcept $.method;
  has Extension @.extension;
  has CodeableConcept $.assessment;
  has Extension @.modifierExtension;
  has Str $.productRelatedness;
}
class AdverseEvent_SuspectEntity is FHIR is export {
  has Str $.id;
  has Reference $.instance is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has AdverseEvent_SuspectEntity_Causality @.causality;
}

class AdverseEvent is DomainResource is export {
  method resourceType(--> 'AdverseEvent') {}
  has DateTime $.date;
  has CodeableConcept $.event;
  has Reference @.study;
  has Reference $.subject is required;
  has CodeableConcept $.outcome;
  has CodeableConcept @.category;
  has DateTime $.detected;
  has Reference $.location;
  has CodeableConcept $.severity;
  has Reference $.recorder;
  has Code $.actuality is required;
  has Reference $.encounter;
  has Identifier $.identifier;
  has CodeableConcept $.seriousness;
  has Reference @.contributor;
  has DateTime $.recordedDate;
  has Reference @.referenceDocument;
  has Reference @.resultingCondition;
  has Reference @.subjectMedicalHistory;
  has AdverseEvent_SuspectEntity @.suspectEntity;
}
class Patient_Link is FHIR is export {
  has Str $.id;
  has Code $.type is required;
  has Reference $.other is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Patient_Contact is FHIR is export {
  has Str $.id;
  has HumanName $.name;
  has Code $.gender;
  has Period $.period;
  has ContactPoint @.telecom;
  has Address $.address;
  has Extension @.extension;
  has CodeableConcept @.relationship;
  has Reference $.organization;
  has Extension @.modifierExtension;
}

class Patient_Communication is FHIR is export {
  has Str $.id;
  has CodeableConcept $.language is required;
  has Extension @.extension;
  has Bool $.preferred;
  has Extension @.modifierExtension;
}

class Patient is DomainResource is export {
  method resourceType(--> 'Patient') {}
  has HumanName @.name;
  has Attachment @.photo;
  has Bool $.active;
  has Code $.gender;
  has ContactPoint @.telecom;
  has Address @.address;
  has Date $.birthDate;
  has Identifier @.identifier;
  has ChoiceField $.deceased where Bool|DateTime;
  has CodeableConcept $.maritalStatus;
  has ChoiceField $.multipleBirth where Bool|Int;
  has Reference @.generalPractitioner;
  has Reference $.managingOrganization;
  has Patient_Link @.link;
  has Patient_Contact @.contact;
  has Patient_Communication @.communication;
}
class Practitioner_Qualification is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code is required;
  has Period $.period;
  has Reference $.issuer;
  has Extension @.extension;
  has Identifier @.identifier;
  has Extension @.modifierExtension;
}

class Practitioner is DomainResource is export {
  method resourceType(--> 'Practitioner') {}
  has HumanName @.name;
  has Attachment @.photo;
  has Bool $.active;
  has Code $.gender;
  has ContactPoint @.telecom;
  has Address @.address;
  has Date $.birthDate;
  has Identifier @.identifier;
  has CodeableConcept @.communication;
  has Practitioner_Qualification @.qualification;
}
class MedicinalProductInteraction_Interactant is FHIR is export {
  has Str $.id;
  has ChoiceField $.item is required where CodeableConcept|Reference;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MedicinalProductInteraction is DomainResource is export {
  method resourceType(--> 'MedicinalProductInteraction') {}
  has CodeableConcept $.type;
  has CodeableConcept $.effect;
  has Reference @.subject;
  has CodeableConcept $.incidence;
  has CodeableConcept $.management;
  has Str $.description;
  has MedicinalProductInteraction_Interactant @.interactant;
}
class OperationOutcome_Issue is FHIR is export {
  has Str $.id;
  has Code $.code is required;
  has CodeableConcept $.details;
  has Code $.severity is required;
  has Str @.location;
  has Extension @.extension;
  has Str @.expression;
  has Str $.diagnostics;
  has Extension @.modifierExtension;
}

class OperationOutcome is DomainResource is export {
  method resourceType(--> 'OperationOutcome') {}
  has OperationOutcome_Issue @.issue is required;
}
class DetectedIssue_Evidence is FHIR is export {
  has Str $.id;
  has CodeableConcept @.code;
  has Reference @.detail;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class DetectedIssue_Mitigation is FHIR is export {
  has Str $.id;
  has DateTime $.date;
  has CodeableConcept $.action is required;
  has Reference $.author;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class DetectedIssue is DomainResource is export {
  method resourceType(--> 'DetectedIssue') {}
  has CodeableConcept $.code;
  has Code $.status is required;
  has Reference $.author;
  has Str $.detail;
  has Reference $.patient;
  has Code $.severity;
  has UriStr $.reference;
  has Identifier @.identifier;
  has Reference @.implicated;
  has ChoiceField $.identified where DateTime|Period;
  has DetectedIssue_Evidence @.evidence;
  has DetectedIssue_Mitigation @.mitigation;
}
class StructureDefinition_Mapping is FHIR is export {
  has Str $.id;
  has UriStr $.uri;
  has Str $.name;
  has Str $.comment;
  has Id $.identity is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class StructureDefinition_Context is FHIR is export {
  has Str $.id;
  has Code $.type is required;
  has Extension @.extension;
  has Str $.expression is required;
  has Extension @.modifierExtension;
}

class StructureDefinition_Snapshot is FHIR is export {
  has Str $.id;
  has ElementDefinition @.element is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class StructureDefinition_Differential is FHIR is export {
  has Str $.id;
  has ElementDefinition @.element is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class StructureDefinition is DomainResource is export {
  method resourceType(--> 'StructureDefinition') {}
  has UriStr $.url is required;
  has Str $.name is required;
  has DateTime $.date;
  has Code $.kind is required;
  has UriStr $.type is required;
  has Str $.title;
  has Code $.status is required;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Coding @.keyword;
  has Bool $.abstract is required;
  has Str $.publisher;
  has Markdown $.copyright;
  has Identifier @.identifier;
  has UsageContext @.useContext;
  has Code $.derivation;
  has Markdown $.description;
  has Code $.fhirVersion;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has Canonical $.baseDefinition;
  has Str @.contextInvariant;
  has StructureDefinition_Mapping @.mapping;
  has StructureDefinition_Context @.context;
  has StructureDefinition_Snapshot $.snapshot;
  has StructureDefinition_Differential $.differential;
}
class RiskEvidenceSynthesis_SampleSize is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Str $.description;
  has Int $.numberOfStudies;
  has Extension @.modifierExtension;
  has Int $.numberOfParticipants;
}

class RiskEvidenceSynthesis_RiskEstimate_PrecisionEstimate is FHIR is export {
  has Str $.id;
  has Real $.to;
  has CodeableConcept $.type;
  has Real $.from;
  has Real $.level;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class RiskEvidenceSynthesis_RiskEstimate is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Real $.value;
  has Extension @.extension;
  has Str $.description;
  has CodeableConcept $.unitOfMeasure;
  has Int $.numeratorCount;
  has Int $.denominatorCount;
  has Extension @.modifierExtension;
  has RiskEvidenceSynthesis_RiskEstimate_PrecisionEstimate @.precisionEstimate;
}

class RiskEvidenceSynthesis_Certainty_CertaintySubcomponent is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Annotation @.note;
  has CodeableConcept @.rating;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class RiskEvidenceSynthesis_Certainty is FHIR is export {
  has Str $.id;
  has Annotation @.note;
  has CodeableConcept @.rating;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has RiskEvidenceSynthesis_Certainty_CertaintySubcomponent @.certaintySubcomponent;
}

class RiskEvidenceSynthesis is DomainResource is export {
  method resourceType(--> 'RiskEvidenceSynthesis') {}
  has UriStr $.url;
  has Str $.name;
  has DateTime $.date;
  has Annotation @.note;
  has Str $.title;
  has CodeableConcept @.topic;
  has Code $.status is required;
  has ContactDetail @.author;
  has ContactDetail @.editor;
  has Str $.version;
  has ContactDetail @.contact;
  has Reference $.outcome is required;
  has ContactDetail @.reviewer;
  has ContactDetail @.endorser;
  has Reference $.exposure;
  has Str $.publisher;
  has Markdown $.copyright;
  has CodeableConcept $.studyType;
  has Identifier @.identifier;
  has UsageContext @.useContext;
  has Reference $.population is required;
  has Markdown $.description;
  has CodeableConcept @.jurisdiction;
  has Date $.approvalDate;
  has CodeableConcept $.synthesisType;
  has Date $.lastReviewDate;
  has Period $.effectivePeriod;
  has RelatedArtifact @.relatedArtifact;
  has RiskEvidenceSynthesis_SampleSize $.sampleSize;
  has RiskEvidenceSynthesis_RiskEstimate $.riskEstimate;
  has RiskEvidenceSynthesis_Certainty @.certainty;
}
class MedicationRequest_Substitution is FHIR is export {
  has Str $.id;
  has CodeableConcept $.reason;
  has Extension @.extension;
  has ChoiceField $.allowed is required where Bool|CodeableConcept;
  has Extension @.modifierExtension;
}

class MedicationRequest_DispenseRequest_InitialFill is FHIR is export {
  has Str $.id;
  has Quantity $.quantity;
  has Duration $.duration;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class MedicationRequest_DispenseRequest is FHIR is export {
  has Str $.id;
  has Quantity $.quantity;
  has Extension @.extension;
  has Reference $.performer;
  has Period $.validityPeriod;
  has Duration $.dispenseInterval;
  has Extension @.modifierExtension;
  has UnsignedInt $.numberOfRepeatsAllowed;
  has Duration $.expectedSupplyDuration;
  has MedicationRequest_DispenseRequest_InitialFill $.initialFill;
}

class MedicationRequest is DomainResource is export {
  method resourceType(--> 'MedicationRequest') {}
  has Annotation @.note;
  has Code $.status is required;
  has Code $.intent is required;
  has Reference $.subject is required;
  has Reference @.basedOn;
  has CodeableConcept @.category;
  has Code $.priority;
  has Reference $.recorder;
  has Reference $.encounter;
  has Reference $.requester;
  has Reference $.performer;
  has Reference @.insurance;
  has Identifier @.identifier;
  has DateTime $.authoredOn;
  has CodeableConcept @.reasonCode;
  has ChoiceField $.reported where Bool|Reference;
  has CodeableConcept $.statusReason;
  has Bool $.doNotPerform;
  has Reference @.eventHistory;
  has ChoiceField $.medication is required where CodeableConcept|Reference;
  has CodeableConcept $.performerType;
  has Reference @.detectedIssue;
  has Reference @.reasonReference;
  has UriStr @.instantiatesUri;
  has Identifier $.groupIdentifier;
  has Dosage @.dosageInstruction;
  has Reference $.priorPrescription;
  has CodeableConcept $.courseOfTherapyType;
  has Reference @.supportingInformation;
  has Canonical @.instantiatesCanonical;
  has MedicationRequest_Substitution $.substitution;
  has MedicationRequest_DispenseRequest $.dispenseRequest;
}
class StructureMap_Structure is FHIR is export {
  has Str $.id;
  has Canonical $.url is required;
  has Code $.mode is required;
  has Str $.alias;
  has Extension @.extension;
  has Str $.documentation;
  has Extension @.modifierExtension;
}

class StructureMap_Group_Input is FHIR is export {
  has Str $.id;
  has Id $.name is required;
  has Str $.type;
  has Code $.mode is required;
  has Extension @.extension;
  has Str $.documentation;
  has Extension @.modifierExtension;
}

class StructureMap_Group_Rule_Source is FHIR is export {
  has Str $.id;
  has Int $.min;
  has Str $.max;
  has Str $.type;
  has Str $.check;
  has Id $.context is required;
  has Str $.element;
  has Code $.listMode;
  has Id $.variable;
  has Extension @.extension;
  has Str $.condition;
  has Str $.logMessage;
  has ChoiceField $.defaultValue where Address|Age|Annotation|Attachment|Base64Binary|Bool|Canonical|Code|CodeableConcept|Coding|ContactDetail|ContactPoint|Contributor|Count|DataRequirement|Distance|Dosage|Real|Duration|Expression|Date|DateTime|HumanName|Id|Identifier|Int|Instant|Markdown|Money|OID|ParameterDefinition|Period|PositiveInt|Quantity|Range|Ratio|Reference|RelatedArtifact|SampledData|Signature|Str|Timing|TriggerDefinition|UUID|UnsignedInt|UriStr|UrlStr|UsageContext|DateTime;
  has Extension @.modifierExtension;
}

class StructureMap_Group_Rule_Dependent is FHIR is export {
  has Str $.id;
  has Id $.name is required;
  has Str @.variable is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class StructureMap_Group_Rule_Target_Parameter is FHIR is export {
  has Str $.id;
  has ChoiceField $.value is required where Bool|Real|Id|Int|Str;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class StructureMap_Group_Rule_Target is FHIR is export {
  has Str $.id;
  has Id $.context;
  has Str $.element;
  has Id $.variable;
  has Code @.listMode;
  has Extension @.extension;
  has Code $.transform;
  has Id $.listRuleId;
  has Code $.contextType;
  has Extension @.modifierExtension;
  has StructureMap_Group_Rule_Target_Parameter @.parameter;
}
class StructureMap_Group_Rule is FHIR is export {
  has Str $.id;
  has Id $.name is required;
  has StructureMap_Group_Rule @.rule;
  has Extension @.extension;
  has Str $.documentation;
  has Extension @.modifierExtension;
  has StructureMap_Group_Rule_Source @.source is required;
  has StructureMap_Group_Rule_Dependent @.dependent;
  has StructureMap_Group_Rule_Target @.target;
}
class StructureMap_Group is FHIR is export {
  has Str $.id;
  has Id $.name is required;
  has Id $.extends;
  has Code $.typeMode is required;
  has Extension @.extension;
  has Str $.documentation;
  has Extension @.modifierExtension;
  has StructureMap_Group_Input @.input is required;
  has StructureMap_Group_Rule @.rule is required;
}

class StructureMap is DomainResource is export {
  method resourceType(--> 'StructureMap') {}
  has UriStr $.url is required;
  has Str $.name is required;
  has DateTime $.date;
  has Str $.title;
  has Code $.status is required;
  has Canonical @.import;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Str $.publisher;
  has Markdown $.copyright;
  has Identifier @.identifier;
  has UsageContext @.useContext;
  has Markdown $.description;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has StructureMap_Structure @.structure;
  has StructureMap_Group @.group is required;
}
class Subscription_Channel is FHIR is export {
  has Str $.id;
  has Code $.type is required;
  has Str @.header;
  has Code $.payload;
  has UrlStr $.endpoint;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Subscription is DomainResource is export {
  method resourceType(--> 'Subscription') {}
  has DateTime $.end;
  has Str $.error;
  has Code $.status is required;
  has Str $.reason is required;
  has ContactPoint @.contact;
  has Str $.criteria is required;
  has Subscription_Channel $.channel is required;
}
class TestReport_Participant is FHIR is export {
  has Str $.id;
  has UriStr $.uri is required;
  has Code $.type is required;
  has Str $.display;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class TestReport_Test_Action is FHIR is export {
  has Str $.id;
  has TestReport_Setup_Action_Assert $.assert;
  has Extension @.extension;
  has TestReport_Setup_Action_Operation $.operation;
  has Extension @.modifierExtension;
}
class TestReport_Test is FHIR is export {
  has Str $.id;
  has Str $.name;
  has Extension @.extension;
  has Str $.description;
  has Extension @.modifierExtension;
  has TestReport_Test_Action @.action is required;
}

class TestReport_Teardown_Action is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has TestReport_Setup_Action_Operation $.operation is required;
  has Extension @.modifierExtension;
}
class TestReport_Teardown is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has TestReport_Teardown_Action @.action is required;
}

class TestReport_Setup_Action_Assert is FHIR is export {
  has Str $.id;
  has Code $.result is required;
  has Str $.detail;
  has Markdown $.message;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class TestReport_Setup_Action_Operation is FHIR is export {
  has Str $.id;
  has Code $.result is required;
  has UriStr $.detail;
  has Markdown $.message;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class TestReport_Setup_Action is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has TestReport_Setup_Action_Assert $.assert;
  has TestReport_Setup_Action_Operation $.operation;
}
class TestReport_Setup is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has TestReport_Setup_Action @.action is required;
}

class TestReport is DomainResource is export {
  method resourceType(--> 'TestReport') {}
  has Str $.name;
  has Real $.score;
  has Code $.status is required;
  has Code $.result is required;
  has Str $.tester;
  has DateTime $.issued;
  has Identifier $.identifier;
  has Reference $.testScript is required;
  has TestReport_Participant @.participant;
  has TestReport_Test @.test;
  has TestReport_Teardown $.teardown;
  has TestReport_Setup $.setup;
}

class EnrollmentResponse is DomainResource is export {
  method resourceType(--> 'EnrollmentResponse') {}
  has Code $.status;
  has Reference $.request;
  has Code $.outcome;
  has DateTime $.created;
  has Identifier @.identifier;
  has Str $.disposition;
  has Reference $.organization;
  has Reference $.requestProvider;
}
class MessageDefinition_Focus is FHIR is export {
  has Str $.id;
  has UnsignedInt $.min is required;
  has Str $.max;
  has Code $.code is required;
  has Canonical $.profile;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MessageDefinition_AllowedResponse is FHIR is export {
  has Str $.id;
  has Canonical $.message is required;
  has Extension @.extension;
  has Markdown $.situation;
  has Extension @.modifierExtension;
}

class MessageDefinition is DomainResource is export {
  method resourceType(--> 'MessageDefinition') {}
  has UriStr $.url;
  has Str $.name;
  has DateTime $.date is required;
  has Canonical $.base;
  has Str $.title;
  has Canonical @.graph;
  has Code $.status is required;
  has Canonical @.parent;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Canonical @.replaces;
  has ChoiceField $.event is required where Coding|UriStr;
  has Code $.category;
  has Str $.publisher;
  has Markdown $.copyright;
  has Identifier @.identifier;
  has UsageContext @.useContext;
  has Markdown $.description;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has Code $.responseRequired;
  has MessageDefinition_Focus @.focus;
  has MessageDefinition_AllowedResponse @.allowedResponse;
}
class MedicinalProductPharmaceutical_Characteristics is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code is required;
  has CodeableConcept $.status;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MedicinalProductPharmaceutical_RouteOfAdministration_TargetSpecies_WithdrawalPeriod is FHIR is export {
  has Str $.id;
  has Quantity $.value is required;
  has CodeableConcept $.tissue is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has Str $.supportingInformation;
}
class MedicinalProductPharmaceutical_RouteOfAdministration_TargetSpecies is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has MedicinalProductPharmaceutical_RouteOfAdministration_TargetSpecies_WithdrawalPeriod @.withdrawalPeriod;
}
class MedicinalProductPharmaceutical_RouteOfAdministration is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code is required;
  has Extension @.extension;
  has Quantity $.firstDose;
  has Quantity $.maxSingleDose;
  has Quantity $.maxDosePerDay;
  has Extension @.modifierExtension;
  has Duration $.maxTreatmentPeriod;
  has Ratio $.maxDosePerTreatmentPeriod;
  has MedicinalProductPharmaceutical_RouteOfAdministration_TargetSpecies @.targetSpecies;
}

class MedicinalProductPharmaceutical is DomainResource is export {
  method resourceType(--> 'MedicinalProductPharmaceutical') {}
  has Reference @.device;
  has Identifier @.identifier;
  has Reference @.ingredient;
  has CodeableConcept $.unitOfPresentation;
  has CodeableConcept $.administrableDoseForm is required;
  has MedicinalProductPharmaceutical_Characteristics @.characteristics;
  has MedicinalProductPharmaceutical_RouteOfAdministration @.routeOfAdministration is required;
}
class TestScript_Origin is FHIR is export {
  has Str $.id;
  has Int $.index is required;
  has Coding $.profile is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class TestScript_Fixture is FHIR is export {
  has Str $.id;
  has Reference $.resource;
  has Extension @.extension;
  has Bool $.autocreate is required;
  has Bool $.autodelete is required;
  has Extension @.modifierExtension;
}

class TestScript_Variable is FHIR is export {
  has Str $.id;
  has Str $.name is required;
  has Str $.hint;
  has Str $.path;
  has Id $.sourceId;
  has Extension @.extension;
  has Str $.expression;
  has Str $.description;
  has Str $.headerField;
  has Str $.defaultValue;
  has Extension @.modifierExtension;
}

class TestScript_Destination is FHIR is export {
  has Str $.id;
  has Int $.index is required;
  has Coding $.profile is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class TestScript_Test_Action is FHIR is export {
  has Str $.id;
  has TestScript_Setup_Action_Assert $.assert;
  has Extension @.extension;
  has TestScript_Setup_Action_Operation $.operation;
  has Extension @.modifierExtension;
}
class TestScript_Test is FHIR is export {
  has Str $.id;
  has Str $.name;
  has Extension @.extension;
  has Str $.description;
  has Extension @.modifierExtension;
  has TestScript_Test_Action @.action is required;
}

class TestScript_Teardown_Action is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has TestScript_Setup_Action_Operation $.operation is required;
  has Extension @.modifierExtension;
}
class TestScript_Teardown is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has TestScript_Teardown_Action @.action is required;
}

class TestScript_Metadata_Link is FHIR is export {
  has Str $.id;
  has UriStr $.url is required;
  has Extension @.extension;
  has Str $.description;
  has Extension @.modifierExtension;
}

class TestScript_Metadata_Capability is FHIR is export {
  has Str $.id;
  has UriStr @.link;
  has Int @.origin;
  has Bool $.required is required;
  has Extension @.extension;
  has Bool $.validated is required;
  has Str $.description;
  has Int $.destination;
  has Canonical $.capabilities is required;
  has Extension @.modifierExtension;
}
class TestScript_Metadata is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has TestScript_Metadata_Link @.link;
  has TestScript_Metadata_Capability @.capability is required;
}

class TestScript_Setup_Action_Assert is FHIR is export {
  has Str $.id;
  has Str $.path;
  has Str $.label;
  has Str $.value;
  has Code $.operator;
  has Code $.resource;
  has Code $.response;
  has Id $.sourceId;
  has Extension @.extension;
  has Code $.direction;
  has Str $.minimumId;
  has Str $.expression;
  has Str $.requestURL;
  has Str $.description;
  has Code $.contentType;
  has Str $.headerField;
  has Bool $.warningOnly is required;
  has Str $.responseCode;
  has Code $.requestMethod;
  has Bool $.navigationLinks;
  has Extension @.modifierExtension;
  has Str $.compareToSourceId;
  has Id $.validateProfileId;
  has Str $.compareToSourcePath;
  has Str $.compareToSourceExpression;
}

class TestScript_Setup_Action_Operation_RequestHeader is FHIR is export {
  has Str $.id;
  has Str $.field is required;
  has Str $.value is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class TestScript_Setup_Action_Operation is FHIR is export {
  has Str $.id;
  has Str $.url;
  has Coding $.type;
  has Str $.label;
  has Code $.accept;
  has Code $.method;
  has Int $.origin;
  has Str $.params;
  has Code $.resource;
  has Id $.sourceId;
  has Id $.targetId;
  has Extension @.extension;
  has Id $.requestId;
  has Id $.responseId;
  has Str $.description;
  has Code $.contentType;
  has Int $.destination;
  has Bool $.encodeRequestUrl is required;
  has Extension @.modifierExtension;
  has TestScript_Setup_Action_Operation_RequestHeader @.requestHeader;
}
class TestScript_Setup_Action is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has TestScript_Setup_Action_Assert $.assert;
  has TestScript_Setup_Action_Operation $.operation;
}
class TestScript_Setup is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has TestScript_Setup_Action @.action is required;
}

class TestScript is DomainResource is export {
  method resourceType(--> 'TestScript') {}
  has UriStr $.url is required;
  has Str $.name is required;
  has DateTime $.date;
  has Str $.title;
  has Code $.status is required;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Reference @.profile;
  has Str $.publisher;
  has Markdown $.copyright;
  has Identifier $.identifier;
  has UsageContext @.useContext;
  has Markdown $.description;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has TestScript_Origin @.origin;
  has TestScript_Fixture @.fixture;
  has TestScript_Variable @.variable;
  has TestScript_Destination @.destination;
  has TestScript_Test @.test;
  has TestScript_Teardown $.teardown;
  has TestScript_Metadata $.metadata;
  has TestScript_Setup $.setup;
}
class FamilyMemberHistory_Condition is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code is required;
  has Annotation @.note;
  has CodeableConcept $.outcome;
  has ChoiceField $.onset where Age|Period|Range|Str;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has Bool $.contributedToDeath;
}

class FamilyMemberHistory is DomainResource is export {
  method resourceType(--> 'FamilyMemberHistory') {}
  has CodeableConcept $.sex;
  has DateTime $.date;
  has Str $.name;
  has Annotation @.note;
  has Code $.status is required;
  has ChoiceField $.age where Age|Range|Str;
  has Reference $.patient is required;
  has ChoiceField $.born where Date|Period|Str;
  has Identifier @.identifier;
  has CodeableConcept @.reasonCode;
  has ChoiceField $.deceased where Age|Bool|Date|Range|Str;
  has CodeableConcept $.relationship is required;
  has Bool $.estimatedAge;
  has UriStr @.instantiatesUri;
  has Reference @.reasonReference;
  has CodeableConcept $.dataAbsentReason;
  has Canonical @.instantiatesCanonical;
  has FamilyMemberHistory_Condition @.condition;
}
class TerminologyCapabilities_Closure is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Bool $.translation;
  has Extension @.modifierExtension;
}

class TerminologyCapabilities_Software is FHIR is export {
  has Str $.id;
  has Str $.name is required;
  has Str $.version;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class TerminologyCapabilities_Translation is FHIR is export {
  has Str $.id;
  has Bool $.needsMap is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class TerminologyCapabilities_ValidateCode is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Bool $.translations is required;
  has Extension @.modifierExtension;
}

class TerminologyCapabilities_Implementation is FHIR is export {
  has Str $.id;
  has UrlStr $.url;
  has Extension @.extension;
  has Str $.description is required;
  has Extension @.modifierExtension;
}

class TerminologyCapabilities_Expansion_Parameter is FHIR is export {
  has Str $.id;
  has Code $.name is required;
  has Extension @.extension;
  has Str $.documentation;
  has Extension @.modifierExtension;
}
class TerminologyCapabilities_Expansion is FHIR is export {
  has Str $.id;
  has Bool $.paging;
  has Extension @.extension;
  has Bool $.incomplete;
  has Markdown $.textFilter;
  has Bool $.hierarchical;
  has Extension @.modifierExtension;
  has TerminologyCapabilities_Expansion_Parameter @.parameter;
}

class TerminologyCapabilities_CodeSystem_Version_Filter is FHIR is export {
  has Str $.id;
  has Code @.op is required;
  has Code $.code is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class TerminologyCapabilities_CodeSystem_Version is FHIR is export {
  has Str $.id;
  has Str $.code;
  has Code @.language;
  has Code @.property;
  has Extension @.extension;
  has Bool $.isDefault;
  has Bool $.compositional;
  has Extension @.modifierExtension;
  has TerminologyCapabilities_CodeSystem_Version_Filter @.filter;
}
class TerminologyCapabilities_CodeSystem is FHIR is export {
  has Str $.id;
  has Canonical $.uri;
  has Extension @.extension;
  has Bool $.subsumption;
  has Extension @.modifierExtension;
  has TerminologyCapabilities_CodeSystem_Version @.version;
}

class TerminologyCapabilities is DomainResource is export {
  method resourceType(--> 'TerminologyCapabilities') {}
  has UriStr $.url;
  has Str $.name;
  has DateTime $.date is required;
  has Code $.kind is required;
  has Str $.title;
  has Code $.status is required;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Str $.publisher;
  has Markdown $.copyright;
  has UsageContext @.useContext;
  has Bool $.lockedDate;
  has Code $.codeSearch;
  has Markdown $.description;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has TerminologyCapabilities_Closure $.closure;
  has TerminologyCapabilities_Software $.software;
  has TerminologyCapabilities_Translation $.translation;
  has TerminologyCapabilities_ValidateCode $.validateCode;
  has TerminologyCapabilities_Implementation $.implementation;
  has TerminologyCapabilities_Expansion $.expansion;
  has TerminologyCapabilities_CodeSystem @.codeSystem;
}
class ExampleScenario_Actor is FHIR is export {
  has Str $.id;
  has Code $.type is required;
  has Str $.name;
  has Str $.actorId is required;
  has Extension @.extension;
  has Markdown $.description;
  has Extension @.modifierExtension;
}

class ExampleScenario_Process_Step_Operation is FHIR is export {
  has Str $.id;
  has Str $.type;
  has Str $.name;
  has Str $.number is required;
  has ExampleScenario_Instance_ContainedInstance $.request;
  has Str $.receiver;
  has ExampleScenario_Instance_ContainedInstance $.response;
  has Extension @.extension;
  has Str $.initiator;
  has Markdown $.description;
  has Bool $.receiverActive;
  has Bool $.initiatorActive;
  has Extension @.modifierExtension;
}

class ExampleScenario_Process_Step_Alternative is FHIR is export {
  has Str $.id;
  has ExampleScenario_Process_Step @.step;
  has Str $.title is required;
  has Extension @.extension;
  has Markdown $.description;
  has Extension @.modifierExtension;
}
class ExampleScenario_Process_Step is FHIR is export {
  has Str $.id;
  has Bool $.pause;
  has ExampleScenario_Process @.process;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has ExampleScenario_Process_Step_Operation $.operation;
  has ExampleScenario_Process_Step_Alternative @.alternative;
}
class ExampleScenario_Process is FHIR is export {
  has Str $.id;
  has Str $.title is required;
  has Extension @.extension;
  has Markdown $.description;
  has Markdown $.preConditions;
  has Markdown $.postConditions;
  has Extension @.modifierExtension;
  has ExampleScenario_Process_Step @.step;
}

class ExampleScenario_Instance_Version is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Str $.versionId is required;
  has Markdown $.description is required;
  has Extension @.modifierExtension;
}

class ExampleScenario_Instance_ContainedInstance is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Str $.versionId;
  has Str $.resourceId is required;
  has Extension @.modifierExtension;
}
class ExampleScenario_Instance is FHIR is export {
  has Str $.id;
  has Str $.name;
  has Extension @.extension;
  has Str $.resourceId is required;
  has Markdown $.description;
  has Code $.resourceType is required;
  has Extension @.modifierExtension;
  has ExampleScenario_Instance_Version @.version;
  has ExampleScenario_Instance_ContainedInstance @.containedInstance;
}

class ExampleScenario is DomainResource is export {
  method resourceType(--> 'ExampleScenario') {}
  has UriStr $.url;
  has Str $.name;
  has DateTime $.date;
  has Code $.status is required;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Canonical @.workflow;
  has Str $.publisher;
  has Markdown $.copyright;
  has Identifier @.identifier;
  has UsageContext @.useContext;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has ExampleScenario_Actor @.actor;
  has ExampleScenario_Process @.process;
  has ExampleScenario_Instance @.instance;
}
class Timing_Repeat is FHIR is export {
  has Str $.id;
  has Code @.when;
  has PositiveInt $.count;
  has Real $.period;
  has UnsignedInt $.offset;
  has PositiveInt $.countMax;
  has Real $.duration;
  has Extension @.extension;
  has ChoiceField $.bounds where Duration|Period|Range;
  has PositiveInt $.frequency;
  has Real $.periodMax;
  has Code @.dayOfWeek;
  has Instant @.timeOfDay;
  has Code $.periodUnit;
  has Real $.durationMax;
  has Code $.durationUnit;
  has PositiveInt $.frequencyMax;
}

class Timing is BackboneElement is export {
  has CodeableConcept $.code;
  has DateTime @.event;
  has Timing_Repeat $.repeat;
}
class MessageHeader_Source is FHIR is export {
  has Str $.id;
  has Str $.name;
  has Str $.version;
  has ContactPoint $.contact;
  has Str $.software;
  has UrlStr $.endpoint is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MessageHeader_Response is FHIR is export {
  has Str $.id;
  has Code $.code is required;
  has Reference $.details;
  has Extension @.extension;
  has Id $.identifier is required;
  has Extension @.modifierExtension;
}

class MessageHeader_Destination is FHIR is export {
  has Str $.id;
  has Str $.name;
  has Reference $.target;
  has UrlStr $.endpoint is required;
  has Reference $.receiver;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MessageHeader is DomainResource is export {
  method resourceType(--> 'MessageHeader') {}
  has Reference @.focus;
  has Reference $.sender;
  has Reference $.author;
  has CodeableConcept $.reason;
  has Reference $.enterer;
  has ChoiceField $.event is required where Coding|UriStr;
  has Canonical $.definition;
  has Reference $.responsible;
  has MessageHeader_Source $.source is required;
  has MessageHeader_Response $.response;
  has MessageHeader_Destination @.destination;
}
class Goal_Target is FHIR is export {
  has Str $.id;
  has ChoiceField $.due where Duration|Date;
  has CodeableConcept $.measure;
  has Extension @.extension;
  has ChoiceField $.detail where Bool|CodeableConcept|Int|Quantity|Range|Ratio|Str;
  has Extension @.modifierExtension;
}

class Goal is DomainResource is export {
  method resourceType(--> 'Goal') {}
  has Annotation @.note;
  has Reference $.subject is required;
  has CodeableConcept @.category;
  has CodeableConcept $.priority;
  has ChoiceField $.start where CodeableConcept|Date;
  has Reference @.addresses;
  has Identifier @.identifier;
  has Date $.statusDate;
  has CodeableConcept $.description is required;
  has Reference $.expressedBy;
  has CodeableConcept @.outcomeCode;
  has Str $.statusReason;
  has Code $.lifecycleStatus is required;
  has Reference @.outcomeReference;
  has CodeableConcept $.achievementStatus;
  has Goal_Target @.target;
}
class MedicationDispense_Performer is FHIR is export {
  has Str $.id;
  has Reference $.actor is required;
  has CodeableConcept $.function;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MedicationDispense_Substitution is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has CodeableConcept @.reason;
  has Extension @.extension;
  has Bool $.wasSubstituted is required;
  has Reference @.responsibleParty;
  has Extension @.modifierExtension;
}

class MedicationDispense is DomainResource is export {
  method resourceType(--> 'MedicationDispense') {}
  has CodeableConcept $.type;
  has Annotation @.note;
  has Reference @.partOf;
  has Code $.status is required;
  has Reference $.subject;
  has Reference $.context;
  has CodeableConcept $.category;
  has Reference $.location;
  has Quantity $.quantity;
  has Reference @.receiver;
  has Identifier @.identifier;
  has Quantity $.daysSupply;
  has Reference $.destination;
  has DateTime $.whenPrepared;
  has Reference @.eventHistory;
  has ChoiceField $.medication is required where CodeableConcept|Reference;
  has Reference @.detectedIssue;
  has DateTime $.whenHandedOver;
  has ChoiceField $.statusReason where CodeableConcept|Reference;
  has Dosage @.dosageInstruction;
  has Reference @.supportingInformation;
  has Reference @.authorizingPrescription;
  has MedicationDispense_Performer @.performer;
  has MedicationDispense_Substitution $.substitution;
}
class OperationDefinition_Overload is FHIR is export {
  has Str $.id;
  has Str $.comment;
  has Extension @.extension;
  has Str @.parameterName;
  has Extension @.modifierExtension;
}

class OperationDefinition_Parameter_Binding is FHIR is export {
  has Str $.id;
  has Code $.strength is required;
  has Canonical $.valueSet is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class OperationDefinition_Parameter_ReferencedFrom is FHIR is export {
  has Str $.id;
  has Str $.source is required;
  has Str $.sourceId;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class OperationDefinition_Parameter is FHIR is export {
  has Str $.id;
  has Code $.use is required;
  has Int $.min is required;
  has Str $.max is required;
  has Code $.name is required;
  has Code $.type;
  has OperationDefinition_Parameter @.part;
  has Extension @.extension;
  has Code $.searchType;
  has Str $.documentation;
  has Canonical @.targetProfile;
  has Extension @.modifierExtension;
  has OperationDefinition_Parameter_Binding $.binding;
  has OperationDefinition_Parameter_ReferencedFrom @.referencedFrom;
}

class OperationDefinition is DomainResource is export {
  method resourceType(--> 'OperationDefinition') {}
  has UriStr $.url;
  has Str $.name is required;
  has Code $.kind is required;
  has DateTime $.date;
  has Code $.code is required;
  has Canonical $.base;
  has Bool $.type is required;
  has Str $.title;
  has Code $.status is required;
  has Bool $.system is required;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Markdown $.comment;
  has Code @.resource;
  has Bool $.instance is required;
  has Str $.publisher;
  has UsageContext @.useContext;
  has Markdown $.description;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has Bool $.affectsState;
  has Canonical $.inputProfile;
  has Canonical $.outputProfile;
  has OperationDefinition_Overload @.overload;
  has OperationDefinition_Parameter @.parameter;
}
class ClaimResponse_Total is FHIR is export {
  has Str $.id;
  has Money $.amount is required;
  has CodeableConcept $.category is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class ClaimResponse_Error is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code is required;
  has Extension @.extension;
  has PositiveInt $.itemSequence;
  has PositiveInt $.detailSequence;
  has Extension @.modifierExtension;
  has PositiveInt $.subDetailSequence;
}

class ClaimResponse_Payment is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Date $.date;
  has Money $.amount is required;
  has Extension @.extension;
  has Money $.adjustment;
  has Identifier $.identifier;
  has CodeableConcept $.adjustmentReason;
  has Extension @.modifierExtension;
}

class ClaimResponse_ProcessNote is FHIR is export {
  has Str $.id;
  has Code $.type;
  has Str $.text is required;
  has PositiveInt $.number;
  has CodeableConcept $.language;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class ClaimResponse_Insurance is FHIR is export {
  has Str $.id;
  has Bool $.focal is required;
  has PositiveInt $.sequence is required;
  has Reference $.coverage is required;
  has Extension @.extension;
  has Reference $.claimResponse;
  has Extension @.modifierExtension;
  has Str $.businessArrangement;
}

class ClaimResponse_Item_Adjudication is FHIR is export {
  has Str $.id;
  has Real $.value;
  has CodeableConcept $.reason;
  has Money $.amount;
  has CodeableConcept $.category is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class ClaimResponse_Item_Detail_SubDetail is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has PositiveInt @.noteNumber;
  has ClaimResponse_Item_Adjudication @.adjudication;
  has Extension @.modifierExtension;
  has PositiveInt $.subDetailSequence is required;
}
class ClaimResponse_Item_Detail is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has PositiveInt @.noteNumber;
  has ClaimResponse_Item_Adjudication @.adjudication is required;
  has PositiveInt $.detailSequence is required;
  has Extension @.modifierExtension;
  has ClaimResponse_Item_Detail_SubDetail @.subDetail;
}
class ClaimResponse_Item is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has PositiveInt @.noteNumber;
  has PositiveInt $.itemSequence is required;
  has Extension @.modifierExtension;
  has ClaimResponse_Item_Adjudication @.adjudication is required;
  has ClaimResponse_Item_Detail @.detail;
}

class ClaimResponse_AddItem_Detail_SubDetail is FHIR is export {
  has Str $.id;
  has Money $.net;
  has Real $.factor;
  has CodeableConcept @.modifier;
  has Quantity $.quantity;
  has Extension @.extension;
  has Money $.unitPrice;
  has PositiveInt @.noteNumber;
  has ClaimResponse_Item_Adjudication @.adjudication is required;
  has CodeableConcept $.productOrService is required;
  has Extension @.modifierExtension;
}
class ClaimResponse_AddItem_Detail is FHIR is export {
  has Str $.id;
  has Money $.net;
  has Real $.factor;
  has CodeableConcept @.modifier;
  has Quantity $.quantity;
  has Extension @.extension;
  has Money $.unitPrice;
  has PositiveInt @.noteNumber;
  has ClaimResponse_Item_Adjudication @.adjudication is required;
  has CodeableConcept $.productOrService is required;
  has Extension @.modifierExtension;
  has ClaimResponse_AddItem_Detail_SubDetail @.subDetail;
}
class ClaimResponse_AddItem is FHIR is export {
  has Str $.id;
  has Money $.net;
  has Real $.factor;
  has CodeableConcept @.subSite;
  has Reference @.provider;
  has CodeableConcept @.modifier;
  has Quantity $.quantity;
  has CodeableConcept $.bodySite;
  has Extension @.extension;
  has Money $.unitPrice;
  has PositiveInt @.noteNumber;
  has CodeableConcept @.programCode;
  has ChoiceField $.serviced where Date|Period;
  has ChoiceField $.location where Address|CodeableConcept|Reference;
  has PositiveInt @.itemSequence;
  has ClaimResponse_Item_Adjudication @.adjudication is required;
  has PositiveInt @.detailSequence;
  has CodeableConcept $.productOrService is required;
  has Extension @.modifierExtension;
  has PositiveInt @.subdetailSequence;
  has ClaimResponse_AddItem_Detail @.detail;
}

class ClaimResponse is DomainResource is export {
  method resourceType(--> 'ClaimResponse') {}
  has Code $.use is required;
  has CodeableConcept $.type is required;
  has Attachment $.form;
  has Code $.status is required;
  has CodeableConcept $.subType;
  has Reference $.patient is required;
  has DateTime $.created is required;
  has Reference $.insurer is required;
  has Reference $.request;
  has Code $.outcome is required;
  has CodeableConcept $.formCode;
  has Reference $.requestor;
  has CodeableConcept $.payeeType;
  has Identifier @.identifier;
  has Str $.preAuthRef;
  has Str $.disposition;
  has ClaimResponse_Item_Adjudication @.adjudication;
  has CodeableConcept $.fundsReserve;
  has Period $.preAuthPeriod;
  has Reference @.communicationRequest;
  has ClaimResponse_Total @.total;
  has ClaimResponse_Error @.error;
  has ClaimResponse_Payment $.payment;
  has ClaimResponse_ProcessNote @.processNote;
  has ClaimResponse_Insurance @.insurance;
  has ClaimResponse_Item @.item;
  has ClaimResponse_AddItem @.addItem;
}
class DocumentReference_Content is FHIR is export {
  has Str $.id;
  has Coding $.format;
  has Extension @.extension;
  has Attachment $.attachment is required;
  has Extension @.modifierExtension;
}

class DocumentReference_Context is FHIR is export {
  has Str $.id;
  has CodeableConcept @.event;
  has Period $.period;
  has Reference @.related;
  has Extension @.extension;
  has Reference @.encounter;
  has CodeableConcept $.facilityType;
  has CodeableConcept $.practiceSetting;
  has Extension @.modifierExtension;
  has Reference $.sourcePatientInfo;
}

class DocumentReference_RelatesTo is FHIR is export {
  has Str $.id;
  has Code $.code is required;
  has Reference $.target is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class DocumentReference is DomainResource is export {
  method resourceType(--> 'DocumentReference') {}
  has CodeableConcept $.type;
  has DateTime $.date;
  has Code $.status is required;
  has Reference @.author;
  has Reference $.subject;
  has CodeableConcept @.category;
  has Code $.docStatus;
  has Reference $.custodian;
  has Identifier @.identifier;
  has Str $.description;
  has Reference $.authenticator;
  has CodeableConcept @.securityLabel;
  has Identifier $.masterIdentifier;
  has DocumentReference_Content @.content is required;
  has DocumentReference_Context $.context;
  has DocumentReference_RelatesTo @.relatesTo;
}
class MedicationAdministration_Dosage is FHIR is export {
  has Str $.id;
  has Str $.text;
  has CodeableConcept $.site;
  has Quantity $.dose;
  has CodeableConcept $.route;
  has CodeableConcept $.method;
  has ChoiceField $.rate where Quantity|Ratio;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MedicationAdministration_Performer is FHIR is export {
  has Str $.id;
  has Reference $.actor is required;
  has CodeableConcept $.function;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MedicationAdministration is DomainResource is export {
  method resourceType(--> 'MedicationAdministration') {}
  has Annotation @.note;
  has Reference @.partOf;
  has Code $.status is required;
  has Reference @.device;
  has Reference $.subject is required;
  has Reference $.context;
  has Reference $.request;
  has CodeableConcept $.category;
  has Identifier @.identifier;
  has CodeableConcept @.reasonCode;
  has UriStr @.instantiates;
  has CodeableConcept @.statusReason;
  has ChoiceField $.effective is required where DateTime|Period;
  has Reference @.eventHistory;
  has ChoiceField $.medication is required where CodeableConcept|Reference;
  has Reference @.reasonReference;
  has Reference @.supportingInformation;
  has MedicationAdministration_Dosage $.dosage;
  has MedicationAdministration_Performer @.performer;
}

class AppointmentResponse is DomainResource is export {
  method resourceType(--> 'AppointmentResponse') {}
  has DateTime $.end;
  has DateTime $.start;
  has Reference $.actor;
  has Str $.comment;
  has Identifier @.identifier;
  has Reference $.appointment is required;
  has CodeableConcept @.participantType;
  has Code $.participantStatus is required;
}
class Provenance_Agent is FHIR is export {
  has Str $.id;
  has Reference $.who is required;
  has CodeableConcept $.type;
  has CodeableConcept @.role;
  has Extension @.extension;
  has Reference $.onBehalfOf;
  has Extension @.modifierExtension;
}

class Provenance_Entity is FHIR is export {
  has Str $.id;
  has Code $.role is required;
  has Reference $.what is required;
  has Provenance_Agent @.agent;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Provenance is DomainResource is export {
  method resourceType(--> 'Provenance') {}
  has Reference @.target is required;
  has UriStr @.policy;
  has CodeableConcept @.reason;
  has DateTime $.recorded is required;
  has Reference $.location;
  has CodeableConcept $.activity;
  has Signature @.signature;
  has ChoiceField $.occurred where DateTime|Period;
  has Provenance_Agent @.agent is required;
  has Provenance_Entity @.entity;
}

class MedicinalProductManufactured is DomainResource is export {
  method resourceType(--> 'MedicinalProductManufactured') {}
  has Quantity $.quantity is required;
  has Reference @.ingredient;
  has Reference @.manufacturer;
  has CodeableConcept $.unitOfPresentation;
  has CodeableConcept $.manufacturedDoseForm is required;
  has CodeableConcept @.otherCharacteristics;
  has Any $.physicalCharacteristics;
}
class ObservationDefinition_QualifiedInterval is FHIR is export {
  has Str $.id;
  has Range $.age;
  has Range $.range;
  has Code $.gender;
  has CodeableConcept $.context;
  has Code $.category;
  has Extension @.extension;
  has CodeableConcept @.appliesTo;
  has Str $.condition;
  has Range $.gestationalAge;
  has Extension @.modifierExtension;
}

class ObservationDefinition_QuantitativeDetails is FHIR is export {
  has Str $.id;
  has CodeableConcept $.unit;
  has Extension @.extension;
  has CodeableConcept $.customaryUnit;
  has Real $.conversionFactor;
  has Int $.decimalPrecision;
  has Extension @.modifierExtension;
}

class ObservationDefinition is DomainResource is export {
  method resourceType(--> 'ObservationDefinition') {}
  has CodeableConcept $.code is required;
  has CodeableConcept $.method;
  has CodeableConcept @.category;
  has Identifier @.identifier;
  has Code @.permittedDataType;
  has Reference $.validCodedValueSet;
  has Str $.preferredReportName;
  has Reference $.normalCodedValueSet;
  has Reference $.abnormalCodedValueSet;
  has Reference $.criticalCodedValueSet;
  has Bool $.multipleResultsAllowed;
  has ObservationDefinition_QualifiedInterval @.qualifiedInterval;
  has ObservationDefinition_QuantitativeDetails $.quantitativeDetails;
}
class SupplyDelivery_SuppliedItem is FHIR is export {
  has Str $.id;
  has ChoiceField $.item where CodeableConcept|Reference;
  has Quantity $.quantity;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class SupplyDelivery is DomainResource is export {
  method resourceType(--> 'SupplyDelivery') {}
  has CodeableConcept $.type;
  has Reference @.partOf;
  has Code $.status;
  has Reference @.basedOn;
  has Reference $.patient;
  has Reference $.supplier;
  has Reference @.receiver;
  has Identifier @.identifier;
  has Reference $.destination;
  has ChoiceField $.occurrence where DateTime|Period|Timing;
  has SupplyDelivery_SuppliedItem $.suppliedItem;
}
class ClinicalImpression_Finding is FHIR is export {
  has Str $.id;
  has Str $.basis;
  has Extension @.extension;
  has Reference $.itemReference;
  has Extension @.modifierExtension;
  has CodeableConcept $.itemCodeableConcept;
}

class ClinicalImpression_Investigation is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code is required;
  has Reference @.item;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class ClinicalImpression is DomainResource is export {
  method resourceType(--> 'ClinicalImpression') {}
  has CodeableConcept $.code;
  has DateTime $.date;
  has Annotation @.note;
  has Code $.status is required;
  has Reference $.subject is required;
  has Reference @.problem;
  has Str $.summary;
  has Reference $.assessor;
  has Reference $.previous;
  has UriStr @.protocol;
  has Reference $.encounter;
  has Identifier @.identifier;
  has Str $.description;
  has CodeableConcept $.statusReason;
  has ChoiceField $.effective where DateTime|Period;
  has Reference @.supportingInfo;
  has Reference @.prognosisReference;
  has CodeableConcept @.prognosisCodeableConcept;
  has ClinicalImpression_Finding @.finding;
  has ClinicalImpression_Investigation @.investigation;
}
class Observation_Component is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code is required;
  has ChoiceField $.value where Bool|CodeableConcept|DateTime|Int|Instant|Period|Quantity|Range|Ratio|SampledData|Str;
  has Extension @.extension;
  has CodeableConcept @.interpretation;
  has Observation_ReferenceRange @.referenceRange;
  has CodeableConcept $.dataAbsentReason;
  has Extension @.modifierExtension;
}

class Observation_ReferenceRange is FHIR is export {
  has Str $.id;
  has Quantity $.low;
  has Range $.age;
  has Quantity $.high;
  has CodeableConcept $.type;
  has Str $.text;
  has Extension @.extension;
  has CodeableConcept @.appliesTo;
  has Extension @.modifierExtension;
}

class Observation is DomainResource is export {
  method resourceType(--> 'Observation') {}
  has CodeableConcept $.code is required;
  has Annotation @.note;
  has Reference @.focus;
  has Reference @.partOf;
  has Code $.status is required;
  has DateTime $.issued;
  has CodeableConcept $.method;
  has Reference $.device;
  has Reference @.basedOn;
  has Reference $.subject;
  has CodeableConcept @.category;
  has ChoiceField $.value where Bool|CodeableConcept|DateTime|Int|Instant|Period|Quantity|Range|Ratio|SampledData|Str;
  has CodeableConcept $.bodySite;
  has Reference $.specimen;
  has Reference $.encounter;
  has Reference @.performer;
  has Reference @.hasMember;
  has Identifier @.identifier;
  has Reference @.derivedFrom;
  has ChoiceField $.effective where DateTime|Period|Timing|DateTime;
  has CodeableConcept @.interpretation;
  has CodeableConcept $.dataAbsentReason;
  has Observation_Component @.component;
  has Observation_ReferenceRange @.referenceRange;
}
class CarePlan_Activity_Detail is FHIR is export {
  has Str $.id;
  has Code $.kind;
  has CodeableConcept $.code;
  has Reference @.goal;
  has Code $.status is required;
  has Reference $.location;
  has Quantity $.quantity;
  has Extension @.extension;
  has Reference @.performer;
  has CodeableConcept @.reasonCode;
  has ChoiceField $.product where CodeableConcept|Reference;
  has Quantity $.dailyAmount;
  has Str $.description;
  has CodeableConcept $.statusReason;
  has Bool $.doNotPerform;
  has ChoiceField $.scheduled where Period|Str|Timing;
  has UriStr @.instantiatesUri;
  has Reference @.reasonReference;
  has Extension @.modifierExtension;
  has Canonical @.instantiatesCanonical;
}
class CarePlan_Activity is FHIR is export {
  has Str $.id;
  has Annotation @.progress;
  has Extension @.extension;
  has Reference $.reference;
  has Reference @.outcomeReference;
  has Extension @.modifierExtension;
  has CodeableConcept @.outcomeCodeableConcept;
  has CarePlan_Activity_Detail $.detail;
}

class CarePlan is DomainResource is export {
  method resourceType(--> 'CarePlan') {}
  has Reference @.goal;
  has Annotation @.note;
  has Str $.title;
  has Reference @.partOf;
  has Code $.status is required;
  has Code $.intent is required;
  has Period $.period;
  has Reference $.author;
  has Reference @.basedOn;
  has Reference $.subject is required;
  has DateTime $.created;
  has Reference @.replaces;
  has CodeableConcept @.category;
  has Reference @.careTeam;
  has Reference $.encounter;
  has Reference @.addresses;
  has Identifier @.identifier;
  has Str $.description;
  has Reference @.contributor;
  has Reference @.supportingInfo;
  has UriStr @.instantiatesUri;
  has Canonical @.instantiatesCanonical;
  has CarePlan_Activity @.activity;
}
class EvidenceVariable_Characteristic is FHIR is export {
  has Str $.id;
  has Bool $.exclude;
  has Extension @.extension;
  has Str $.description;
  has UsageContext @.usageContext;
  has Code $.groupMeasure;
  has ChoiceField $.definition is required where Canonical|CodeableConcept|DataRequirement|Expression|Reference|TriggerDefinition;
  has Duration $.timeFromStart;
  has Extension @.modifierExtension;
  has ChoiceField $.participantEffective where Duration|DateTime|Period|Timing;
}

class EvidenceVariable is DomainResource is export {
  method resourceType(--> 'EvidenceVariable') {}
  has UriStr $.url;
  has Str $.name;
  has DateTime $.date;
  has Annotation @.note;
  has Code $.type;
  has Str $.title;
  has CodeableConcept @.topic;
  has Code $.status is required;
  has ContactDetail @.author;
  has ContactDetail @.editor;
  has Str $.version;
  has ContactDetail @.contact;
  has Str $.subtitle;
  has ContactDetail @.reviewer;
  has ContactDetail @.endorser;
  has Str $.publisher;
  has Markdown $.copyright;
  has Identifier @.identifier;
  has Str $.shortTitle;
  has UsageContext @.useContext;
  has Markdown $.description;
  has CodeableConcept @.jurisdiction;
  has Date $.approvalDate;
  has Date $.lastReviewDate;
  has Period $.effectivePeriod;
  has RelatedArtifact @.relatedArtifact;
  has EvidenceVariable_Characteristic @.characteristic is required;
}

class ImmunizationEvaluation is DomainResource is export {
  method resourceType(--> 'ImmunizationEvaluation') {}
  has DateTime $.date;
  has Code $.status is required;
  has Str $.series;
  has Reference $.patient is required;
  has Reference $.authority;
  has Identifier @.identifier;
  has CodeableConcept $.doseStatus is required;
  has Str $.description;
  has CodeableConcept $.targetDisease is required;
  has ChoiceField $.doseNumber where PositiveInt|Str;
  has ChoiceField $.seriesDoses where PositiveInt|Str;
  has CodeableConcept @.doseStatusReason;
  has Reference $.immunizationEvent is required;
}
class Location_Position is FHIR is export {
  has Str $.id;
  has Real $.latitude is required;
  has Real $.altitude;
  has Extension @.extension;
  has Real $.longitude is required;
  has Extension @.modifierExtension;
}

class Location_HoursOfOperation is FHIR is export {
  has Str $.id;
  has Bool $.allDay;
  has Extension @.extension;
  has Code @.daysOfWeek;
  has Instant $.openingTime;
  has Instant $.closingTime;
  has Extension @.modifierExtension;
}

class Location is DomainResource is export {
  method resourceType(--> 'Location') {}
  has Str $.name;
  has Code $.mode;
  has CodeableConcept @.type;
  has Str @.alias;
  has Code $.status;
  has Reference $.partOf;
  has ContactPoint @.telecom;
  has Address $.address;
  has Reference @.endpoint;
  has Identifier @.identifier;
  has Str $.description;
  has CodeableConcept $.physicalType;
  has Coding $.operationalStatus;
  has Reference $.managingOrganization;
  has Str $.availabilityExceptions;
  has Location_Position $.position;
  has Location_HoursOfOperation @.hoursOfOperation;
}

class MoneyQuantity is Quantity is export {
  
}
class ChargeItem_Performer is FHIR is export {
  has Str $.id;
  has Reference $.actor is required;
  has CodeableConcept $.function;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class ChargeItem is DomainResource is export {
  method resourceType(--> 'ChargeItem') {}
  has CodeableConcept $.code is required;
  has Annotation @.note;
  has Code $.status is required;
  has Reference @.partOf;
  has CodeableConcept @.reason;
  has Reference $.subject is required;
  has Reference $.context;
  has Reference $.enterer;
  has Reference @.service;
  has Reference @.account;
  has Quantity $.quantity;
  has CodeableConcept @.bodysite;
  has Identifier @.identifier;
  has Reference $.costCenter;
  has ChoiceField $.product where CodeableConcept|Reference;
  has DateTime $.enteredDate;
  has UriStr @.definitionUri;
  has ChoiceField $.occurrence where DateTime|Period|Timing;
  has Money $.priceOverride;
  has Real $.factorOverride;
  has Str $.overrideReason;
  has Canonical @.definitionCanonical;
  has Reference @.supportingInformation;
  has Reference $.performingOrganization;
  has Reference $.requestingOrganization;
  has ChargeItem_Performer @.performer;
}
class Condition_Stage is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has CodeableConcept $.summary;
  has Extension @.extension;
  has Reference @.assessment;
  has Extension @.modifierExtension;
}

class Condition_Evidence is FHIR is export {
  has Str $.id;
  has CodeableConcept @.code;
  has Reference @.detail;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Condition is DomainResource is export {
  method resourceType(--> 'Condition') {}
  has CodeableConcept $.code;
  has Annotation @.note;
  has Reference $.subject is required;
  has CodeableConcept @.category;
  has CodeableConcept $.severity;
  has CodeableConcept @.bodySite;
  has ChoiceField $.onset where Age|DateTime|Period|Range|Str;
  has Reference $.recorder;
  has Reference $.asserter;
  has Reference $.encounter;
  has Identifier @.identifier;
  has ChoiceField $.abatement where Age|DateTime|Period|Range|Str;
  has DateTime $.recordedDate;
  has CodeableConcept $.clinicalStatus;
  has CodeableConcept $.verificationStatus;
  has Condition_Stage @.stage;
  has Condition_Evidence @.evidence;
}
class Task_Input is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has ChoiceField $.value is required where Address|Age|Annotation|Attachment|Base64Binary|Bool|Canonical|Code|CodeableConcept|Coding|ContactDetail|ContactPoint|Contributor|Count|DataRequirement|Distance|Dosage|Real|Duration|Expression|Date|DateTime|HumanName|Id|Identifier|Int|Instant|Markdown|Money|OID|ParameterDefinition|Period|PositiveInt|Quantity|Range|Ratio|Reference|RelatedArtifact|SampledData|Signature|Str|Timing|TriggerDefinition|UUID|UnsignedInt|UriStr|UrlStr|UsageContext|DateTime;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Task_Output is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has ChoiceField $.value is required where Address|Age|Annotation|Attachment|Base64Binary|Bool|Canonical|Code|CodeableConcept|Coding|ContactDetail|ContactPoint|Contributor|Count|DataRequirement|Distance|Dosage|Real|Duration|Expression|Date|DateTime|HumanName|Id|Identifier|Int|Instant|Markdown|Money|OID|ParameterDefinition|Period|PositiveInt|Quantity|Range|Ratio|Reference|RelatedArtifact|SampledData|Signature|Str|Timing|TriggerDefinition|UUID|UnsignedInt|UriStr|UrlStr|UsageContext|DateTime;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Task_Restriction is FHIR is export {
  has Str $.id;
  has Period $.period;
  has Extension @.extension;
  has Reference @.recipient;
  has PositiveInt $.repetitions;
  has Extension @.modifierExtension;
}

class Task is DomainResource is export {
  method resourceType(--> 'Task') {}
  has Reference $.for;
  has CodeableConcept $.code;
  has Annotation @.note;
  has Reference $.focus;
  has Reference $.owner;
  has Reference @.partOf;
  has Code $.status is required;
  has Code $.intent is required;
  has Reference @.basedOn;
  has Code $.priority;
  has Reference $.location;
  has Reference $.encounter;
  has Reference $.requester;
  has Reference @.insurance;
  has Identifier @.identifier;
  has DateTime $.authoredOn;
  has CodeableConcept $.reasonCode;
  has Str $.description;
  has CodeableConcept $.statusReason;
  has DateTime $.lastModified;
  has CodeableConcept @.performerType;
  has CodeableConcept $.businessStatus;
  has UriStr $.instantiatesUri;
  has Identifier $.groupIdentifier;
  has Period $.executionPeriod;
  has Reference $.reasonReference;
  has Reference @.relevantHistory;
  has Canonical $.instantiatesCanonical;
  has Task_Input @.input;
  has Task_Output @.output;
  has Task_Restriction $.restriction;
}
class RiskAssessment_Prediction is FHIR is export {
  has Str $.id;
  has CodeableConcept $.outcome;
  has ChoiceField $.when where Period|Range;
  has Extension @.extension;
  has Str $.rationale;
  has Real $.relativeRisk;
  has ChoiceField $.probability where Real|Range;
  has CodeableConcept $.qualitativeRisk;
  has Extension @.modifierExtension;
}

class RiskAssessment is DomainResource is export {
  method resourceType(--> 'RiskAssessment') {}
  has CodeableConcept $.code;
  has Annotation @.note;
  has Reference @.basis;
  has Reference $.parent;
  has Code $.status is required;
  has CodeableConcept $.method;
  has Reference $.basedOn;
  has Reference $.subject is required;
  has Reference $.encounter;
  has Reference $.condition;
  has Reference $.performer;
  has Identifier @.identifier;
  has CodeableConcept @.reasonCode;
  has Str $.mitigation;
  has ChoiceField $.occurrence where DateTime|Period;
  has Reference @.reasonReference;
  has RiskAssessment_Prediction @.prediction;
}

class GuidanceResponse is DomainResource is export {
  method resourceType(--> 'GuidanceResponse') {}
  has Annotation @.note;
  has Code $.status is required;
  has Reference $.result;
  has Reference $.subject;
  has ChoiceField $.module is required where Canonical|CodeableConcept|UriStr;
  has Reference $.encounter;
  has Reference $.performer;
  has Identifier @.identifier;
  has CodeableConcept @.reasonCode;
  has Reference @.reasonReference;
  has DataRequirement @.dataRequirement;
  has Reference $.outputParameters;
  has Identifier $.requestIdentifier;
  has Reference @.evaluationMessage;
  has DateTime $.occurrenceDateTime;
}
class Device_Version is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Str $.value is required;
  has Extension @.extension;
  has Identifier $.component;
  has Extension @.modifierExtension;
}

class Device_Property is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Extension @.extension;
  has CodeableConcept @.valueCode;
  has Quantity @.valueQuantity;
  has Extension @.modifierExtension;
}

class Device_UdiCarrier is FHIR is export {
  has Str $.id;
  has UriStr $.issuer;
  has Extension @.extension;
  has Code $.entryType;
  has Str $.carrierHRF;
  has Base64Binary $.carrierAIDC;
  has UriStr $.jurisdiction;
  has Str $.deviceIdentifier;
  has Extension @.modifierExtension;
}

class Device_DeviceName is FHIR is export {
  has Str $.id;
  has Str $.name is required;
  has Code $.type is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Device_Specialization is FHIR is export {
  has Str $.id;
  has Str $.version;
  has Extension @.extension;
  has CodeableConcept $.systemType is required;
  has Extension @.modifierExtension;
}

class Device is DomainResource is export {
  method resourceType(--> 'Device') {}
  has UriStr $.url;
  has CodeableConcept $.type;
  has Annotation @.note;
  has Reference $.owner;
  has Code $.status;
  has CodeableConcept @.safety;
  has Reference $.parent;
  has Reference $.patient;
  has ContactPoint @.contact;
  has Reference $.location;
  has Str $.lotNumber;
  has Identifier @.identifier;
  has Reference $.definition;
  has Str $.partNumber;
  has Str $.modelNumber;
  has CodeableConcept @.statusReason;
  has Str $.manufacturer;
  has Str $.serialNumber;
  has DateTime $.expirationDate;
  has DateTime $.manufactureDate;
  has Str $.distinctIdentifier;
  has Device_Version @.version;
  has Device_Property @.property;
  has Device_UdiCarrier @.udiCarrier;
  has Device_DeviceName @.deviceName;
  has Device_Specialization @.specialization;
}

class Endpoint is DomainResource is export {
  method resourceType(--> 'Endpoint') {}
  has Str $.name;
  has Code $.status is required;
  has Period $.period;
  has Str @.header;
  has ContactPoint @.contact;
  has UrlStr $.address is required;
  has Identifier @.identifier;
  has CodeableConcept @.payloadType is required;
  has Coding $.connectionType is required;
  has Code @.payloadMimeType;
  has Reference $.managingOrganization;
}
class Encounter_Location is FHIR is export {
  has Str $.id;
  has Code $.status;
  has Period $.period;
  has Reference $.location is required;
  has Extension @.extension;
  has CodeableConcept $.physicalType;
  has Extension @.modifierExtension;
}

class Encounter_Diagnosis is FHIR is export {
  has Str $.id;
  has CodeableConcept $.use;
  has PositiveInt $.rank;
  has Extension @.extension;
  has Reference $.condition is required;
  has Extension @.modifierExtension;
}

class Encounter_Participant is FHIR is export {
  has Str $.id;
  has CodeableConcept @.type;
  has Period $.period;
  has Extension @.extension;
  has Reference $.individual;
  has Extension @.modifierExtension;
}

class Encounter_ClassHistory is FHIR is export {
  has Str $.id;
  has Coding $.class is required;
  has Period $.period is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Encounter_StatusHistory is FHIR is export {
  has Str $.id;
  has Code $.status is required;
  has Period $.period is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Encounter_Hospitalization is FHIR is export {
  has Str $.id;
  has Reference $.origin;
  has Extension @.extension;
  has CodeableConcept $.admitSource;
  has CodeableConcept $.reAdmission;
  has Reference $.destination;
  has CodeableConcept @.dietPreference;
  has CodeableConcept @.specialCourtesy;
  has Extension @.modifierExtension;
  has CodeableConcept @.specialArrangement;
  has CodeableConcept $.dischargeDisposition;
  has Identifier $.preAdmissionIdentifier;
}

class Encounter is DomainResource is export {
  method resourceType(--> 'Encounter') {}
  has CodeableConcept @.type;
  has Coding $.class is required;
  has Code $.status is required;
  has Period $.period;
  has Duration $.length;
  has Reference $.partOf;
  has Reference $.subject;
  has Reference @.basedOn;
  has Reference @.account;
  has CodeableConcept $.priority;
  has Identifier @.identifier;
  has CodeableConcept @.reasonCode;
  has CodeableConcept $.serviceType;
  has Reference @.appointment;
  has Reference @.episodeOfCare;
  has Reference @.reasonReference;
  has Reference $.serviceProvider;
  has Encounter_Location @.location;
  has Encounter_Diagnosis @.diagnosis;
  has Encounter_Participant @.participant;
  has Encounter_ClassHistory @.classHistory;
  has Encounter_StatusHistory @.statusHistory;
  has Encounter_Hospitalization $.hospitalization;
}
class Linkage_Item is FHIR is export {
  has Str $.id;
  has Code $.type is required;
  has Reference $.resource is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Linkage is DomainResource is export {
  method resourceType(--> 'Linkage') {}
  has Bool $.active;
  has Reference $.author;
  has Linkage_Item @.item is required;
}
class Measure_SupplementalData is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code;
  has CodeableConcept @.usage;
  has Expression $.criteria is required;
  has Extension @.extension;
  has Str $.description;
  has Extension @.modifierExtension;
}

class Measure_Group_Population is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code;
  has Expression $.criteria is required;
  has Extension @.extension;
  has Str $.description;
  has Extension @.modifierExtension;
}

class Measure_Group_Stratifier_Component is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code;
  has Expression $.criteria is required;
  has Extension @.extension;
  has Str $.description;
  has Extension @.modifierExtension;
}
class Measure_Group_Stratifier is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code;
  has Expression $.criteria;
  has Extension @.extension;
  has Str $.description;
  has Extension @.modifierExtension;
  has Measure_Group_Stratifier_Component @.component;
}
class Measure_Group is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code;
  has Extension @.extension;
  has Str $.description;
  has Extension @.modifierExtension;
  has Measure_Group_Population @.population;
  has Measure_Group_Stratifier @.stratifier;
}

class Measure is DomainResource is export {
  method resourceType(--> 'Measure') {}
  has UriStr $.url;
  has Str $.name;
  has DateTime $.date;
  has CodeableConcept @.type;
  has Str $.title;
  has Str $.usage;
  has CodeableConcept @.topic;
  has Code $.status is required;
  has ContactDetail @.author;
  has ContactDetail @.editor;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Canonical @.library;
  has CodeableConcept $.scoring;
  has Str $.subtitle;
  has ContactDetail @.reviewer;
  has ContactDetail @.endorser;
  has Markdown $.guidance;
  has Str $.publisher;
  has Markdown $.copyright;
  has Markdown $.rationale;
  has Identifier @.identifier;
  has ChoiceField $.subject where CodeableConcept|Reference;
  has UsageContext @.useContext;
  has Markdown $.disclaimer;
  has Markdown @.definition;
  has Markdown $.description;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has Date $.approvalDate;
  has Date $.lastReviewDate;
  has Str $.riskAdjustment;
  has Period $.effectivePeriod;
  has RelatedArtifact @.relatedArtifact;
  has Str $.rateAggregation;
  has CodeableConcept $.compositeScoring;
  has CodeableConcept $.improvementNotation;
  has Markdown $.clinicalRecommendationStatement;
  has Measure_SupplementalData @.supplementalData;
  has Measure_Group @.group;
}
class Communication_Payload is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has ChoiceField $.content is required where Attachment|Reference|Str;
  has Extension @.modifierExtension;
}

class Communication is DomainResource is export {
  method resourceType(--> 'Communication') {}
  has DateTime $.sent;
  has Annotation @.note;
  has CodeableConcept $.topic;
  has Reference @.about;
  has Reference @.partOf;
  has Code $.status is required;
  has CodeableConcept @.medium;
  has Reference $.sender;
  has Reference @.basedOn;
  has Reference $.subject;
  has CodeableConcept @.category;
  has Code $.priority;
  has DateTime $.received;
  has Reference $.encounter;
  has Reference @.recipient;
  has Identifier @.identifier;
  has CodeableConcept @.reasonCode;
  has Reference @.inResponseTo;
  has CodeableConcept $.statusReason;
  has UriStr @.instantiatesUri;
  has Reference @.reasonReference;
  has Canonical @.instantiatesCanonical;
  has Communication_Payload @.payload;
}
class MedicinalProductAuthorization_Procedure is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has ChoiceField $.date where DateTime|Period;
  has Extension @.extension;
  has Identifier $.identifier;
  has MedicinalProductAuthorization_Procedure @.application;
  has Extension @.modifierExtension;
}

class MedicinalProductAuthorization_JurisdictionalAuthorization is FHIR is export {
  has Str $.id;
  has CodeableConcept $.country;
  has Extension @.extension;
  has Identifier @.identifier;
  has CodeableConcept @.jurisdiction;
  has Period $.validityPeriod;
  has Extension @.modifierExtension;
  has CodeableConcept $.legalStatusOfSupply;
}

class MedicinalProductAuthorization is DomainResource is export {
  method resourceType(--> 'MedicinalProductAuthorization') {}
  has CodeableConcept $.status;
  has Reference $.holder;
  has Reference $.subject;
  has CodeableConcept @.country;
  has Reference $.regulator;
  has Identifier @.identifier;
  has DateTime $.statusDate;
  has CodeableConcept $.legalBasis;
  has DateTime $.restoreDate;
  has CodeableConcept @.jurisdiction;
  has Period $.validityPeriod;
  has Period $.dataExclusivityPeriod;
  has DateTime $.internationalBirthDate;
  has DateTime $.dateOfFirstAuthorization;
  has MedicinalProductAuthorization_Procedure $.procedure;
  has MedicinalProductAuthorization_JurisdictionalAuthorization @.jurisdictionalAuthorization;
}
class Immunization_Reaction is FHIR is export {
  has Str $.id;
  has DateTime $.date;
  has Reference $.detail;
  has Bool $.reported;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Immunization_Performer is FHIR is export {
  has Str $.id;
  has Reference $.actor is required;
  has CodeableConcept $.function;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Immunization_Education is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has UriStr $.reference;
  has Str $.documentType;
  has DateTime $.publicationDate;
  has DateTime $.presentationDate;
  has Extension @.modifierExtension;
}

class Immunization_ProtocolApplied is FHIR is export {
  has Str $.id;
  has Str $.series;
  has Extension @.extension;
  has Reference $.authority;
  has CodeableConcept @.targetDisease;
  has ChoiceField $.doseNumber is required where PositiveInt|Str;
  has ChoiceField $.seriesDoses where PositiveInt|Str;
  has Extension @.modifierExtension;
}

class Immunization is DomainResource is export {
  method resourceType(--> 'Immunization') {}
  has CodeableConcept $.site;
  has Annotation @.note;
  has CodeableConcept $.route;
  has Code $.status is required;
  has Reference $.patient is required;
  has DateTime $.recorded;
  has Reference $.location;
  has Reference $.encounter;
  has Str $.lotNumber;
  has Identifier @.identifier;
  has CodeableConcept @.reasonCode;
  has CodeableConcept $.vaccineCode is required;
  has Bool $.isSubpotent;
  has CodeableConcept $.statusReason;
  has CodeableConcept $.reportOrigin;
  has Reference $.manufacturer;
  has Quantity $.doseQuantity;
  has ChoiceField $.occurrence is required where DateTime|Str;
  has Bool $.primarySource;
  has CodeableConcept $.fundingSource;
  has Date $.expirationDate;
  has Reference @.reasonReference;
  has CodeableConcept @.subpotentReason;
  has CodeableConcept @.programEligibility;
  has Immunization_Reaction @.reaction;
  has Immunization_Performer @.performer;
  has Immunization_Education @.education;
  has Immunization_ProtocolApplied @.protocolApplied;
}
class AuditEvent_Source is FHIR is export {
  has Str $.id;
  has Str $.site;
  has Coding @.type;
  has Reference $.observer is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class AuditEvent_Agent_Network is FHIR is export {
  has Str $.id;
  has Code $.type;
  has Str $.address;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class AuditEvent_Agent is FHIR is export {
  has Str $.id;
  has Reference $.who;
  has CodeableConcept $.type;
  has CodeableConcept @.role;
  has Str $.name;
  has Str $.altId;
  has Coding $.media;
  has UriStr @.policy;
  has Reference $.location;
  has Extension @.extension;
  has Bool $.requestor is required;
  has CodeableConcept @.purposeOfUse;
  has Extension @.modifierExtension;
  has AuditEvent_Agent_Network $.network;
}

class AuditEvent_Entity_Detail is FHIR is export {
  has Str $.id;
  has Str $.type is required;
  has ChoiceField $.value is required where Base64Binary|Str;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class AuditEvent_Entity is FHIR is export {
  has Str $.id;
  has Reference $.what;
  has Coding $.type;
  has Coding $.role;
  has Str $.name;
  has Base64Binary $.query;
  has Extension @.extension;
  has Coding $.lifecycle;
  has Str $.description;
  has Coding @.securityLabel;
  has Extension @.modifierExtension;
  has AuditEvent_Entity_Detail @.detail;
}

class AuditEvent is DomainResource is export {
  method resourceType(--> 'AuditEvent') {}
  has Coding $.type is required;
  has Code $.action;
  has Period $.period;
  has Coding @.subtype;
  has Code $.outcome;
  has DateTime $.recorded is required;
  has Str $.outcomeDesc;
  has CodeableConcept @.purposeOfEvent;
  has AuditEvent_Source $.source is required;
  has AuditEvent_Agent @.agent is required;
  has AuditEvent_Entity @.entity;
}
class ImplementationGuide_Global is FHIR is export {
  has Str $.id;
  has Code $.type is required;
  has Canonical $.profile is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class ImplementationGuide_DependsOn is FHIR is export {
  has Str $.id;
  has Canonical $.uri is required;
  has Str $.version;
  has Extension @.extension;
  has Id $.packageId;
  has Extension @.modifierExtension;
}

class ImplementationGuide_Manifest_Page is FHIR is export {
  has Str $.id;
  has Str $.name is required;
  has Str $.title;
  has Str @.anchor;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class ImplementationGuide_Manifest_Resource is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Reference $.reference is required;
  has ChoiceField $.example where Bool|Canonical;
  has UrlStr $.relativePath;
  has Extension @.modifierExtension;
}
class ImplementationGuide_Manifest is FHIR is export {
  has Str $.id;
  has Str @.image;
  has Str @.other;
  has Extension @.extension;
  has UrlStr $.rendering;
  has Extension @.modifierExtension;
  has ImplementationGuide_Manifest_Page @.page;
  has ImplementationGuide_Manifest_Resource @.resource is required;
}

class ImplementationGuide_Definition_Page is FHIR is export {
  has Str $.id;
  has ImplementationGuide_Definition_Page @.page;
  has Str $.title is required;
  has ChoiceField $.name is required where Reference|UrlStr;
  has Extension @.extension;
  has Code $.generation is required;
  has Extension @.modifierExtension;
}

class ImplementationGuide_Definition_Grouping is FHIR is export {
  has Str $.id;
  has Str $.name is required;
  has Extension @.extension;
  has Str $.description;
  has Extension @.modifierExtension;
}

class ImplementationGuide_Definition_Resource is FHIR is export {
  has Str $.id;
  has Str $.name;
  has Extension @.extension;
  has Reference $.reference is required;
  has ChoiceField $.example where Bool|Canonical;
  has Id $.groupingId;
  has Code @.fhirVersion;
  has Str $.description;
  has Extension @.modifierExtension;
}

class ImplementationGuide_Definition_Template is FHIR is export {
  has Str $.id;
  has Code $.code is required;
  has Str $.scope;
  has Str $.source is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class ImplementationGuide_Definition_Parameter is FHIR is export {
  has Str $.id;
  has Code $.code is required;
  has Str $.value is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class ImplementationGuide_Definition is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has ImplementationGuide_Definition_Page $.page;
  has ImplementationGuide_Definition_Grouping @.grouping;
  has ImplementationGuide_Definition_Resource @.resource is required;
  has ImplementationGuide_Definition_Template @.template;
  has ImplementationGuide_Definition_Parameter @.parameter;
}

class ImplementationGuide is DomainResource is export {
  method resourceType(--> 'ImplementationGuide') {}
  has UriStr $.url is required;
  has Str $.name is required;
  has DateTime $.date;
  has Str $.title;
  has Code $.status is required;
  has Str $.version;
  has ContactDetail @.contact;
  has Code $.license;
  has Str $.publisher;
  has Markdown $.copyright;
  has Id $.packageId is required;
  has UsageContext @.useContext;
  has Markdown $.description;
  has Code @.fhirVersion is required;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has ImplementationGuide_Global @.global;
  has ImplementationGuide_DependsOn @.dependsOn;
  has ImplementationGuide_Manifest $.manifest;
  has ImplementationGuide_Definition $.definition;
}

class ResearchDefinition is DomainResource is export {
  method resourceType(--> 'ResearchDefinition') {}
  has UriStr $.url;
  has Str $.name;
  has DateTime $.date;
  has Str $.title;
  has Str $.usage;
  has CodeableConcept @.topic;
  has Code $.status is required;
  has ContactDetail @.author;
  has ContactDetail @.editor;
  has Str $.version;
  has ContactDetail @.contact;
  has Str @.comment;
  has Markdown $.purpose;
  has Canonical @.library;
  has Reference $.outcome;
  has Str $.subtitle;
  has ContactDetail @.reviewer;
  has ContactDetail @.endorser;
  has Reference $.exposure;
  has Str $.publisher;
  has Markdown $.copyright;
  has Identifier @.identifier;
  has Str $.shortTitle;
  has ChoiceField $.subject where CodeableConcept|Reference;
  has UsageContext @.useContext;
  has Reference $.population is required;
  has Markdown $.description;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has Date $.approvalDate;
  has Date $.lastReviewDate;
  has Period $.effectivePeriod;
  has RelatedArtifact @.relatedArtifact;
  has Reference $.exposureAlternative;
}
class CommunicationRequest_Payload is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has ChoiceField $.content is required where Attachment|Reference|Str;
  has Extension @.modifierExtension;
}

class CommunicationRequest is DomainResource is export {
  method resourceType(--> 'CommunicationRequest') {}
  has Annotation @.note;
  has Reference @.about;
  has Code $.status is required;
  has CodeableConcept @.medium;
  has Reference $.sender;
  has Reference @.basedOn;
  has Reference $.subject;
  has Reference @.replaces;
  has CodeableConcept @.category;
  has Code $.priority;
  has Reference $.encounter;
  has Reference $.requester;
  has Reference @.recipient;
  has Identifier @.identifier;
  has DateTime $.authoredOn;
  has CodeableConcept @.reasonCode;
  has CodeableConcept $.statusReason;
  has Bool $.doNotPerform;
  has ChoiceField $.occurrence where DateTime|Period;
  has Identifier $.groupIdentifier;
  has Reference @.reasonReference;
  has CommunicationRequest_Payload @.payload;
}
class Person_Link is FHIR is export {
  has Str $.id;
  has Reference $.target is required;
  has Extension @.extension;
  has Code $.assurance;
  has Extension @.modifierExtension;
}

class Person is DomainResource is export {
  method resourceType(--> 'Person') {}
  has HumanName @.name;
  has Attachment $.photo;
  has Code $.gender;
  has Bool $.active;
  has ContactPoint @.telecom;
  has Address @.address;
  has Date $.birthDate;
  has Identifier @.identifier;
  has Reference $.managingOrganization;
  has Person_Link @.link;
}
class RequestGroup_Action_Condition is FHIR is export {
  has Str $.id;
  has Code $.kind is required;
  has Extension @.extension;
  has Expression $.expression;
  has Extension @.modifierExtension;
}

class RequestGroup_Action_RelatedAction is FHIR is export {
  has Str $.id;
  has Id $.actionId is required;
  has Extension @.extension;
  has ChoiceField $.offset where Duration|Range;
  has Code $.relationship is required;
  has Extension @.modifierExtension;
}
class RequestGroup_Action is FHIR is export {
  has Str $.id;
  has CodeableConcept @.code;
  has CodeableConcept $.type;
  has Str $.title;
  has Str $.prefix;
  has RequestGroup_Action @.action;
  has Code $.priority;
  has Reference $.resource;
  has Extension @.extension;
  has ChoiceField $.timing where Age|Duration|DateTime|Period|Range|Timing;
  has Str $.description;
  has Reference @.participant;
  has RelatedArtifact @.documentation;
  has Str $.textEquivalent;
  has Code $.groupingBehavior;
  has Code $.requiredBehavior;
  has Code $.precheckBehavior;
  has Extension @.modifierExtension;
  has Code $.selectionBehavior;
  has Code $.cardinalityBehavior;
  has RequestGroup_Action_Condition @.condition;
  has RequestGroup_Action_RelatedAction @.relatedAction;
}

class RequestGroup is DomainResource is export {
  method resourceType(--> 'RequestGroup') {}
  has CodeableConcept $.code;
  has Annotation @.note;
  has Code $.status is required;
  has Code $.intent is required;
  has Reference $.author;
  has Reference @.basedOn;
  has Reference $.subject;
  has Reference @.replaces;
  has Code $.priority;
  has Reference $.encounter;
  has Identifier @.identifier;
  has DateTime $.authoredOn;
  has CodeableConcept @.reasonCode;
  has UriStr @.instantiatesUri;
  has Identifier $.groupIdentifier;
  has Reference @.reasonReference;
  has Canonical @.instantiatesCanonical;
  has RequestGroup_Action @.action;
}
class DeviceDefinition_Property is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Extension @.extension;
  has CodeableConcept @.valueCode;
  has Quantity @.valueQuantity;
  has Extension @.modifierExtension;
}

class DeviceDefinition_DeviceName is FHIR is export {
  has Str $.id;
  has Str $.name is required;
  has Code $.type is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class DeviceDefinition_Capability is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Extension @.extension;
  has CodeableConcept @.description;
  has Extension @.modifierExtension;
}

class DeviceDefinition_Material is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has CodeableConcept $.substance is required;
  has Bool $.alternate;
  has Extension @.modifierExtension;
  has Bool $.allergenicIndicator;
}

class DeviceDefinition_Specialization is FHIR is export {
  has Str $.id;
  has Str $.version;
  has Extension @.extension;
  has Str $.systemType is required;
  has Extension @.modifierExtension;
}

class DeviceDefinition_UdiDeviceIdentifier is FHIR is export {
  has Str $.id;
  has UriStr $.issuer is required;
  has Extension @.extension;
  has UriStr $.jurisdiction is required;
  has Str $.deviceIdentifier is required;
  has Extension @.modifierExtension;
}

class DeviceDefinition is DomainResource is export {
  method resourceType(--> 'DeviceDefinition') {}
  has UriStr $.url;
  has CodeableConcept $.type;
  has Annotation @.note;
  has Reference $.owner;
  has CodeableConcept @.safety;
  has Str @.version;
  has ContactPoint @.contact;
  has Quantity $.quantity;
  has Identifier @.identifier;
  has Str $.modelNumber;
  has CodeableConcept @.languageCode;
  has Reference $.parentDevice;
  has ChoiceField $.manufacturer where Reference|Str;
  has Any @.shelfLifeStorage;
  has UriStr $.onlineInformation;
  has Any $.physicalCharacteristics;
  has DeviceDefinition_Property @.property;
  has DeviceDefinition_DeviceName @.deviceName;
  has DeviceDefinition_Capability @.capability;
  has DeviceDefinition_Material @.material;
  has DeviceDefinition_Specialization @.specialization;
  has DeviceDefinition_UdiDeviceIdentifier @.udiDeviceIdentifier;
}
class CompartmentDefinition_Resource is FHIR is export {
  has Str $.id;
  has Code $.code is required;
  has Str @.param;
  has Extension @.extension;
  has Str $.documentation;
  has Extension @.modifierExtension;
}

class CompartmentDefinition is DomainResource is export {
  method resourceType(--> 'CompartmentDefinition') {}
  has UriStr $.url is required;
  has Str $.name is required;
  has DateTime $.date;
  has Code $.code is required;
  has Code $.status is required;
  has Bool $.search is required;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Str $.publisher;
  has UsageContext @.useContext;
  has Markdown $.description;
  has Bool $.experimental;
  has CompartmentDefinition_Resource @.resource;
}
class PaymentReconciliation_Detail is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Date $.date;
  has Reference $.payee;
  has Money $.amount;
  has Reference $.request;
  has Reference $.response;
  has Extension @.extension;
  has Reference $.submitter;
  has Identifier $.identifier;
  has Identifier $.predecessor;
  has Reference $.responsible;
  has Extension @.modifierExtension;
}

class PaymentReconciliation_ProcessNote is FHIR is export {
  has Str $.id;
  has Code $.type;
  has Str $.text;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class PaymentReconciliation is DomainResource is export {
  method resourceType(--> 'PaymentReconciliation') {}
  has Code $.status is required;
  has Period $.period;
  has DateTime $.created is required;
  has Reference $.request;
  has Code $.outcome;
  has CodeableConcept $.formCode;
  has Reference $.requestor;
  has Identifier @.identifier;
  has Str $.disposition;
  has Date $.paymentDate is required;
  has Reference $.paymentIssuer;
  has Money $.paymentAmount is required;
  has Identifier $.paymentIdentifier;
  has PaymentReconciliation_Detail @.detail;
  has PaymentReconciliation_ProcessNote @.processNote;
}
class MedicationKnowledge_Cost is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Money $.cost is required;
  has Str $.source;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MedicationKnowledge_Kinetics is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Quantity @.lethalDose50;
  has Quantity @.areaUnderCurve;
  has Duration $.halfLifePeriod;
  has Extension @.modifierExtension;
}

class MedicationKnowledge_Monograph is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Reference $.source;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MedicationKnowledge_Packaging is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Quantity $.quantity;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MedicationKnowledge_Ingredient is FHIR is export {
  has Str $.id;
  has ChoiceField $.item is required where CodeableConcept|Reference;
  has Bool $.isActive;
  has Ratio $.strength;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MedicationKnowledge_MonitoringProgram is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Str $.name;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MedicationKnowledge_DrugCharacteristic is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has ChoiceField $.value where Base64Binary|CodeableConcept|Quantity|Str;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MedicationKnowledge_MedicineClassification is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Extension @.extension;
  has CodeableConcept @.classification;
  has Extension @.modifierExtension;
}

class MedicationKnowledge_Regulatory_Schedule is FHIR is export {
  has Str $.id;
  has CodeableConcept $.schedule is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MedicationKnowledge_Regulatory_MaxDispense is FHIR is export {
  has Str $.id;
  has Duration $.period;
  has Quantity $.quantity is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MedicationKnowledge_Regulatory_Substitution is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Bool $.allowed is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class MedicationKnowledge_Regulatory is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has Reference $.regulatoryAuthority is required;
  has MedicationKnowledge_Regulatory_Schedule @.schedule;
  has MedicationKnowledge_Regulatory_MaxDispense $.maxDispense;
  has MedicationKnowledge_Regulatory_Substitution @.substitution;
}

class MedicationKnowledge_RelatedMedicationKnowledge is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Extension @.extension;
  has Reference @.reference is required;
  has Extension @.modifierExtension;
}

class MedicationKnowledge_AdministrationGuidelines_Dosage is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Dosage @.dosage is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MedicationKnowledge_AdministrationGuidelines_PatientCharacteristics is FHIR is export {
  has Str $.id;
  has Str @.value;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has ChoiceField $.characteristic is required where CodeableConcept|Quantity;
}
class MedicationKnowledge_AdministrationGuidelines is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has ChoiceField $.indication where CodeableConcept|Reference;
  has Extension @.modifierExtension;
  has MedicationKnowledge_AdministrationGuidelines_Dosage @.dosage;
  has MedicationKnowledge_AdministrationGuidelines_PatientCharacteristics @.patientCharacteristics;
}

class MedicationKnowledge is DomainResource is export {
  method resourceType(--> 'MedicationKnowledge') {}
  has CodeableConcept $.code;
  has Code $.status;
  has Quantity $.amount;
  has Str @.synonym;
  has CodeableConcept $.doseForm;
  has CodeableConcept @.productType;
  has Reference $.manufacturer;
  has CodeableConcept @.intendedRoute;
  has Reference @.contraindication;
  has Reference @.associatedMedication;
  has Markdown $.preparationInstruction;
  has MedicationKnowledge_Cost @.cost;
  has MedicationKnowledge_Kinetics @.kinetics;
  has MedicationKnowledge_Monograph @.monograph;
  has MedicationKnowledge_Packaging $.packaging;
  has MedicationKnowledge_Ingredient @.ingredient;
  has MedicationKnowledge_MonitoringProgram @.monitoringProgram;
  has MedicationKnowledge_DrugCharacteristic @.drugCharacteristic;
  has MedicationKnowledge_MedicineClassification @.medicineClassification;
  has MedicationKnowledge_Regulatory @.regulatory;
  has MedicationKnowledge_RelatedMedicationKnowledge @.relatedMedicationKnowledge;
  has MedicationKnowledge_AdministrationGuidelines @.administrationGuidelines;
}

class Slot is DomainResource is export {
  method resourceType(--> 'Slot') {}
  has DateTime $.end is required;
  has DateTime $.start is required;
  has Code $.status is required;
  has Str $.comment;
  has Reference $.schedule is required;
  has CodeableConcept @.specialty;
  has Identifier @.identifier;
  has Bool $.overbooked;
  has CodeableConcept @.serviceType;
  has CodeableConcept @.serviceCategory;
  has CodeableConcept $.appointmentType;
}

class MedicationStatement is DomainResource is export {
  method resourceType(--> 'MedicationStatement') {}
  has Annotation @.note;
  has Reference @.partOf;
  has Code $.status is required;
  has Dosage @.dosage;
  has Reference @.basedOn;
  has Reference $.subject is required;
  has Reference $.context;
  has CodeableConcept $.category;
  has Identifier @.identifier;
  has CodeableConcept @.reasonCode;
  has Reference @.derivedFrom;
  has CodeableConcept @.statusReason;
  has ChoiceField $.effective where DateTime|Period;
  has DateTime $.dateAsserted;
  has ChoiceField $.medication is required where CodeableConcept|Reference;
  has Reference @.reasonReference;
  has Reference $.informationSource;
}
class DiagnosticReport_Media is FHIR is export {
  has Str $.id;
  has Reference $.link is required;
  has Str $.comment;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class DiagnosticReport is DomainResource is export {
  method resourceType(--> 'DiagnosticReport') {}
  has CodeableConcept $.code is required;
  has Code $.status is required;
  has DateTime $.issued;
  has Reference @.result;
  has Reference @.basedOn;
  has Reference $.subject;
  has CodeableConcept @.category;
  has Reference @.specimen;
  has Reference $.encounter;
  has Reference @.performer;
  has Identifier @.identifier;
  has Str $.conclusion;
  has ChoiceField $.effective where DateTime|Period;
  has Reference @.imagingStudy;
  has Attachment @.presentedForm;
  has CodeableConcept @.conclusionCode;
  has Reference @.resultsInterpreter;
  has DiagnosticReport_Media @.media;
}
class SpecimenDefinition_TypeTested_Handling is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Duration $.maxDuration;
  has Str $.instruction;
  has Range $.temperatureRange;
  has Extension @.modifierExtension;
  has CodeableConcept $.temperatureQualifier;
}

class SpecimenDefinition_TypeTested_Container_Additive is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has ChoiceField $.additive is required where CodeableConcept|Reference;
  has Extension @.modifierExtension;
}
class SpecimenDefinition_TypeTested_Container is FHIR is export {
  has Str $.id;
  has CodeableConcept $.cap;
  has CodeableConcept $.type;
  has CodeableConcept $.material;
  has Quantity $.capacity;
  has Extension @.extension;
  has Str $.description;
  has Str $.preparation;
  has ChoiceField $.minimumVolume where Quantity|Str;
  has Extension @.modifierExtension;
  has SpecimenDefinition_TypeTested_Container_Additive @.additive;
}
class SpecimenDefinition_TypeTested is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Extension @.extension;
  has Bool $.isDerived;
  has Code $.preference is required;
  has Str $.requirement;
  has Duration $.retentionTime;
  has Extension @.modifierExtension;
  has CodeableConcept @.rejectionCriterion;
  has SpecimenDefinition_TypeTested_Handling @.handling;
  has SpecimenDefinition_TypeTested_Container $.container;
}

class SpecimenDefinition is DomainResource is export {
  method resourceType(--> 'SpecimenDefinition') {}
  has Identifier $.identifier;
  has Str $.timeAspect;
  has CodeableConcept @.collection;
  has CodeableConcept $.typeCollected;
  has CodeableConcept @.patientPreparation;
  has SpecimenDefinition_TypeTested @.typeTested;
}
class SubstanceReferenceInformation_Gene is FHIR is export {
  has Str $.id;
  has CodeableConcept $.gene;
  has Reference @.source;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has CodeableConcept $.geneSequenceOrigin;
}

class SubstanceReferenceInformation_Target is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Identifier $.target;
  has Reference @.source;
  has CodeableConcept $.organism;
  has Extension @.extension;
  has ChoiceField $.amount where Quantity|Range|Str;
  has CodeableConcept $.amountType;
  has CodeableConcept $.interaction;
  has CodeableConcept $.organismType;
  has Extension @.modifierExtension;
}

class SubstanceReferenceInformation_GeneElement is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Reference @.source;
  has Identifier $.element;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class SubstanceReferenceInformation_Classification is FHIR is export {
  has Str $.id;
  has CodeableConcept $.domain;
  has Reference @.source;
  has CodeableConcept @.subtype;
  has Extension @.extension;
  has CodeableConcept $.classification;
  has Extension @.modifierExtension;
}

class SubstanceReferenceInformation is DomainResource is export {
  method resourceType(--> 'SubstanceReferenceInformation') {}
  has Str $.comment;
  has SubstanceReferenceInformation_Gene @.gene;
  has SubstanceReferenceInformation_Target @.target;
  has SubstanceReferenceInformation_GeneElement @.geneElement;
  has SubstanceReferenceInformation_Classification @.classification;
}
class MedicinalProduct_SpecialDesignation is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has DateTime $.date;
  has CodeableConcept $.status;
  has CodeableConcept $.species;
  has Extension @.extension;
  has Identifier @.identifier;
  has CodeableConcept $.intendedUse;
  has ChoiceField $.indication where CodeableConcept|Reference;
  has Extension @.modifierExtension;
}

class MedicinalProduct_Name_NamePart is FHIR is export {
  has Str $.id;
  has Str $.part is required;
  has Coding $.type is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MedicinalProduct_Name_CountryLanguage is FHIR is export {
  has Str $.id;
  has CodeableConcept $.country is required;
  has CodeableConcept $.language is required;
  has Extension @.extension;
  has CodeableConcept $.jurisdiction;
  has Extension @.modifierExtension;
}
class MedicinalProduct_Name is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Str $.productName is required;
  has Extension @.modifierExtension;
  has MedicinalProduct_Name_NamePart @.namePart;
  has MedicinalProduct_Name_CountryLanguage @.countryLanguage;
}

class MedicinalProduct_ManufacturingBusinessOperation is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Reference $.regulator;
  has Reference @.manufacturer;
  has CodeableConcept $.operationType;
  has DateTime $.effectiveDate;
  has Extension @.modifierExtension;
  has CodeableConcept $.confidentialityIndicator;
  has Identifier $.authorisationReferenceNumber;
}

class MedicinalProduct is DomainResource is export {
  method resourceType(--> 'MedicinalProduct') {}
  has CodeableConcept $.type;
  has Coding $.domain;
  has Reference @.contact;
  has Identifier @.identifier;
  has Reference @.masterFile;
  has Reference @.clinicalTrial;
  has Identifier @.crossReference;
  has Str @.specialMeasures;
  has Any @.marketingStatus;
  has Reference @.attachedDocument;
  has CodeableConcept $.legalStatusOfSupply;
  has CodeableConcept @.productClassification;
  has Reference @.pharmaceuticalProduct;
  has CodeableConcept $.paediatricUseIndicator;
  has Reference @.packagedMedicinalProduct;
  has CodeableConcept $.additionalMonitoringIndicator;
  has CodeableConcept $.combinedPharmaceuticalDoseForm;
  has MedicinalProduct_SpecialDesignation @.specialDesignation;
  has MedicinalProduct_Name @.name is required;
  has MedicinalProduct_ManufacturingBusinessOperation @.manufacturingBusinessOperation;
}
class EpisodeOfCare_Diagnosis is FHIR is export {
  has Str $.id;
  has CodeableConcept $.role;
  has PositiveInt $.rank;
  has Extension @.extension;
  has Reference $.condition is required;
  has Extension @.modifierExtension;
}

class EpisodeOfCare_StatusHistory is FHIR is export {
  has Str $.id;
  has Code $.status is required;
  has Period $.period is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class EpisodeOfCare is DomainResource is export {
  method resourceType(--> 'EpisodeOfCare') {}
  has CodeableConcept @.type;
  has Reference @.team;
  has Code $.status is required;
  has Period $.period;
  has Reference $.patient is required;
  has Reference @.account;
  has Identifier @.identifier;
  has Reference $.careManager;
  has Reference @.referralRequest;
  has Reference $.managingOrganization;
  has EpisodeOfCare_Diagnosis @.diagnosis;
  has EpisodeOfCare_StatusHistory @.statusHistory;
}
class ResearchElementDefinition_Characteristic is FHIR is export {
  has Str $.id;
  has Bool $.exclude;
  has Extension @.extension;
  has UsageContext @.usageContext;
  has ChoiceField $.definition is required where Canonical|CodeableConcept|DataRequirement|Expression;
  has CodeableConcept $.unitOfMeasure;
  has Extension @.modifierExtension;
  has ChoiceField $.studyEffective where Duration|DateTime|Period|Timing;
  has ChoiceField $.participantEffective where Duration|DateTime|Period|Timing;
  has Str $.studyEffectiveDescription;
  has Code $.studyEffectiveGroupMeasure;
  has Duration $.studyEffectiveTimeFromStart;
  has Str $.participantEffectiveDescription;
  has Code $.participantEffectiveGroupMeasure;
  has Duration $.participantEffectiveTimeFromStart;
}

class ResearchElementDefinition is DomainResource is export {
  method resourceType(--> 'ResearchElementDefinition') {}
  has UriStr $.url;
  has Str $.name;
  has DateTime $.date;
  has Code $.type is required;
  has Str $.title;
  has Str $.usage;
  has CodeableConcept @.topic;
  has Code $.status is required;
  has ContactDetail @.author;
  has ContactDetail @.editor;
  has Str $.version;
  has ContactDetail @.contact;
  has Str @.comment;
  has Markdown $.purpose;
  has Canonical @.library;
  has Str $.subtitle;
  has ContactDetail @.reviewer;
  has ContactDetail @.endorser;
  has Str $.publisher;
  has Markdown $.copyright;
  has Identifier @.identifier;
  has Str $.shortTitle;
  has ChoiceField $.subject where CodeableConcept|Reference;
  has UsageContext @.useContext;
  has Markdown $.description;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has Date $.approvalDate;
  has Code $.variableType;
  has Date $.lastReviewDate;
  has Period $.effectivePeriod;
  has RelatedArtifact @.relatedArtifact;
  has ResearchElementDefinition_Characteristic @.characteristic is required;
}
class Account_Coverage is FHIR is export {
  has Str $.id;
  has Reference $.coverage is required;
  has PositiveInt $.priority;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Account_Guarantor is FHIR is export {
  has Str $.id;
  has Reference $.party is required;
  has Bool $.onHold;
  has Period $.period;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Account is DomainResource is export {
  method resourceType(--> 'Account') {}
  has CodeableConcept $.type;
  has Str $.name;
  has Reference $.owner;
  has Code $.status is required;
  has Reference $.partOf;
  has Reference @.subject;
  has Identifier @.identifier;
  has Str $.description;
  has Period $.servicePeriod;
  has Account_Coverage @.coverage;
  has Account_Guarantor @.guarantor;
}
class ChargeItemDefinition_Applicability is FHIR is export {
  has Str $.id;
  has Str $.language;
  has Extension @.extension;
  has Str $.expression;
  has Str $.description;
  has Extension @.modifierExtension;
}

class ChargeItemDefinition_PropertyGroup_PriceComponent is FHIR is export {
  has Str $.id;
  has Code $.type is required;
  has CodeableConcept $.code;
  has Real $.factor;
  has Money $.amount;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class ChargeItemDefinition_PropertyGroup is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has ChargeItemDefinition_Applicability @.applicability;
  has Extension @.modifierExtension;
  has ChargeItemDefinition_PropertyGroup_PriceComponent @.priceComponent;
}

class ChargeItemDefinition is DomainResource is export {
  method resourceType(--> 'ChargeItemDefinition') {}
  has UriStr $.url is required;
  has DateTime $.date;
  has CodeableConcept $.code;
  has Str $.title;
  has Canonical @.partOf;
  has Code $.status is required;
  has Str $.version;
  has ContactDetail @.contact;
  has Canonical @.replaces;
  has Reference @.instance;
  has Str $.publisher;
  has Markdown $.copyright;
  has Identifier @.identifier;
  has UsageContext @.useContext;
  has Markdown $.description;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has Date $.approvalDate;
  has UriStr @.derivedFromUri;
  has Date $.lastReviewDate;
  has Period $.effectivePeriod;
  has ChargeItemDefinition_Applicability @.applicability;
  has ChargeItemDefinition_PropertyGroup @.propertyGroup;
}
class CareTeam_Participant is FHIR is export {
  has Str $.id;
  has CodeableConcept @.role;
  has Reference $.member;
  has Period $.period;
  has Extension @.extension;
  has Reference $.onBehalfOf;
  has Extension @.modifierExtension;
}

class CareTeam is DomainResource is export {
  method resourceType(--> 'CareTeam') {}
  has Str $.name;
  has Annotation @.note;
  has Code $.status;
  has Period $.period;
  has Reference $.subject;
  has ContactPoint @.telecom;
  has CodeableConcept @.category;
  has Reference $.encounter;
  has Identifier @.identifier;
  has CodeableConcept @.reasonCode;
  has Reference @.reasonReference;
  has Reference @.managingOrganization;
  has CareTeam_Participant @.participant;
}
class NamingSystem_UniqueId is FHIR is export {
  has Str $.id;
  has Code $.type is required;
  has Str $.value is required;
  has Period $.period;
  has Str $.comment;
  has Extension @.extension;
  has Bool $.preferred;
  has Extension @.modifierExtension;
}

class NamingSystem is DomainResource is export {
  method resourceType(--> 'NamingSystem') {}
  has Str $.name is required;
  has Code $.kind is required;
  has DateTime $.date is required;
  has CodeableConcept $.type;
  has Str $.usage;
  has Code $.status is required;
  has ContactDetail @.contact;
  has Str $.publisher;
  has UsageContext @.useContext;
  has Str $.responsible;
  has Markdown $.description;
  has CodeableConcept @.jurisdiction;
  has NamingSystem_UniqueId @.uniqueId is required;
}
class DeviceRequest_Parameter is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code;
  has ChoiceField $.value where Bool|CodeableConcept|Quantity|Range;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class DeviceRequest is DomainResource is export {
  method resourceType(--> 'DeviceRequest') {}
  has Annotation @.note;
  has Code $.status;
  has Code $.intent is required;
  has Reference @.basedOn;
  has ChoiceField $.code is required where CodeableConcept|Reference;
  has Reference $.subject is required;
  has Code $.priority;
  has Reference $.encounter;
  has Reference $.requester;
  has Reference $.performer;
  has Reference @.insurance;
  has Identifier @.identifier;
  has DateTime $.authoredOn;
  has CodeableConcept @.reasonCode;
  has Reference @.priorRequest;
  has ChoiceField $.occurrence where DateTime|Period|Timing;
  has CodeableConcept $.performerType;
  has Reference @.supportingInfo;
  has UriStr @.instantiatesUri;
  has Identifier $.groupIdentifier;
  has Reference @.reasonReference;
  has Reference @.relevantHistory;
  has Canonical @.instantiatesCanonical;
  has DeviceRequest_Parameter @.parameter;
}
class QuestionnaireResponse_Item_Answer is FHIR is export {
  has Str $.id;
  has QuestionnaireResponse_Item @.item;
  has ChoiceField $.value where Attachment|Bool|Coding|Real|Date|DateTime|Int|Instant|Quantity|Reference|Str|UriStr;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class QuestionnaireResponse_Item is FHIR is export {
  has Str $.id;
  has Str $.text;
  has QuestionnaireResponse_Item @.item;
  has Str $.linkId is required;
  has Extension @.extension;
  has UriStr $.definition;
  has Extension @.modifierExtension;
  has QuestionnaireResponse_Item_Answer @.answer;
}

class QuestionnaireResponse is DomainResource is export {
  method resourceType(--> 'QuestionnaireResponse') {}
  has Reference @.partOf;
  has Code $.status is required;
  has Reference $.author;
  has Reference $.source;
  has Reference @.basedOn;
  has Reference $.subject;
  has DateTime $.authored;
  has Reference $.encounter;
  has Identifier $.identifier;
  has Canonical $.questionnaire;
  has QuestionnaireResponse_Item @.item;
}
class CodeSystem_Filter is FHIR is export {
  has Str $.id;
  has Code $.code is required;
  has Str $.value is required;
  has Code @.operator is required;
  has Extension @.extension;
  has Str $.description;
  has Extension @.modifierExtension;
}

class CodeSystem_Property is FHIR is export {
  has Str $.id;
  has UriStr $.uri;
  has Code $.code is required;
  has Code $.type is required;
  has Extension @.extension;
  has Str $.description;
  has Extension @.modifierExtension;
}

class CodeSystem_Concept_Property is FHIR is export {
  has Str $.id;
  has Code $.code is required;
  has ChoiceField $.value is required where Bool|Code|Coding|Real|DateTime|Int|Str;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class CodeSystem_Concept_Designation is FHIR is export {
  has Str $.id;
  has Coding $.use;
  has Str $.value is required;
  has Code $.language;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class CodeSystem_Concept is FHIR is export {
  has Str $.id;
  has Code $.code is required;
  has Str $.display;
  has CodeSystem_Concept @.concept;
  has Extension @.extension;
  has Str $.definition;
  has Extension @.modifierExtension;
  has CodeSystem_Concept_Property @.property;
  has CodeSystem_Concept_Designation @.designation;
}

class CodeSystem is DomainResource is export {
  method resourceType(--> 'CodeSystem') {}
  has UriStr $.url;
  has Str $.name;
  has DateTime $.date;
  has Str $.title;
  has UnsignedInt $.count;
  has Code $.status is required;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Code $.content is required;
  has Canonical $.valueSet;
  has Str $.publisher;
  has Markdown $.copyright;
  has Identifier @.identifier;
  has UsageContext @.useContext;
  has Markdown $.description;
  has Canonical $.supplements;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has Bool $.caseSensitive;
  has Bool $.compositional;
  has Bool $.versionNeeded;
  has Code $.hierarchyMeaning;
  has CodeSystem_Filter @.filter;
  has CodeSystem_Property @.property;
  has CodeSystem_Concept @.concept;
}
class SubstanceSpecification_Code is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code;
  has CodeableConcept $.status;
  has Reference @.source;
  has Str $.comment;
  has Extension @.extension;
  has DateTime $.statusDate;
  has Extension @.modifierExtension;
}

class SubstanceSpecification_Moiety is FHIR is export {
  has Str $.id;
  has CodeableConcept $.role;
  has Str $.name;
  has Extension @.extension;
  has ChoiceField $.amount where Quantity|Str;
  has Identifier $.identifier;
  has CodeableConcept $.stereochemistry;
  has CodeableConcept $.opticalActivity;
  has Str $.molecularFormula;
  has Extension @.modifierExtension;
}

class SubstanceSpecification_Property is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code;
  has CodeableConcept $.category;
  has Extension @.extension;
  has ChoiceField $.amount where Quantity|Str;
  has Str $.parameters;
  has Extension @.modifierExtension;
  has ChoiceField $.definingSubstance where CodeableConcept|Reference;
}

class SubstanceSpecification_Name_Official is FHIR is export {
  has Str $.id;
  has DateTime $.date;
  has CodeableConcept $.status;
  has Extension @.extension;
  has CodeableConcept $.authority;
  has Extension @.modifierExtension;
}
class SubstanceSpecification_Name is FHIR is export {
  has Str $.id;
  has Str $.name is required;
  has CodeableConcept $.type;
  has CodeableConcept $.status;
  has CodeableConcept @.domain;
  has Reference @.source;
  has SubstanceSpecification_Name @.synonym;
  has CodeableConcept @.language;
  has Extension @.extension;
  has Bool $.preferred;
  has SubstanceSpecification_Name @.translation;
  has CodeableConcept @.jurisdiction;
  has Extension @.modifierExtension;
  has SubstanceSpecification_Name_Official @.official;
}

class SubstanceSpecification_Relationship is FHIR is export {
  has Str $.id;
  has Reference @.source;
  has Extension @.extension;
  has ChoiceField $.amount where Quantity|Range|Ratio|Str;
  has Bool $.isDefining;
  has CodeableConcept $.amountType;
  has ChoiceField $.substance where CodeableConcept|Reference;
  has CodeableConcept $.relationship;
  has Extension @.modifierExtension;
  has Ratio $.amountRatioLowLimit;
}

class SubstanceSpecification_Structure_Representation is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Extension @.extension;
  has Attachment $.attachment;
  has Str $.representation;
  has Extension @.modifierExtension;
}

class SubstanceSpecification_Structure_Isotope_MolecularWeight is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has CodeableConcept $.method;
  has Quantity $.amount;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class SubstanceSpecification_Structure_Isotope is FHIR is export {
  has Str $.id;
  has CodeableConcept $.name;
  has Quantity $.halfLife;
  has Extension @.extension;
  has Identifier $.identifier;
  has CodeableConcept $.substitution;
  has Extension @.modifierExtension;
  has SubstanceSpecification_Structure_Isotope_MolecularWeight $.molecularWeight;
}
class SubstanceSpecification_Structure is FHIR is export {
  has Str $.id;
  has Reference @.source;
  has Extension @.extension;
  has CodeableConcept $.stereochemistry;
  has CodeableConcept $.opticalActivity;
  has SubstanceSpecification_Structure_Isotope_MolecularWeight $.molecularWeight;
  has Str $.molecularFormula;
  has Extension @.modifierExtension;
  has Str $.molecularFormulaByMoiety;
  has SubstanceSpecification_Structure_Representation @.representation;
  has SubstanceSpecification_Structure_Isotope @.isotope;
}

class SubstanceSpecification is DomainResource is export {
  method resourceType(--> 'SubstanceSpecification') {}
  has CodeableConcept $.type;
  has CodeableConcept $.status;
  has CodeableConcept $.domain;
  has Reference @.source;
  has Str $.comment;
  has Reference $.polymer;
  has Reference $.protein;
  has Identifier $.identifier;
  has Str $.description;
  has Reference $.nucleicAcid;
  has Reference $.sourceMaterial;
  has SubstanceSpecification_Structure_Isotope_MolecularWeight @.molecularWeight;
  has Reference $.referenceInformation;
  has SubstanceSpecification_Code @.code;
  has SubstanceSpecification_Moiety @.moiety;
  has SubstanceSpecification_Property @.property;
  has SubstanceSpecification_Name @.name;
  has SubstanceSpecification_Relationship @.relationship;
  has SubstanceSpecification_Structure $.structure;
}
class MolecularSequence_Variant is FHIR is export {
  has Str $.id;
  has Int $.end;
  has Int $.start;
  has Str $.cigar;
  has Extension @.extension;
  has Str $.observedAllele;
  has Reference $.variantPointer;
  has Str $.referenceAllele;
  has Extension @.modifierExtension;
}

class MolecularSequence_Repository is FHIR is export {
  has Str $.id;
  has UriStr $.url;
  has Code $.type is required;
  has Str $.name;
  has Extension @.extension;
  has Str $.datasetId;
  has Str $.readsetId;
  has Str $.variantsetId;
  has Extension @.modifierExtension;
}

class MolecularSequence_Quality_Roc is FHIR is export {
  has Str $.id;
  has Int @.score;
  has Int @.numTP;
  has Int @.numFP;
  has Int @.numFN;
  has Real @.fMeasure;
  has Extension @.extension;
  has Real @.precision;
  has Real @.sensitivity;
  has Extension @.modifierExtension;
}
class MolecularSequence_Quality is FHIR is export {
  has Str $.id;
  has Int $.end;
  has Code $.type is required;
  has Real $.gtFP;
  has Int $.start;
  has Quantity $.score;
  has CodeableConcept $.method;
  has Real $.recall;
  has Real $.fScore;
  has Real $.truthTP;
  has Real $.queryTP;
  has Real $.truthFN;
  has Real $.queryFP;
  has Extension @.extension;
  has Real $.precision;
  has CodeableConcept $.standardSequence;
  has Extension @.modifierExtension;
  has MolecularSequence_Quality_Roc $.roc;
}

class MolecularSequence_ReferenceSeq is FHIR is export {
  has Str $.id;
  has Code $.strand;
  has Extension @.extension;
  has Int $.windowEnd;
  has CodeableConcept $.chromosome;
  has Str $.genomeBuild;
  has Code $.orientation;
  has Int $.windowStart;
  has CodeableConcept $.referenceSeqId;
  has Extension @.modifierExtension;
  has Str $.referenceSeqString;
  has Reference $.referenceSeqPointer;
}

class MolecularSequence_StructureVariant_Outer is FHIR is export {
  has Str $.id;
  has Int $.end;
  has Int $.start;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MolecularSequence_StructureVariant_Inner is FHIR is export {
  has Str $.id;
  has Int $.end;
  has Int $.start;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class MolecularSequence_StructureVariant is FHIR is export {
  has Str $.id;
  has Bool $.exact;
  has Int $.length;
  has Extension @.extension;
  has CodeableConcept $.variantType;
  has Extension @.modifierExtension;
  has MolecularSequence_StructureVariant_Outer $.outer;
  has MolecularSequence_StructureVariant_Inner $.inner;
}

class MolecularSequence is DomainResource is export {
  method resourceType(--> 'MolecularSequence') {}
  has Code $.type;
  has Reference $.device;
  has Reference $.patient;
  has Reference @.pointer;
  has Reference $.specimen;
  has Quantity $.quantity;
  has Reference $.performer;
  has Identifier @.identifier;
  has Str $.observedSeq;
  has Int $.readCoverage;
  has Int $.coordinateSystem is required;
  has MolecularSequence_Variant @.variant;
  has MolecularSequence_Repository @.repository;
  has MolecularSequence_Quality @.quality;
  has MolecularSequence_ReferenceSeq $.referenceSeq;
  has MolecularSequence_StructureVariant @.structureVariant;
}
class CoverageEligibilityResponse_Error is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class CoverageEligibilityResponse_Insurance_Item_Benefit is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has ChoiceField $.used where Money|Str|UnsignedInt;
  has Extension @.extension;
  has ChoiceField $.allowed where Money|Str|UnsignedInt;
  has Extension @.modifierExtension;
}
class CoverageEligibilityResponse_Insurance_Item is FHIR is export {
  has Str $.id;
  has Str $.name;
  has CodeableConcept $.unit;
  has CodeableConcept $.term;
  has CodeableConcept $.network;
  has CodeableConcept $.category;
  has CodeableConcept @.modifier;
  has Reference $.provider;
  has Bool $.excluded;
  has Extension @.extension;
  has Str $.description;
  has CodeableConcept $.productOrService;
  has UriStr $.authorizationUrl;
  has Extension @.modifierExtension;
  has Bool $.authorizationRequired;
  has CodeableConcept @.authorizationSupporting;
  has CoverageEligibilityResponse_Insurance_Item_Benefit @.benefit;
}
class CoverageEligibilityResponse_Insurance is FHIR is export {
  has Str $.id;
  has Bool $.inforce;
  has Reference $.coverage is required;
  has Extension @.extension;
  has Period $.benefitPeriod;
  has Extension @.modifierExtension;
  has CoverageEligibilityResponse_Insurance_Item @.item;
}

class CoverageEligibilityResponse is DomainResource is export {
  method resourceType(--> 'CoverageEligibilityResponse') {}
  has CodeableConcept $.form;
  has Code $.status is required;
  has Code @.purpose is required;
  has Reference $.patient is required;
  has DateTime $.created is required;
  has Reference $.request is required;
  has Code $.outcome is required;
  has Reference $.insurer is required;
  has Reference $.requestor;
  has Identifier @.identifier;
  has Str $.preAuthRef;
  has ChoiceField $.serviced where Date|Period;
  has Str $.disposition;
  has CoverageEligibilityResponse_Error @.error;
  has CoverageEligibilityResponse_Insurance @.insurance;
}

class Library is DomainResource is export {
  method resourceType(--> 'Library') {}
  has UriStr $.url;
  has Str $.name;
  has CodeableConcept $.type is required;
  has DateTime $.date;
  has Str $.title;
  has Str $.usage;
  has CodeableConcept @.topic;
  has Code $.status is required;
  has ContactDetail @.author;
  has ContactDetail @.editor;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Attachment @.content;
  has Str $.subtitle;
  has ContactDetail @.reviewer;
  has ContactDetail @.endorser;
  has Str $.publisher;
  has Markdown $.copyright;
  has ParameterDefinition @.parameter;
  has Identifier @.identifier;
  has ChoiceField $.subject where CodeableConcept|Reference;
  has UsageContext @.useContext;
  has Markdown $.description;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has Date $.approvalDate;
  has Date $.lastReviewDate;
  has Period $.effectivePeriod;
  has RelatedArtifact @.relatedArtifact;
  has DataRequirement @.dataRequirement;
}
class Consent_Policy is FHIR is export {
  has Str $.id;
  has UriStr $.uri;
  has Extension @.extension;
  has UriStr $.authority;
  has Extension @.modifierExtension;
}

class Consent_Verification is FHIR is export {
  has Str $.id;
  has Bool $.verified is required;
  has Extension @.extension;
  has Reference $.verifiedWith;
  has DateTime $.verificationDate;
  has Extension @.modifierExtension;
}

class Consent_Provision_Data is FHIR is export {
  has Str $.id;
  has Code $.meaning is required;
  has Extension @.extension;
  has Reference $.reference is required;
  has Extension @.modifierExtension;
}

class Consent_Provision_Actor is FHIR is export {
  has Str $.id;
  has CodeableConcept $.role is required;
  has Extension @.extension;
  has Reference $.reference is required;
  has Extension @.modifierExtension;
}
class Consent_Provision is FHIR is export {
  has Str $.id;
  has Code $.type;
  has CodeableConcept @.code;
  has Coding @.class;
  has Period $.period;
  has CodeableConcept @.action;
  has Coding @.purpose;
  has Extension @.extension;
  has Consent_Provision @.provision;
  has Period $.dataPeriod;
  has Coding @.securityLabel;
  has Extension @.modifierExtension;
  has Consent_Provision_Data @.data;
  has Consent_Provision_Actor @.actor;
}

class Consent is DomainResource is export {
  method resourceType(--> 'Consent') {}
  has CodeableConcept $.scope is required;
  has Code $.status is required;
  has Reference $.patient;
  has CodeableConcept @.category is required;
  has DateTime $.dateTime;
  has Reference @.performer;
  has ChoiceField $.source where Attachment|Reference;
  has Identifier @.identifier;
  has CodeableConcept $.policyRule;
  has Reference @.organization;
  has Consent_Policy @.policy;
  has Consent_Verification @.verification;
  has Consent_Provision $.provision;
}

class Count is Quantity is export {
  
}
class InsurancePlan_Contact is FHIR is export {
  has Str $.id;
  has HumanName $.name;
  has CodeableConcept $.purpose;
  has ContactPoint @.telecom;
  has Address $.address;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class InsurancePlan_Coverage_Benefit_Limit is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code;
  has Quantity $.value;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class InsurancePlan_Coverage_Benefit is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Extension @.extension;
  has Str $.requirement;
  has Extension @.modifierExtension;
  has InsurancePlan_Coverage_Benefit_Limit @.limit;
}
class InsurancePlan_Coverage is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Reference @.network;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has InsurancePlan_Coverage_Benefit @.benefit is required;
}

class InsurancePlan_Plan_GeneralCost is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Money $.cost;
  has Str $.comment;
  has Extension @.extension;
  has PositiveInt $.groupSize;
  has Extension @.modifierExtension;
}

class InsurancePlan_Plan_SpecificCost_Benefit_Cost is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Quantity $.value;
  has Extension @.extension;
  has CodeableConcept @.qualifiers;
  has CodeableConcept $.applicability;
  has Extension @.modifierExtension;
}
class InsurancePlan_Plan_SpecificCost_Benefit is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has InsurancePlan_Plan_SpecificCost_Benefit_Cost @.cost;
}
class InsurancePlan_Plan_SpecificCost is FHIR is export {
  has Str $.id;
  has CodeableConcept $.category is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has InsurancePlan_Plan_SpecificCost_Benefit @.benefit;
}
class InsurancePlan_Plan is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Reference @.network;
  has Extension @.extension;
  has Identifier @.identifier;
  has Reference @.coverageArea;
  has Extension @.modifierExtension;
  has InsurancePlan_Plan_GeneralCost @.generalCost;
  has InsurancePlan_Plan_SpecificCost @.specificCost;
}

class InsurancePlan is DomainResource is export {
  method resourceType(--> 'InsurancePlan') {}
  has CodeableConcept @.type;
  has Str $.name;
  has Str @.alias;
  has Code $.status;
  has Period $.period;
  has Reference $.ownedBy;
  has Reference @.network;
  has Reference @.endpoint;
  has Identifier @.identifier;
  has Reference @.coverageArea;
  has Reference $.administeredBy;
  has InsurancePlan_Contact @.contact;
  has InsurancePlan_Coverage @.coverage;
  has InsurancePlan_Plan @.plan;
}

class Media is DomainResource is export {
  method resourceType(--> 'Media') {}
  has CodeableConcept $.type;
  has CodeableConcept $.view;
  has Annotation @.note;
  has PositiveInt $.width;
  has Reference @.partOf;
  has Code $.status is required;
  has DateTime $.issued;
  has Reference $.device;
  has PositiveInt $.height;
  has PositiveInt $.frames;
  has Reference @.basedOn;
  has Reference $.subject;
  has Attachment $.content is required;
  has CodeableConcept $.modality;
  has Reference $.operator;
  has CodeableConcept $.bodySite;
  has Real $.duration;
  has Reference $.encounter;
  has Identifier @.identifier;
  has ChoiceField $.created where DateTime|Period;
  has CodeableConcept @.reasonCode;
  has Str $.deviceName;
}
class CapabilityStatement_Software is FHIR is export {
  has Str $.id;
  has Str $.name is required;
  has Str $.version;
  has Extension @.extension;
  has DateTime $.releaseDate;
  has Extension @.modifierExtension;
}

class CapabilityStatement_Document is FHIR is export {
  has Str $.id;
  has Code $.mode is required;
  has Canonical $.profile is required;
  has Extension @.extension;
  has Markdown $.documentation;
  has Extension @.modifierExtension;
}

class CapabilityStatement_Implementation is FHIR is export {
  has Str $.id;
  has UrlStr $.url;
  has Extension @.extension;
  has Reference $.custodian;
  has Str $.description is required;
  has Extension @.modifierExtension;
}

class CapabilityStatement_Rest_Security is FHIR is export {
  has Str $.id;
  has Bool $.cors;
  has CodeableConcept @.service;
  has Extension @.extension;
  has Markdown $.description;
  has Extension @.modifierExtension;
}

class CapabilityStatement_Rest_Interaction is FHIR is export {
  has Str $.id;
  has Code $.code is required;
  has Extension @.extension;
  has Markdown $.documentation;
  has Extension @.modifierExtension;
}

class CapabilityStatement_Rest_Resource_Operation is FHIR is export {
  has Str $.id;
  has Str $.name is required;
  has Extension @.extension;
  has Canonical $.definition is required;
  has Markdown $.documentation;
  has Extension @.modifierExtension;
}

class CapabilityStatement_Rest_Resource_Interaction is FHIR is export {
  has Str $.id;
  has Code $.code is required;
  has Extension @.extension;
  has Markdown $.documentation;
  has Extension @.modifierExtension;
}

class CapabilityStatement_Rest_Resource_SearchParam is FHIR is export {
  has Str $.id;
  has Str $.name is required;
  has Code $.type is required;
  has Extension @.extension;
  has Canonical $.definition;
  has Markdown $.documentation;
  has Extension @.modifierExtension;
}
class CapabilityStatement_Rest_Resource is FHIR is export {
  has Str $.id;
  has Code $.type is required;
  has Canonical $.profile;
  has Extension @.extension;
  has Code $.versioning;
  has Bool $.readHistory;
  has Bool $.updateCreate;
  has Markdown $.documentation;
  has Str @.searchInclude;
  has Code $.conditionalRead;
  has Code @.referencePolicy;
  has Canonical @.supportedProfile;
  has Str @.searchRevInclude;
  has Extension @.modifierExtension;
  has Bool $.conditionalCreate;
  has Bool $.conditionalUpdate;
  has Code $.conditionalDelete;
  has CapabilityStatement_Rest_Resource_Operation @.operation;
  has CapabilityStatement_Rest_Resource_Interaction @.interaction;
  has CapabilityStatement_Rest_Resource_SearchParam @.searchParam;
}
class CapabilityStatement_Rest is FHIR is export {
  has Str $.id;
  has Code $.mode is required;
  has Extension @.extension;
  has CapabilityStatement_Rest_Resource_Operation @.operation;
  has CapabilityStatement_Rest_Resource_SearchParam @.searchParam;
  has Canonical @.compartment;
  has Markdown $.documentation;
  has Extension @.modifierExtension;
  has CapabilityStatement_Rest_Security $.security;
  has CapabilityStatement_Rest_Interaction @.interaction;
  has CapabilityStatement_Rest_Resource @.resource;
}

class CapabilityStatement_Messaging_Endpoint is FHIR is export {
  has Str $.id;
  has UrlStr $.address is required;
  has Coding $.protocol is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class CapabilityStatement_Messaging_SupportedMessage is FHIR is export {
  has Str $.id;
  has Code $.mode is required;
  has Extension @.extension;
  has Canonical $.definition is required;
  has Extension @.modifierExtension;
}
class CapabilityStatement_Messaging is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has UnsignedInt $.reliableCache;
  has Markdown $.documentation;
  has Extension @.modifierExtension;
  has CapabilityStatement_Messaging_Endpoint @.endpoint;
  has CapabilityStatement_Messaging_SupportedMessage @.supportedMessage;
}

class CapabilityStatement is DomainResource is export {
  method resourceType(--> 'CapabilityStatement') {}
  has UriStr $.url;
  has Str $.name;
  has DateTime $.date is required;
  has Code $.kind is required;
  has Str $.title;
  has Code $.status is required;
  has Code @.format is required;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Canonical @.imports;
  has Str $.publisher;
  has Markdown $.copyright;
  has UsageContext @.useContext;
  has Markdown $.description;
  has Code $.fhirVersion is required;
  has Code @.patchFormat;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has Canonical @.instantiates;
  has Canonical @.implementationGuide;
  has CapabilityStatement_Software $.software;
  has CapabilityStatement_Document @.document;
  has CapabilityStatement_Implementation $.implementation;
  has CapabilityStatement_Rest @.rest;
  has CapabilityStatement_Messaging @.messaging;
}
class GraphDefinition_Link_Target_Compartment is FHIR is export {
  has Str $.id;
  has Code $.use is required;
  has Code $.code is required;
  has Code $.rule is required;
  has Extension @.extension;
  has Str $.expression;
  has Str $.description;
  has Extension @.modifierExtension;
}
class GraphDefinition_Link_Target is FHIR is export {
  has Str $.id;
  has Code $.type is required;
  has GraphDefinition_Link @.link;
  has Str $.params;
  has Canonical $.profile;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has GraphDefinition_Link_Target_Compartment @.compartment;
}
class GraphDefinition_Link is FHIR is export {
  has Str $.id;
  has Int $.min;
  has Str $.max;
  has Str $.path;
  has Extension @.extension;
  has Str $.sliceName;
  has Str $.description;
  has Extension @.modifierExtension;
  has GraphDefinition_Link_Target @.target;
}

class GraphDefinition is DomainResource is export {
  method resourceType(--> 'GraphDefinition') {}
  has UriStr $.url;
  has Str $.name is required;
  has DateTime $.date;
  has Code $.start is required;
  has Code $.status is required;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Canonical $.profile;
  has Str $.publisher;
  has UsageContext @.useContext;
  has Markdown $.description;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has GraphDefinition_Link @.link;
}
class CoverageEligibilityRequest_Insurance is FHIR is export {
  has Str $.id;
  has Bool $.focal;
  has Reference $.coverage is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has Str $.businessArrangement;
}

class CoverageEligibilityRequest_SupportingInfo is FHIR is export {
  has Str $.id;
  has PositiveInt $.sequence is required;
  has Extension @.extension;
  has Reference $.information is required;
  has Bool $.appliesToAll;
  has Extension @.modifierExtension;
}

class CoverageEligibilityRequest_Item_Diagnosis is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has ChoiceField $.diagnosis where CodeableConcept|Reference;
  has Extension @.modifierExtension;
}
class CoverageEligibilityRequest_Item is FHIR is export {
  has Str $.id;
  has Reference @.detail;
  has CodeableConcept $.category;
  has CodeableConcept @.modifier;
  has Reference $.provider;
  has Quantity $.quantity;
  has Reference $.facility;
  has Extension @.extension;
  has Money $.unitPrice;
  has CodeableConcept $.productOrService;
  has Extension @.modifierExtension;
  has PositiveInt @.supportingInfoSequence;
  has CoverageEligibilityRequest_Item_Diagnosis @.diagnosis;
}

class CoverageEligibilityRequest is DomainResource is export {
  method resourceType(--> 'CoverageEligibilityRequest') {}
  has Code $.status is required;
  has Code @.purpose is required;
  has Reference $.patient is required;
  has DateTime $.created is required;
  has Reference $.enterer;
  has Reference $.insurer is required;
  has CodeableConcept $.priority;
  has Reference $.provider;
  has Reference $.facility;
  has Identifier @.identifier;
  has ChoiceField $.serviced where Date|Period;
  has CoverageEligibilityRequest_Insurance @.insurance;
  has CoverageEligibilityRequest_SupportingInfo @.supportingInfo;
  has CoverageEligibilityRequest_Item @.item;
}
class PractitionerRole_NotAvailable is FHIR is export {
  has Str $.id;
  has Period $.during;
  has Extension @.extension;
  has Str $.description is required;
  has Extension @.modifierExtension;
}

class PractitionerRole_AvailableTime is FHIR is export {
  has Str $.id;
  has Bool $.allDay;
  has Extension @.extension;
  has Code @.daysOfWeek;
  has Instant $.availableEndTime;
  has Extension @.modifierExtension;
  has Instant $.availableStartTime;
}

class PractitionerRole is DomainResource is export {
  method resourceType(--> 'PractitionerRole') {}
  has CodeableConcept @.code;
  has Bool $.active;
  has Period $.period;
  has ContactPoint @.telecom;
  has Reference @.location;
  has Reference @.endpoint;
  has CodeableConcept @.specialty;
  has Identifier @.identifier;
  has Reference $.practitioner;
  has Reference $.organization;
  has Reference @.healthcareService;
  has Str $.availabilityExceptions;
  has PractitionerRole_NotAvailable @.notAvailable;
  has PractitionerRole_AvailableTime @.availableTime;
}
class ExplanationOfBenefit_Payee is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Reference $.party;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class ExplanationOfBenefit_Total is FHIR is export {
  has Str $.id;
  has Money $.amount is required;
  has CodeableConcept $.category is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class ExplanationOfBenefit_Related is FHIR is export {
  has Str $.id;
  has Reference $.claim;
  has Extension @.extension;
  has Identifier $.reference;
  has CodeableConcept $.relationship;
  has Extension @.modifierExtension;
}

class ExplanationOfBenefit_Payment is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Date $.date;
  has Money $.amount;
  has Extension @.extension;
  has Money $.adjustment;
  has Identifier $.identifier;
  has CodeableConcept $.adjustmentReason;
  has Extension @.modifierExtension;
}

class ExplanationOfBenefit_CareTeam is FHIR is export {
  has Str $.id;
  has CodeableConcept $.role;
  has PositiveInt $.sequence is required;
  has Reference $.provider is required;
  has Extension @.extension;
  has Bool $.responsible;
  has CodeableConcept $.qualification;
  has Extension @.modifierExtension;
}

class ExplanationOfBenefit_Accident is FHIR is export {
  has Str $.id;
  has Date $.date;
  has CodeableConcept $.type;
  has Extension @.extension;
  has ChoiceField $.location where Address|Reference;
  has Extension @.modifierExtension;
}

class ExplanationOfBenefit_Diagnosis is FHIR is export {
  has Str $.id;
  has CodeableConcept @.type;
  has PositiveInt $.sequence is required;
  has Extension @.extension;
  has CodeableConcept $.onAdmission;
  has CodeableConcept $.packageCode;
  has ChoiceField $.diagnosis is required where CodeableConcept|Reference;
  has Extension @.modifierExtension;
}

class ExplanationOfBenefit_Procedure is FHIR is export {
  has Str $.id;
  has Reference @.udi;
  has CodeableConcept @.type;
  has DateTime $.date;
  has PositiveInt $.sequence is required;
  has Extension @.extension;
  has ChoiceField $.procedure is required where CodeableConcept|Reference;
  has Extension @.modifierExtension;
}

class ExplanationOfBenefit_Insurance is FHIR is export {
  has Str $.id;
  has Bool $.focal is required;
  has Reference $.coverage is required;
  has Extension @.extension;
  has Str @.preAuthRef;
  has Extension @.modifierExtension;
}

class ExplanationOfBenefit_ProcessNote is FHIR is export {
  has Str $.id;
  has Code $.type;
  has Str $.text;
  has PositiveInt $.number;
  has CodeableConcept $.language;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class ExplanationOfBenefit_SupportingInfo is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code;
  has Coding $.reason;
  has PositiveInt $.sequence is required;
  has CodeableConcept $.category is required;
  has ChoiceField $.value where Attachment|Bool|Quantity|Reference|Str;
  has Extension @.extension;
  has ChoiceField $.timing where Date|Period;
  has Extension @.modifierExtension;
}

class ExplanationOfBenefit_Item_Adjudication is FHIR is export {
  has Str $.id;
  has Real $.value;
  has CodeableConcept $.reason;
  has Money $.amount;
  has CodeableConcept $.category is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class ExplanationOfBenefit_Item_Detail_SubDetail is FHIR is export {
  has Str $.id;
  has Money $.net;
  has Reference @.udi;
  has Real $.factor;
  has CodeableConcept $.revenue;
  has PositiveInt $.sequence is required;
  has CodeableConcept $.category;
  has CodeableConcept @.modifier;
  has Quantity $.quantity;
  has Extension @.extension;
  has Money $.unitPrice;
  has PositiveInt @.noteNumber;
  has CodeableConcept @.programCode;
  has ExplanationOfBenefit_Item_Adjudication @.adjudication;
  has CodeableConcept $.productOrService is required;
  has Extension @.modifierExtension;
}
class ExplanationOfBenefit_Item_Detail is FHIR is export {
  has Str $.id;
  has Money $.net;
  has Reference @.udi;
  has Real $.factor;
  has CodeableConcept $.revenue;
  has PositiveInt $.sequence is required;
  has CodeableConcept $.category;
  has CodeableConcept @.modifier;
  has Quantity $.quantity;
  has Extension @.extension;
  has Money $.unitPrice;
  has PositiveInt @.noteNumber;
  has CodeableConcept @.programCode;
  has ExplanationOfBenefit_Item_Adjudication @.adjudication;
  has CodeableConcept $.productOrService is required;
  has Extension @.modifierExtension;
  has ExplanationOfBenefit_Item_Detail_SubDetail @.subDetail;
}
class ExplanationOfBenefit_Item is FHIR is export {
  has Str $.id;
  has Money $.net;
  has Reference @.udi;
  has Real $.factor;
  has CodeableConcept $.revenue;
  has CodeableConcept @.subSite;
  has PositiveInt $.sequence is required;
  has CodeableConcept $.category;
  has CodeableConcept @.modifier;
  has Quantity $.quantity;
  has CodeableConcept $.bodySite;
  has Extension @.extension;
  has Money $.unitPrice;
  has Reference @.encounter;
  has PositiveInt @.noteNumber;
  has CodeableConcept @.programCode;
  has ChoiceField $.serviced where Date|Period;
  has ChoiceField $.location where Address|CodeableConcept|Reference;
  has PositiveInt @.careTeamSequence;
  has CodeableConcept $.productOrService is required;
  has Extension @.modifierExtension;
  has PositiveInt @.diagnosisSequence;
  has PositiveInt @.procedureSequence;
  has PositiveInt @.informationSequence;
  has ExplanationOfBenefit_Item_Adjudication @.adjudication;
  has ExplanationOfBenefit_Item_Detail @.detail;
}

class ExplanationOfBenefit_AddItem_Detail_SubDetail is FHIR is export {
  has Str $.id;
  has Money $.net;
  has Real $.factor;
  has CodeableConcept @.modifier;
  has Quantity $.quantity;
  has Extension @.extension;
  has Money $.unitPrice;
  has PositiveInt @.noteNumber;
  has ExplanationOfBenefit_Item_Adjudication @.adjudication;
  has CodeableConcept $.productOrService is required;
  has Extension @.modifierExtension;
}
class ExplanationOfBenefit_AddItem_Detail is FHIR is export {
  has Str $.id;
  has Money $.net;
  has Real $.factor;
  has CodeableConcept @.modifier;
  has Quantity $.quantity;
  has Extension @.extension;
  has Money $.unitPrice;
  has PositiveInt @.noteNumber;
  has ExplanationOfBenefit_Item_Adjudication @.adjudication;
  has CodeableConcept $.productOrService is required;
  has Extension @.modifierExtension;
  has ExplanationOfBenefit_AddItem_Detail_SubDetail @.subDetail;
}
class ExplanationOfBenefit_AddItem is FHIR is export {
  has Str $.id;
  has Money $.net;
  has Real $.factor;
  has CodeableConcept @.subSite;
  has Reference @.provider;
  has CodeableConcept @.modifier;
  has Quantity $.quantity;
  has CodeableConcept $.bodySite;
  has Extension @.extension;
  has Money $.unitPrice;
  has PositiveInt @.noteNumber;
  has CodeableConcept @.programCode;
  has ChoiceField $.serviced where Date|Period;
  has ChoiceField $.location where Address|CodeableConcept|Reference;
  has PositiveInt @.itemSequence;
  has ExplanationOfBenefit_Item_Adjudication @.adjudication;
  has PositiveInt @.detailSequence;
  has CodeableConcept $.productOrService is required;
  has Extension @.modifierExtension;
  has PositiveInt @.subDetailSequence;
  has ExplanationOfBenefit_AddItem_Detail @.detail;
}

class ExplanationOfBenefit_BenefitBalance_Financial is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has ChoiceField $.used where Money|UnsignedInt;
  has Extension @.extension;
  has ChoiceField $.allowed where Money|Str|UnsignedInt;
  has Extension @.modifierExtension;
}
class ExplanationOfBenefit_BenefitBalance is FHIR is export {
  has Str $.id;
  has Str $.name;
  has CodeableConcept $.unit;
  has CodeableConcept $.term;
  has CodeableConcept $.network;
  has CodeableConcept $.category is required;
  has Bool $.excluded;
  has Extension @.extension;
  has Str $.description;
  has Extension @.modifierExtension;
  has ExplanationOfBenefit_BenefitBalance_Financial @.financial;
}

class ExplanationOfBenefit is DomainResource is export {
  method resourceType(--> 'ExplanationOfBenefit') {}
  has Code $.use is required;
  has CodeableConcept $.type is required;
  has Attachment $.form;
  has Reference $.claim;
  has Code $.status is required;
  has CodeableConcept $.subType;
  has Reference $.patient is required;
  has DateTime $.created is required;
  has Reference $.enterer;
  has Reference $.insurer is required;
  has Code $.outcome is required;
  has Reference $.provider is required;
  has CodeableConcept $.priority;
  has Reference $.referral;
  has Reference $.facility;
  has CodeableConcept $.formCode;
  has Identifier @.identifier;
  has Str @.preAuthRef;
  has PositiveInt $.precedence;
  has Str $.disposition;
  has CodeableConcept $.fundsReserve;
  has Reference $.prescription;
  has ExplanationOfBenefit_Item_Adjudication @.adjudication;
  has Reference $.claimResponse;
  has Period $.benefitPeriod;
  has Period $.billablePeriod;
  has Period @.preAuthRefPeriod;
  has Reference $.originalPrescription;
  has CodeableConcept $.fundsReserveRequested;
  has ExplanationOfBenefit_Payee $.payee;
  has ExplanationOfBenefit_Total @.total;
  has ExplanationOfBenefit_Related @.related;
  has ExplanationOfBenefit_Payment $.payment;
  has ExplanationOfBenefit_CareTeam @.careTeam;
  has ExplanationOfBenefit_Accident $.accident;
  has ExplanationOfBenefit_Diagnosis @.diagnosis;
  has ExplanationOfBenefit_Procedure @.procedure;
  has ExplanationOfBenefit_Insurance @.insurance is required;
  has ExplanationOfBenefit_ProcessNote @.processNote;
  has ExplanationOfBenefit_SupportingInfo @.supportingInfo;
  has ExplanationOfBenefit_Item @.item;
  has ExplanationOfBenefit_AddItem @.addItem;
  has ExplanationOfBenefit_BenefitBalance @.benefitBalance;
}
class VisionPrescription_LensSpecification_Prism is FHIR is export {
  has Str $.id;
  has Code $.base is required;
  has Real $.amount is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class VisionPrescription_LensSpecification is FHIR is export {
  has Str $.id;
  has Code $.eye is required;
  has Real $.add;
  has Int $.axis;
  has Annotation @.note;
  has Real $.power;
  has Str $.color;
  has Str $.brand;
  has Real $.sphere;
  has CodeableConcept $.product is required;
  has Real $.cylinder;
  has Real $.diameter;
  has Quantity $.duration;
  has Extension @.extension;
  has Real $.backCurve;
  has Extension @.modifierExtension;
  has VisionPrescription_LensSpecification_Prism @.prism;
}

class VisionPrescription is DomainResource is export {
  method resourceType(--> 'VisionPrescription') {}
  has Code $.status is required;
  has DateTime $.created is required;
  has Reference $.patient is required;
  has Reference $.encounter;
  has Identifier @.identifier;
  has Reference $.prescriber is required;
  has DateTime $.dateWritten is required;
  has VisionPrescription_LensSpecification @.lensSpecification is required;
}

class EnrollmentRequest is DomainResource is export {
  method resourceType(--> 'EnrollmentRequest') {}
  has Code $.status;
  has DateTime $.created;
  has Reference $.insurer;
  has Reference $.provider;
  has Reference $.coverage;
  has Reference $.candidate;
  has Identifier @.identifier;
}
class Claim_Payee is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Reference $.party;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Claim_Related is FHIR is export {
  has Str $.id;
  has Reference $.claim;
  has Extension @.extension;
  has Identifier $.reference;
  has CodeableConcept $.relationship;
  has Extension @.modifierExtension;
}

class Claim_CareTeam is FHIR is export {
  has Str $.id;
  has CodeableConcept $.role;
  has PositiveInt $.sequence is required;
  has Reference $.provider is required;
  has Extension @.extension;
  has Bool $.responsible;
  has CodeableConcept $.qualification;
  has Extension @.modifierExtension;
}

class Claim_Accident is FHIR is export {
  has Str $.id;
  has Date $.date is required;
  has CodeableConcept $.type;
  has Extension @.extension;
  has ChoiceField $.location where Address|Reference;
  has Extension @.modifierExtension;
}

class Claim_Diagnosis is FHIR is export {
  has Str $.id;
  has CodeableConcept @.type;
  has PositiveInt $.sequence is required;
  has Extension @.extension;
  has CodeableConcept $.onAdmission;
  has CodeableConcept $.packageCode;
  has ChoiceField $.diagnosis is required where CodeableConcept|Reference;
  has Extension @.modifierExtension;
}

class Claim_Procedure is FHIR is export {
  has Str $.id;
  has Reference @.udi;
  has CodeableConcept @.type;
  has DateTime $.date;
  has PositiveInt $.sequence is required;
  has Extension @.extension;
  has ChoiceField $.procedure is required where CodeableConcept|Reference;
  has Extension @.modifierExtension;
}

class Claim_Insurance is FHIR is export {
  has Str $.id;
  has Bool $.focal is required;
  has PositiveInt $.sequence is required;
  has Reference $.coverage is required;
  has Extension @.extension;
  has Identifier $.identifier;
  has Str @.preAuthRef;
  has Reference $.claimResponse;
  has Extension @.modifierExtension;
  has Str $.businessArrangement;
}

class Claim_SupportingInfo is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code;
  has CodeableConcept $.reason;
  has PositiveInt $.sequence is required;
  has CodeableConcept $.category is required;
  has ChoiceField $.value where Attachment|Bool|Quantity|Reference|Str;
  has Extension @.extension;
  has ChoiceField $.timing where Date|Period;
  has Extension @.modifierExtension;
}

class Claim_Item_Detail_SubDetail is FHIR is export {
  has Str $.id;
  has Money $.net;
  has Reference @.udi;
  has Real $.factor;
  has CodeableConcept $.revenue;
  has PositiveInt $.sequence is required;
  has CodeableConcept $.category;
  has CodeableConcept @.modifier;
  has Quantity $.quantity;
  has Extension @.extension;
  has Money $.unitPrice;
  has CodeableConcept @.programCode;
  has CodeableConcept $.productOrService is required;
  has Extension @.modifierExtension;
}
class Claim_Item_Detail is FHIR is export {
  has Str $.id;
  has Money $.net;
  has Reference @.udi;
  has Real $.factor;
  has CodeableConcept $.revenue;
  has PositiveInt $.sequence is required;
  has CodeableConcept $.category;
  has CodeableConcept @.modifier;
  has Quantity $.quantity;
  has Extension @.extension;
  has Money $.unitPrice;
  has CodeableConcept @.programCode;
  has CodeableConcept $.productOrService is required;
  has Extension @.modifierExtension;
  has Claim_Item_Detail_SubDetail @.subDetail;
}
class Claim_Item is FHIR is export {
  has Str $.id;
  has Money $.net;
  has Reference @.udi;
  has Real $.factor;
  has CodeableConcept $.revenue;
  has CodeableConcept @.subSite;
  has PositiveInt $.sequence is required;
  has CodeableConcept $.category;
  has CodeableConcept @.modifier;
  has Quantity $.quantity;
  has CodeableConcept $.bodySite;
  has Extension @.extension;
  has Money $.unitPrice;
  has Reference @.encounter;
  has CodeableConcept @.programCode;
  has ChoiceField $.serviced where Date|Period;
  has ChoiceField $.location where Address|CodeableConcept|Reference;
  has PositiveInt @.careTeamSequence;
  has CodeableConcept $.productOrService is required;
  has Extension @.modifierExtension;
  has PositiveInt @.diagnosisSequence;
  has PositiveInt @.procedureSequence;
  has PositiveInt @.informationSequence;
  has Claim_Item_Detail @.detail;
}

class Claim is DomainResource is export {
  method resourceType(--> 'Claim') {}
  has Code $.use is required;
  has CodeableConcept $.type is required;
  has Money $.total;
  has Code $.status is required;
  has CodeableConcept $.subType;
  has Reference $.patient is required;
  has DateTime $.created is required;
  has Reference $.enterer;
  has Reference $.insurer;
  has Reference $.provider is required;
  has CodeableConcept $.priority is required;
  has Reference $.referral;
  has Reference $.facility;
  has Identifier @.identifier;
  has CodeableConcept $.fundsReserve;
  has Reference $.prescription;
  has Period $.billablePeriod;
  has Reference $.originalPrescription;
  has Claim_Payee $.payee;
  has Claim_Related @.related;
  has Claim_CareTeam @.careTeam;
  has Claim_Accident $.accident;
  has Claim_Diagnosis @.diagnosis;
  has Claim_Procedure @.procedure;
  has Claim_Insurance @.insurance is required;
  has Claim_SupportingInfo @.supportingInfo;
  has Claim_Item @.item;
}
class ImmunizationRecommendation_Recommendation_DateCriterion is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code is required;
  has DateTime $.value is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class ImmunizationRecommendation_Recommendation is FHIR is export {
  has Str $.id;
  has Str $.series;
  has Extension @.extension;
  has CodeableConcept @.vaccineCode;
  has Str $.description;
  has CodeableConcept $.targetDisease;
  has ChoiceField $.doseNumber where PositiveInt|Str;
  has CodeableConcept $.forecastStatus is required;
  has CodeableConcept @.forecastReason;
  has ChoiceField $.seriesDoses where PositiveInt|Str;
  has Extension @.modifierExtension;
  has Reference @.supportingImmunization;
  has CodeableConcept @.contraindicatedVaccineCode;
  has Reference @.supportingPatientInformation;
  has ImmunizationRecommendation_Recommendation_DateCriterion @.dateCriterion;
}

class ImmunizationRecommendation is DomainResource is export {
  method resourceType(--> 'ImmunizationRecommendation') {}
  has DateTime $.date is required;
  has Reference $.patient is required;
  has Reference $.authority;
  has Identifier @.identifier;
  has ImmunizationRecommendation_Recommendation @.recommendation is required;
}

class SimpleQuantity is Quantity is export {
  
}

class BodyStructure is DomainResource is export {
  method resourceType(--> 'BodyStructure') {}
  has Attachment @.image;
  has Bool $.active;
  has Reference $.patient is required;
  has CodeableConcept $.location;
  has Identifier @.identifier;
  has CodeableConcept $.morphology;
  has Str $.description;
  has CodeableConcept @.locationQualifier;
}
class ImagingStudy_Series_Instance is FHIR is export {
  has Str $.id;
  has Id $.uid is required;
  has Str $.title;
  has UnsignedInt $.number;
  has Coding $.sopClass is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class ImagingStudy_Series_Performer is FHIR is export {
  has Str $.id;
  has Reference $.actor is required;
  has CodeableConcept $.function;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class ImagingStudy_Series is FHIR is export {
  has Str $.id;
  has Id $.uid is required;
  has UnsignedInt $.number;
  has DateTime $.started;
  has Coding $.modality is required;
  has Reference @.endpoint;
  has Coding $.bodySite;
  has Reference @.specimen;
  has Extension @.extension;
  has Coding $.laterality;
  has Str $.description;
  has Extension @.modifierExtension;
  has UnsignedInt $.numberOfInstances;
  has ImagingStudy_Series_Instance @.instance;
  has ImagingStudy_Series_Performer @.performer;
}

class ImagingStudy is DomainResource is export {
  method resourceType(--> 'ImagingStudy') {}
  has Annotation @.note;
  has Code $.status is required;
  has Reference $.subject is required;
  has DateTime $.started;
  has Reference @.basedOn;
  has Coding @.modality;
  has Reference $.referrer;
  has Reference @.endpoint;
  has Reference $.location;
  has Reference $.encounter;
  has Identifier @.identifier;
  has CodeableConcept @.reasonCode;
  has Reference @.interpreter;
  has Str $.description;
  has CodeableConcept @.procedureCode;
  has UnsignedInt $.numberOfSeries;
  has Reference @.reasonReference;
  has UnsignedInt $.numberOfInstances;
  has Reference $.procedureReference;
  has ImagingStudy_Series @.series;
}

class MedicinalProductUndesirableEffect is DomainResource is export {
  method resourceType(--> 'MedicinalProductUndesirableEffect') {}
  has Reference @.subject;
  has Any @.population;
  has CodeableConcept $.classification;
  has CodeableConcept $.frequencyOfOccurrence;
  has CodeableConcept $.symptomConditionEffect;
}
class HealthcareService_Eligibility is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code;
  has Markdown $.comment;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class HealthcareService_NotAvailable is FHIR is export {
  has Str $.id;
  has Period $.during;
  has Extension @.extension;
  has Str $.description is required;
  has Extension @.modifierExtension;
}

class HealthcareService_AvailableTime is FHIR is export {
  has Str $.id;
  has Bool $.allDay;
  has Extension @.extension;
  has Code @.daysOfWeek;
  has Instant $.availableEndTime;
  has Extension @.modifierExtension;
  has Instant $.availableStartTime;
}

class HealthcareService is DomainResource is export {
  method resourceType(--> 'HealthcareService') {}
  has CodeableConcept @.type;
  has Str $.name;
  has Attachment $.photo;
  has Bool $.active;
  has Str $.comment;
  has ContactPoint @.telecom;
  has CodeableConcept @.program;
  has CodeableConcept @.category;
  has Reference @.location;
  has Reference @.endpoint;
  has CodeableConcept @.specialty;
  has Identifier @.identifier;
  has Reference $.providedBy;
  has Markdown $.extraDetails;
  has Reference @.coverageArea;
  has CodeableConcept @.communication;
  has CodeableConcept @.characteristic;
  has CodeableConcept @.referralMethod;
  has Bool $.appointmentRequired;
  has CodeableConcept @.serviceProvisionCode;
  has Str $.availabilityExceptions;
  has HealthcareService_Eligibility @.eligibility;
  has HealthcareService_NotAvailable @.notAvailable;
  has HealthcareService_AvailableTime @.availableTime;
}
class List_Entry is FHIR is export {
  has Str $.id;
  has CodeableConcept $.flag;
  has DateTime $.date;
  has Reference $.item is required;
  has Bool $.deleted;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class List is DomainResource is export {
  method resourceType(--> 'List') {}
  has Code $.mode is required;
  has CodeableConcept $.code;
  has DateTime $.date;
  has Annotation @.note;
  has Str $.title;
  has Code $.status is required;
  has Reference $.source;
  has Reference $.subject;
  has Reference $.encounter;
  has CodeableConcept $.orderedBy;
  has Identifier @.identifier;
  has CodeableConcept $.emptyReason;
  has List_Entry @.entry;
}

class Distance is Quantity is export {
  
}
class Organization_Contact is FHIR is export {
  has Str $.id;
  has HumanName $.name;
  has CodeableConcept $.purpose;
  has ContactPoint @.telecom;
  has Address $.address;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Organization is DomainResource is export {
  method resourceType(--> 'Organization') {}
  has CodeableConcept @.type;
  has Str $.name;
  has Str @.alias;
  has Bool $.active;
  has Reference $.partOf;
  has ContactPoint @.telecom;
  has Address @.address;
  has Reference @.endpoint;
  has Identifier @.identifier;
  has Organization_Contact @.contact;
}
class EffectEvidenceSynthesis_SampleSize is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Str $.description;
  has Int $.numberOfStudies;
  has Extension @.modifierExtension;
  has Int $.numberOfParticipants;
}

class EffectEvidenceSynthesis_ResultsByExposure is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Str $.description;
  has CodeableConcept $.variantState;
  has Code $.exposureState;
  has Extension @.modifierExtension;
  has Reference $.riskEvidenceSynthesis is required;
}

class EffectEvidenceSynthesis_Certainty_CertaintySubcomponent is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Annotation @.note;
  has CodeableConcept @.rating;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class EffectEvidenceSynthesis_Certainty is FHIR is export {
  has Str $.id;
  has Annotation @.note;
  has CodeableConcept @.rating;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has EffectEvidenceSynthesis_Certainty_CertaintySubcomponent @.certaintySubcomponent;
}

class EffectEvidenceSynthesis_EffectEstimate_PrecisionEstimate is FHIR is export {
  has Str $.id;
  has Real $.to;
  has CodeableConcept $.type;
  has Real $.from;
  has Real $.level;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class EffectEvidenceSynthesis_EffectEstimate is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Real $.value;
  has Extension @.extension;
  has Str $.description;
  has CodeableConcept $.variantState;
  has CodeableConcept $.unitOfMeasure;
  has Extension @.modifierExtension;
  has EffectEvidenceSynthesis_EffectEstimate_PrecisionEstimate @.precisionEstimate;
}

class EffectEvidenceSynthesis is DomainResource is export {
  method resourceType(--> 'EffectEvidenceSynthesis') {}
  has UriStr $.url;
  has Str $.name;
  has DateTime $.date;
  has Annotation @.note;
  has Str $.title;
  has CodeableConcept @.topic;
  has Code $.status is required;
  has ContactDetail @.author;
  has ContactDetail @.editor;
  has Str $.version;
  has ContactDetail @.contact;
  has Reference $.outcome is required;
  has ContactDetail @.reviewer;
  has ContactDetail @.endorser;
  has Reference $.exposure is required;
  has Str $.publisher;
  has Markdown $.copyright;
  has CodeableConcept $.studyType;
  has Identifier @.identifier;
  has UsageContext @.useContext;
  has Reference $.population is required;
  has Markdown $.description;
  has CodeableConcept @.jurisdiction;
  has Date $.approvalDate;
  has CodeableConcept $.synthesisType;
  has Date $.lastReviewDate;
  has Period $.effectivePeriod;
  has RelatedArtifact @.relatedArtifact;
  has Reference $.exposureAlternative is required;
  has EffectEvidenceSynthesis_SampleSize $.sampleSize;
  has EffectEvidenceSynthesis_ResultsByExposure @.resultsByExposure;
  has EffectEvidenceSynthesis_Certainty @.certainty;
  has EffectEvidenceSynthesis_EffectEstimate @.effectEstimate;
}

class OrganizationAffiliation is DomainResource is export {
  method resourceType(--> 'OrganizationAffiliation') {}
  has CodeableConcept @.code;
  has Bool $.active;
  has Period $.period;
  has Reference @.network;
  has ContactPoint @.telecom;
  has Reference @.location;
  has Reference @.endpoint;
  has CodeableConcept @.specialty;
  has Identifier @.identifier;
  has Reference $.organization;
  has Reference @.healthcareService;
  has Reference $.participatingOrganization;
}
class SubstancePolymer_MonomerSet_StartingMaterial is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Any $.amount;
  has CodeableConcept $.material;
  has Extension @.extension;
  has Bool $.isDefining;
  has Extension @.modifierExtension;
}
class SubstancePolymer_MonomerSet is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has CodeableConcept $.ratioType;
  has Extension @.modifierExtension;
  has SubstancePolymer_MonomerSet_StartingMaterial @.startingMaterial;
}

class SubstancePolymer_Repeat_RepeatUnit_DegreeOfPolymerisation is FHIR is export {
  has Str $.id;
  has CodeableConcept $.degree;
  has Any $.amount;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class SubstancePolymer_Repeat_RepeatUnit_StructuralRepresentation is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Extension @.extension;
  has Attachment $.attachment;
  has Str $.representation;
  has Extension @.modifierExtension;
}
class SubstancePolymer_Repeat_RepeatUnit is FHIR is export {
  has Str $.id;
  has Any $.amount;
  has Extension @.extension;
  has Str $.repeatUnit;
  has Extension @.modifierExtension;
  has CodeableConcept $.orientationOfPolymerisation;
  has SubstancePolymer_Repeat_RepeatUnit_DegreeOfPolymerisation @.degreeOfPolymerisation;
  has SubstancePolymer_Repeat_RepeatUnit_StructuralRepresentation @.structuralRepresentation;
}
class SubstancePolymer_Repeat is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Int $.numberOfUnits;
  has Extension @.modifierExtension;
  has CodeableConcept $.repeatUnitAmountType;
  has Str $.averageMolecularFormula;
  has SubstancePolymer_Repeat_RepeatUnit @.repeatUnit;
}

class SubstancePolymer is DomainResource is export {
  method resourceType(--> 'SubstancePolymer') {}
  has CodeableConcept $.class;
  has CodeableConcept $.geometry;
  has Str @.modification;
  has CodeableConcept @.copolymerConnectivity;
  has SubstancePolymer_MonomerSet @.monomerSet;
  has SubstancePolymer_Repeat @.repeat;
}
class Coverage_Class is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Str $.name;
  has Str $.value is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Coverage_CostToBeneficiary_Exception is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Period $.period;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class Coverage_CostToBeneficiary is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has ChoiceField $.value is required where Money|Quantity;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has Coverage_CostToBeneficiary_Exception @.exception;
}

class Coverage is DomainResource is export {
  method resourceType(--> 'Coverage') {}
  has CodeableConcept $.type;
  has Reference @.payor is required;
  has PositiveInt $.order;
  has Code $.status is required;
  has Period $.period;
  has Str $.network;
  has Reference @.contract;
  has Str $.dependent;
  has Identifier @.identifier;
  has Reference $.subscriber;
  has Reference $.beneficiary is required;
  has Bool $.subrogation;
  has Reference $.policyHolder;
  has Str $.subscriberId;
  has CodeableConcept $.relationship;
  has Coverage_Class @.class;
  has Coverage_CostToBeneficiary @.costToBeneficiary;
}
class MedicinalProductPackaged_BatchIdentifier is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Identifier $.outerPackaging is required;
  has Extension @.modifierExtension;
  has Identifier $.immediatePackaging;
}

class MedicinalProductPackaged_PackageItem is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Reference @.device;
  has Quantity $.quantity is required;
  has CodeableConcept @.material;
  has Extension @.extension;
  has Identifier @.identifier;
  has MedicinalProductPackaged_PackageItem @.packageItem;
  has Reference @.manufacturer;
  has Reference @.manufacturedItem;
  has Any @.shelfLifeStorage;
  has Extension @.modifierExtension;
  has CodeableConcept @.alternateMaterial;
  has CodeableConcept @.otherCharacteristics;
  has Any $.physicalCharacteristics;
}

class MedicinalProductPackaged is DomainResource is export {
  method resourceType(--> 'MedicinalProductPackaged') {}
  has Reference @.subject;
  has Identifier @.identifier;
  has Str $.description;
  has Reference @.manufacturer;
  has Any @.marketingStatus;
  has CodeableConcept $.legalStatusOfSupply;
  has Reference $.marketingAuthorization;
  has MedicinalProductPackaged_BatchIdentifier @.batchIdentifier;
  has MedicinalProductPackaged_PackageItem @.packageItem is required;
}
class CatalogEntry_RelatedEntry is FHIR is export {
  has Str $.id;
  has Reference $.item is required;
  has Extension @.extension;
  has Code $.relationtype is required;
  has Extension @.modifierExtension;
}

class CatalogEntry is DomainResource is export {
  method resourceType(--> 'CatalogEntry') {}
  has CodeableConcept $.type;
  has Code $.status;
  has DateTime $.validTo;
  has Bool $.orderable is required;
  has Identifier @.identifier;
  has DateTime $.lastUpdated;
  has Reference $.referencedItem is required;
  has CodeableConcept @.classification;
  has Period $.validityPeriod;
  has Identifier @.additionalIdentifier;
  has CodeableConcept @.additionalCharacteristic;
  has CodeableConcept @.additionalClassification;
  has CatalogEntry_RelatedEntry @.relatedEntry;
}

class Schedule is DomainResource is export {
  method resourceType(--> 'Schedule') {}
  has Reference @.actor is required;
  has Bool $.active;
  has Str $.comment;
  has CodeableConcept @.specialty;
  has Identifier @.identifier;
  has CodeableConcept @.serviceType;
  has CodeableConcept @.serviceCategory;
  has Period $.planningHorizon;
}
class Procedure_Performer is FHIR is export {
  has Str $.id;
  has Reference $.actor is required;
  has CodeableConcept $.function;
  has Extension @.extension;
  has Reference $.onBehalfOf;
  has Extension @.modifierExtension;
}

class Procedure_FocalDevice is FHIR is export {
  has Str $.id;
  has CodeableConcept $.action;
  has Extension @.extension;
  has Reference $.manipulated is required;
  has Extension @.modifierExtension;
}

class Procedure is DomainResource is export {
  method resourceType(--> 'Procedure') {}
  has CodeableConcept $.code;
  has Annotation @.note;
  has Reference @.partOf;
  has Code $.status is required;
  has Reference @.report;
  has Reference @.basedOn;
  has Reference $.subject is required;
  has CodeableConcept $.outcome;
  has CodeableConcept $.category;
  has Reference $.recorder;
  has Reference $.asserter;
  has Reference $.location;
  has CodeableConcept @.bodySite;
  has CodeableConcept @.followUp;
  has CodeableConcept @.usedCode;
  has Reference $.encounter;
  has Identifier @.identifier;
  has CodeableConcept @.reasonCode;
  has CodeableConcept $.statusReason;
  has ChoiceField $.performed where Age|DateTime|Period|Range|Str;
  has CodeableConcept @.complication;
  has Reference @.usedReference;
  has UriStr @.instantiatesUri;
  has Reference @.reasonReference;
  has Reference @.complicationDetail;
  has Canonical @.instantiatesCanonical;
  has Procedure_Performer @.performer;
  has Procedure_FocalDevice @.focalDevice;
}
class Invoice_Participant is FHIR is export {
  has Str $.id;
  has CodeableConcept $.role;
  has Reference $.actor is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Invoice_LineItem_PriceComponent is FHIR is export {
  has Str $.id;
  has Code $.type is required;
  has CodeableConcept $.code;
  has Real $.factor;
  has Money $.amount;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class Invoice_LineItem is FHIR is export {
  has Str $.id;
  has PositiveInt $.sequence;
  has Extension @.extension;
  has ChoiceField $.chargeItem is required where CodeableConcept|Reference;
  has Extension @.modifierExtension;
  has Invoice_LineItem_PriceComponent @.priceComponent;
}

class Invoice is DomainResource is export {
  method resourceType(--> 'Invoice') {}
  has CodeableConcept $.type;
  has DateTime $.date;
  has Annotation @.note;
  has Code $.status is required;
  has Reference $.issuer;
  has Reference $.subject;
  has Reference $.account;
  has Money $.totalNet;
  has Reference $.recipient;
  has Identifier @.identifier;
  has Money $.totalGross;
  has Markdown $.paymentTerms;
  has Str $.cancelledReason;
  has Invoice_LineItem_PriceComponent @.totalPriceComponent;
  has Invoice_Participant @.participant;
  has Invoice_LineItem @.lineItem;
}
class MedicinalProductContraindication_OtherTherapy is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has ChoiceField $.medication is required where CodeableConcept|Reference;
  has Extension @.modifierExtension;
  has CodeableConcept $.therapyRelationshipType is required;
}

class MedicinalProductContraindication is DomainResource is export {
  method resourceType(--> 'MedicinalProductContraindication') {}
  has Reference @.subject;
  has CodeableConcept $.disease;
  has Any @.population;
  has CodeableConcept @.comorbidity;
  has CodeableConcept $.diseaseStatus;
  has Reference @.therapeuticIndication;
  has MedicinalProductContraindication_OtherTherapy @.otherTherapy;
}
class Appointment_Participant is FHIR is export {
  has Str $.id;
  has CodeableConcept @.type;
  has Reference $.actor;
  has Code $.status is required;
  has Period $.period;
  has Code $.required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Appointment is DomainResource is export {
  method resourceType(--> 'Appointment') {}
  has DateTime $.end;
  has Reference @.slot;
  has DateTime $.start;
  has Code $.status is required;
  has DateTime $.created;
  has Str $.comment;
  has Reference @.basedOn;
  has UnsignedInt $.priority;
  has CodeableConcept @.specialty;
  has Identifier @.identifier;
  has CodeableConcept @.reasonCode;
  has CodeableConcept @.serviceType;
  has Str $.description;
  has CodeableConcept @.serviceCategory;
  has CodeableConcept $.appointmentType;
  has Reference @.reasonReference;
  has PositiveInt $.minutesDuration;
  has Period @.requestedPeriod;
  has CodeableConcept $.cancelationReason;
  has Str $.patientInstruction;
  has Reference @.supportingInformation;
  has Appointment_Participant @.participant is required;
}

class Age is Quantity is export {
  
}

class Flag is DomainResource is export {
  method resourceType(--> 'Flag') {}
  has CodeableConcept $.code is required;
  has Code $.status is required;
  has Period $.period;
  has Reference $.author;
  has Reference $.subject is required;
  has CodeableConcept @.category;
  has Reference $.encounter;
  has Identifier @.identifier;
}

class ResearchSubject is DomainResource is export {
  method resourceType(--> 'ResearchSubject') {}
  has Reference $.study is required;
  has Code $.status is required;
  has Period $.period;
  has Reference $.consent;
  has Str $.actualArm;
  has Identifier @.identifier;
  has Reference $.individual is required;
  has Str $.assignedArm;
}
class MedicinalProductIngredient_Substance is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code is required;
  has MedicinalProductIngredient_SpecifiedSubstance_Strength @.strength;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MedicinalProductIngredient_SpecifiedSubstance_Strength_ReferenceStrength is FHIR is export {
  has Str $.id;
  has CodeableConcept @.country;
  has Ratio $.strength is required;
  has Extension @.extension;
  has CodeableConcept $.substance;
  has Ratio $.strengthLowLimit;
  has Str $.measurementPoint;
  has Extension @.modifierExtension;
}
class MedicinalProductIngredient_SpecifiedSubstance_Strength is FHIR is export {
  has Str $.id;
  has CodeableConcept @.country;
  has Extension @.extension;
  has Ratio $.presentation is required;
  has Ratio $.concentration;
  has Str $.measurementPoint;
  has Extension @.modifierExtension;
  has Ratio $.presentationLowLimit;
  has Ratio $.concentrationLowLimit;
  has MedicinalProductIngredient_SpecifiedSubstance_Strength_ReferenceStrength @.referenceStrength;
}
class MedicinalProductIngredient_SpecifiedSubstance is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code is required;
  has CodeableConcept $.group is required;
  has Extension @.extension;
  has CodeableConcept $.confidentiality;
  has Extension @.modifierExtension;
  has MedicinalProductIngredient_SpecifiedSubstance_Strength @.strength;
}

class MedicinalProductIngredient is DomainResource is export {
  method resourceType(--> 'MedicinalProductIngredient') {}
  has CodeableConcept $.role is required;
  has Identifier $.identifier;
  has Reference @.manufacturer;
  has Bool $.allergenicIndicator;
  has MedicinalProductIngredient_Substance $.substance;
  has MedicinalProductIngredient_SpecifiedSubstance @.specifiedSubstance;
}
class Medication_Batch is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Str $.lotNumber;
  has DateTime $.expirationDate;
  has Extension @.modifierExtension;
}

class Medication_Ingredient is FHIR is export {
  has Str $.id;
  has ChoiceField $.item is required where CodeableConcept|Reference;
  has Bool $.isActive;
  has Ratio $.strength;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Medication is DomainResource is export {
  method resourceType(--> 'Medication') {}
  has CodeableConcept $.code;
  has CodeableConcept $.form;
  has Code $.status;
  has Ratio $.amount;
  has Identifier @.identifier;
  has Reference $.manufacturer;
  has Medication_Batch $.batch;
  has Medication_Ingredient @.ingredient;
}
class VerificationResult_Validator is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Reference $.organization is required;
  has Extension @.modifierExtension;
  has Str $.identityCertificate;
  has Signature $.attestationSignature;
}

class VerificationResult_PrimarySource is FHIR is export {
  has Str $.id;
  has Reference $.who;
  has CodeableConcept @.type;
  has Extension @.extension;
  has DateTime $.validationDate;
  has CodeableConcept $.canPushUpdates;
  has CodeableConcept $.validationStatus;
  has Extension @.modifierExtension;
  has CodeableConcept @.pushTypeAvailable;
  has CodeableConcept @.communicationMethod;
}

class VerificationResult_Attestation is FHIR is export {
  has Str $.id;
  has Reference $.who;
  has Date $.date;
  has Extension @.extension;
  has Reference $.onBehalfOf;
  has Signature $.proxySignature;
  has Signature $.sourceSignature;
  has Extension @.modifierExtension;
  has CodeableConcept $.communicationMethod;
  has Str $.proxyIdentityCertificate;
  has Str $.sourceIdentityCertificate;
}

class VerificationResult is DomainResource is export {
  method resourceType(--> 'VerificationResult') {}
  has CodeableConcept $.need;
  has Reference @.target;
  has Code $.status is required;
  has Timing $.frequency;
  has DateTime $.statusDate;
  has DateTime $.lastPerformed;
  has Date $.nextScheduled;
  has CodeableConcept $.failureAction;
  has Str @.targetLocation;
  has CodeableConcept $.validationType;
  has CodeableConcept @.validationProcess;
  has VerificationResult_Validator @.validator;
  has VerificationResult_PrimarySource @.primarySource;
  has VerificationResult_Attestation $.attestation;
}
class Group_Member is FHIR is export {
  has Str $.id;
  has Reference $.entity is required;
  has Period $.period;
  has Bool $.inactive;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Group_Characteristic is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code is required;
  has Period $.period;
  has Bool $.exclude is required;
  has ChoiceField $.value is required where Bool|CodeableConcept|Quantity|Range|Reference;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Group is DomainResource is export {
  method resourceType(--> 'Group') {}
  has Code $.type is required;
  has CodeableConcept $.code;
  has Str $.name;
  has Bool $.active;
  has Bool $.actual is required;
  has UnsignedInt $.quantity;
  has Identifier @.identifier;
  has Reference $.managingEntity;
  has Group_Member @.member;
  has Group_Characteristic @.characteristic;
}
class SupplyRequest_Parameter is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code;
  has ChoiceField $.value where Bool|CodeableConcept|Quantity|Range;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class SupplyRequest is DomainResource is export {
  method resourceType(--> 'SupplyRequest') {}
  has Code $.status;
  has ChoiceField $.item is required where CodeableConcept|Reference;
  has CodeableConcept $.category;
  has Code $.priority;
  has Quantity $.quantity is required;
  has Reference @.supplier;
  has Reference $.requester;
  has Reference $.deliverTo;
  has Identifier @.identifier;
  has DateTime $.authoredOn;
  has CodeableConcept @.reasonCode;
  has Reference $.deliverFrom;
  has ChoiceField $.occurrence where DateTime|Period|Timing;
  has Reference @.reasonReference;
  has SupplyRequest_Parameter @.parameter;
}
class Composition_Event is FHIR is export {
  has Str $.id;
  has CodeableConcept @.code;
  has Period $.period;
  has Reference @.detail;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Composition_Section is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code;
  has Narrative $.text;
  has Code $.mode;
  has Str $.title;
  has Reference $.focus;
  has Reference @.entry;
  has Reference @.author;
  has Composition_Section @.section;
  has Extension @.extension;
  has CodeableConcept $.orderedBy;
  has CodeableConcept $.emptyReason;
  has Extension @.modifierExtension;
}

class Composition_Attester is FHIR is export {
  has Str $.id;
  has Code $.mode is required;
  has DateTime $.time;
  has Reference $.party;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Composition_RelatesTo is FHIR is export {
  has Str $.id;
  has Code $.code is required;
  has Extension @.extension;
  has ChoiceField $.target is required where Identifier|Reference;
  has Extension @.modifierExtension;
}

class Composition is DomainResource is export {
  method resourceType(--> 'Composition') {}
  has CodeableConcept $.type is required;
  has DateTime $.date is required;
  has Str $.title is required;
  has Code $.status is required;
  has Reference @.author is required;
  has Reference $.subject;
  has CodeableConcept @.category;
  has Reference $.encounter;
  has Reference $.custodian;
  has Identifier $.identifier;
  has Code $.confidentiality;
  has Composition_Event @.event;
  has Composition_Section @.section;
  has Composition_Attester @.attester;
  has Composition_RelatesTo @.relatesTo;
}
class DocumentManifest_Related is FHIR is export {
  has Str $.id;
  has Reference $.ref;
  has Extension @.extension;
  has Identifier $.identifier;
  has Extension @.modifierExtension;
}

class DocumentManifest is DomainResource is export {
  method resourceType(--> 'DocumentManifest') {}
  has CodeableConcept $.type;
  has Code $.status is required;
  has Reference @.author;
  has UriStr $.source;
  has Reference $.subject;
  has DateTime $.created;
  has Reference @.content is required;
  has Reference @.recipient;
  has Identifier @.identifier;
  has Str $.description;
  has Identifier $.masterIdentifier;
  has DocumentManifest_Related @.related;
}
class DeviceMetric_Calibration is FHIR is export {
  has Str $.id;
  has Code $.type;
  has DateTime $.time;
  has Code $.state;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class DeviceMetric is DomainResource is export {
  method resourceType(--> 'DeviceMetric') {}
  has CodeableConcept $.type is required;
  has CodeableConcept $.unit;
  has Code $.color;
  has Reference $.source;
  has Reference $.parent;
  has Code $.category is required;
  has Identifier @.identifier;
  has Code $.operationalStatus;
  has Timing $.measurementPeriod;
  has DeviceMetric_Calibration @.calibration;
}

class Duration is Quantity is export {
  
}
class RelatedPerson_Communication is FHIR is export {
  has Str $.id;
  has CodeableConcept $.language is required;
  has Extension @.extension;
  has Bool $.preferred;
  has Extension @.modifierExtension;
}

class RelatedPerson is DomainResource is export {
  method resourceType(--> 'RelatedPerson') {}
  has HumanName @.name;
  has Attachment @.photo;
  has Bool $.active;
  has Code $.gender;
  has Period $.period;
  has Reference $.patient is required;
  has ContactPoint @.telecom;
  has Address @.address;
  has Date $.birthDate;
  has Identifier @.identifier;
  has CodeableConcept @.relationship;
  has RelatedPerson_Communication @.communication;
}

class DeviceUseStatement is DomainResource is export {
  method resourceType(--> 'DeviceUseStatement') {}
  has Annotation @.note;
  has Code $.status is required;
  has Reference $.source;
  has Reference $.device is required;
  has Reference @.basedOn;
  has Reference $.subject is required;
  has CodeableConcept $.bodySite;
  has ChoiceField $.timing where DateTime|Period|Timing;
  has Identifier @.identifier;
  has DateTime $.recordedOn;
  has CodeableConcept @.reasonCode;
  has Reference @.derivedFrom;
  has Reference @.reasonReference;
}
class NutritionOrder_Supplement is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Timing @.schedule;
  has Quantity $.quantity;
  has Extension @.extension;
  has Str $.productName;
  has Str $.instruction;
  has Extension @.modifierExtension;
}

class NutritionOrder_OralDiet_Texture is FHIR is export {
  has Str $.id;
  has CodeableConcept $.modifier;
  has CodeableConcept $.foodType;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class NutritionOrder_OralDiet_Nutrient is FHIR is export {
  has Str $.id;
  has Quantity $.amount;
  has CodeableConcept $.modifier;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class NutritionOrder_OralDiet is FHIR is export {
  has Str $.id;
  has CodeableConcept @.type;
  has Timing @.schedule;
  has Extension @.extension;
  has Str $.instruction;
  has Extension @.modifierExtension;
  has CodeableConcept @.fluidConsistencyType;
  has NutritionOrder_OralDiet_Texture @.texture;
  has NutritionOrder_OralDiet_Nutrient @.nutrient;
}

class NutritionOrder_EnteralFormula_Administration is FHIR is export {
  has Str $.id;
  has ChoiceField $.rate where Quantity|Ratio;
  has Timing $.schedule;
  has Quantity $.quantity;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class NutritionOrder_EnteralFormula is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has CodeableConcept $.additiveType;
  has Quantity $.caloricDensity;
  has CodeableConcept $.baseFormulaType;
  has Extension @.modifierExtension;
  has Quantity $.maxVolumeToDeliver;
  has Str $.additiveProductName;
  has CodeableConcept $.routeofAdministration;
  has Str $.baseFormulaProductName;
  has Str $.administrationInstruction;
  has NutritionOrder_EnteralFormula_Administration @.administration;
}

class NutritionOrder is DomainResource is export {
  method resourceType(--> 'NutritionOrder') {}
  has Annotation @.note;
  has Code $.status is required;
  has Code $.intent is required;
  has Reference $.patient is required;
  has Reference $.orderer;
  has DateTime $.dateTime is required;
  has Reference $.encounter;
  has Identifier @.identifier;
  has UriStr @.instantiates;
  has UriStr @.instantiatesUri;
  has Reference @.allergyIntolerance;
  has CodeableConcept @.excludeFoodModifier;
  has Canonical @.instantiatesCanonical;
  has CodeableConcept @.foodPreferenceModifier;
  has NutritionOrder_Supplement @.supplement;
  has NutritionOrder_OralDiet $.oralDiet;
  has NutritionOrder_EnteralFormula $.enteralFormula;
}
class Questionnaire_Item_Initial is FHIR is export {
  has Str $.id;
  has ChoiceField $.value is required where Attachment|Bool|Coding|Real|Date|DateTime|Int|Instant|Quantity|Reference|Str|UriStr;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class Questionnaire_Item_EnableWhen is FHIR is export {
  has Str $.id;
  has Str $.question is required;
  has Code $.operator is required;
  has Extension @.extension;
  has ChoiceField $.answer is required where Bool|Coding|Real|Date|DateTime|Int|Instant|Quantity|Reference|Str;
  has Extension @.modifierExtension;
}

class Questionnaire_Item_AnswerOption is FHIR is export {
  has Str $.id;
  has ChoiceField $.value is required where Coding|Date|Int|Instant|Reference|Str;
  has Extension @.extension;
  has Bool $.initialSelected;
  has Extension @.modifierExtension;
}
class Questionnaire_Item is FHIR is export {
  has Str $.id;
  has Coding @.code;
  has Str $.text;
  has Code $.type is required;
  has Questionnaire_Item @.item;
  has Str $.linkId is required;
  has Str $.prefix;
  has Bool $.repeats;
  has Bool $.required;
  has Bool $.readOnly;
  has Extension @.extension;
  has Int $.maxLength;
  has UriStr $.definition;
  has Code $.enableBehavior;
  has Canonical $.answerValueSet;
  has Extension @.modifierExtension;
  has Questionnaire_Item_Initial @.initial;
  has Questionnaire_Item_EnableWhen @.enableWhen;
  has Questionnaire_Item_AnswerOption @.answerOption;
}

class Questionnaire is DomainResource is export {
  method resourceType(--> 'Questionnaire') {}
  has UriStr $.url;
  has Str $.name;
  has DateTime $.date;
  has Coding @.code;
  has Str $.title;
  has Code $.status is required;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Str $.publisher;
  has Markdown $.copyright;
  has Identifier @.identifier;
  has UsageContext @.useContext;
  has Canonical @.derivedFrom;
  has Code @.subjectType;
  has Markdown $.description;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has Date $.approvalDate;
  has Date $.lastReviewDate;
  has Period $.effectivePeriod;
  has Questionnaire_Item @.item;
}
class MedicinalProductIndication_OtherTherapy is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has ChoiceField $.medication is required where CodeableConcept|Reference;
  has Extension @.modifierExtension;
  has CodeableConcept $.therapyRelationshipType is required;
}

class MedicinalProductIndication is DomainResource is export {
  method resourceType(--> 'MedicinalProductIndication') {}
  has Reference @.subject;
  has Quantity $.duration;
  has Any @.population;
  has CodeableConcept @.comorbidity;
  has CodeableConcept $.diseaseStatus;
  has CodeableConcept $.intendedEffect;
  has Reference @.undesirableEffect;
  has CodeableConcept $.diseaseSymptomProcedure;
  has MedicinalProductIndication_OtherTherapy @.otherTherapy;
}
class Specimen_Container is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Quantity $.capacity;
  has Extension @.extension;
  has Identifier @.identifier;
  has Str $.description;
  has ChoiceField $.additive where CodeableConcept|Reference;
  has Quantity $.specimenQuantity;
  has Extension @.modifierExtension;
}

class Specimen_Collection is FHIR is export {
  has Str $.id;
  has CodeableConcept $.method;
  has Duration $.duration;
  has Quantity $.quantity;
  has CodeableConcept $.bodySite;
  has Extension @.extension;
  has Reference $.collector;
  has ChoiceField $.collected where DateTime|Period;
  has ChoiceField $.fastingStatus where CodeableConcept|Duration;
  has Extension @.modifierExtension;
}

class Specimen_Processing is FHIR is export {
  has Str $.id;
  has ChoiceField $.time where DateTime|Period;
  has Reference @.additive;
  has Extension @.extension;
  has CodeableConcept $.procedure;
  has Str $.description;
  has Extension @.modifierExtension;
}

class Specimen is DomainResource is export {
  method resourceType(--> 'Specimen') {}
  has CodeableConcept $.type;
  has Annotation @.note;
  has Code $.status;
  has Reference @.parent;
  has Reference $.subject;
  has Reference @.request;
  has CodeableConcept @.condition;
  has Identifier @.identifier;
  has DateTime $.receivedTime;
  has Identifier $.accessionIdentifier;
  has Specimen_Container @.container;
  has Specimen_Collection $.collection;
  has Specimen_Processing @.processing;
}
class MeasureReport_Group_Population is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code;
  has Int $.count;
  has Extension @.extension;
  has Reference $.subjectResults;
  has Extension @.modifierExtension;
}

class MeasureReport_Group_Stratifier_Stratum_Component is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code is required;
  has CodeableConcept $.value is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class MeasureReport_Group_Stratifier_Stratum_Population is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code;
  has Int $.count;
  has Extension @.extension;
  has Reference $.subjectResults;
  has Extension @.modifierExtension;
}
class MeasureReport_Group_Stratifier_Stratum is FHIR is export {
  has Str $.id;
  has CodeableConcept $.value;
  has Extension @.extension;
  has Quantity $.measureScore;
  has Extension @.modifierExtension;
  has MeasureReport_Group_Stratifier_Stratum_Component @.component;
  has MeasureReport_Group_Stratifier_Stratum_Population @.population;
}
class MeasureReport_Group_Stratifier is FHIR is export {
  has Str $.id;
  has CodeableConcept @.code;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has MeasureReport_Group_Stratifier_Stratum @.stratum;
}
class MeasureReport_Group is FHIR is export {
  has Str $.id;
  has CodeableConcept $.code;
  has Extension @.extension;
  has Quantity $.measureScore;
  has Extension @.modifierExtension;
  has MeasureReport_Group_Population @.population;
  has MeasureReport_Group_Stratifier @.stratifier;
}

class MeasureReport is DomainResource is export {
  method resourceType(--> 'MeasureReport') {}
  has Code $.type is required;
  has DateTime $.date;
  has Code $.status is required;
  has Period $.period is required;
  has Canonical $.measure is required;
  has Reference $.subject;
  has Reference $.reporter;
  has Identifier @.identifier;
  has Reference @.evaluatedResource;
  has CodeableConcept $.improvementNotation;
  has MeasureReport_Group @.group;
}
class Dosage_DoseAndRate is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has ChoiceField $.dose where Quantity|Range;
  has ChoiceField $.rate where Quantity|Range|Ratio;
  has Extension @.extension;
}

class Dosage is BackboneElement is export {
  has Str $.text;
  has CodeableConcept $.site;
  has CodeableConcept $.route;
  has Timing $.timing;
  has CodeableConcept $.method;
  has Int $.sequence;
  has ChoiceField $.asNeeded where Bool|CodeableConcept;
  has Ratio $.maxDosePerPeriod;
  has Str $.patientInstruction;
  has Quantity $.maxDosePerLifetime;
  has CodeableConcept @.additionalInstruction;
  has Dosage_DoseAndRate @.doseAndRate;
  has Quantity $.maxDosePerAdministration;
}
class ConceptMap_Group_Unmapped is FHIR is export {
  has Str $.id;
  has Canonical $.url;
  has Code $.mode is required;
  has Code $.code;
  has Str $.display;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class ConceptMap_Group_Element_Target_DependsOn is FHIR is export {
  has Str $.id;
  has Str $.value is required;
  has Canonical $.system;
  has Str $.display;
  has UriStr $.property is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class ConceptMap_Group_Element_Target is FHIR is export {
  has Str $.id;
  has Code $.code;
  has Str $.display;
  has Str $.comment;
  has ConceptMap_Group_Element_Target_DependsOn @.product;
  has Extension @.extension;
  has Code $.equivalence is required;
  has Extension @.modifierExtension;
  has ConceptMap_Group_Element_Target_DependsOn @.dependsOn;
}
class ConceptMap_Group_Element is Element is export {
  has Str $.id;
  has Code $.code;
  has Str $.display;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has ConceptMap_Group_Element_Target @.target;
}
class ConceptMap_Group is FHIR is export {
  has Str $.id;
  has UriStr $.source;
  has UriStr $.target;
  has Extension @.extension;
  has Str $.sourceVersion;
  has Str $.targetVersion;
  has Extension @.modifierExtension;
  has ConceptMap_Group_Unmapped $.unmapped;
  has ConceptMap_Group_Element @.element is required;
}

class ConceptMap is DomainResource is export {
  method resourceType(--> 'ConceptMap') {}
  has UriStr $.url;
  has Str $.name;
  has DateTime $.date;
  has Str $.title;
  has Code $.status is required;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Str $.publisher;
  has Markdown $.copyright;
  has ChoiceField $.source where Canonical|UriStr;
  has ChoiceField $.target where Canonical|UriStr;
  has Identifier $.identifier;
  has UsageContext @.useContext;
  has Markdown $.description;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has ConceptMap_Group @.group;
}
class ResearchStudy_Arm is FHIR is export {
  has Str $.id;
  has Str $.name is required;
  has CodeableConcept $.type;
  has Extension @.extension;
  has Str $.description;
  has Extension @.modifierExtension;
}

class ResearchStudy_Objective is FHIR is export {
  has Str $.id;
  has Str $.name;
  has CodeableConcept $.type;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class ResearchStudy is DomainResource is export {
  method resourceType(--> 'ResearchStudy') {}
  has Reference @.site;
  has Annotation @.note;
  has Str $.title;
  has CodeableConcept $.phase;
  has CodeableConcept @.focus;
  has Reference @.partOf;
  has Code $.status is required;
  has Period $.period;
  has ContactDetail @.contact;
  has CodeableConcept @.keyword;
  has Reference $.sponsor;
  has Reference @.protocol;
  has CodeableConcept @.category;
  has CodeableConcept @.location;
  has CodeableConcept @.condition;
  has Identifier @.identifier;
  has Reference @.enrollment;
  has Markdown $.description;
  has CodeableConcept $.reasonStopped;
  has RelatedArtifact @.relatedArtifact;
  has CodeableConcept $.primaryPurposeType;
  has Reference $.principalInvestigator;
  has ResearchStudy_Arm @.arm;
  has ResearchStudy_Objective @.objective;
}
class ActivityDefinition_Participant is FHIR is export {
  has Str $.id;
  has Code $.type is required;
  has CodeableConcept $.role;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class ActivityDefinition_DynamicValue is FHIR is export {
  has Str $.id;
  has Str $.path is required;
  has Extension @.extension;
  has Expression $.expression is required;
  has Extension @.modifierExtension;
}

class ActivityDefinition is DomainResource is export {
  method resourceType(--> 'ActivityDefinition') {}
  has UriStr $.url;
  has Str $.name;
  has DateTime $.date;
  has Code $.kind;
  has CodeableConcept $.code;
  has Str $.title;
  has Str $.usage;
  has CodeableConcept @.topic;
  has Code $.status is required;
  has ContactDetail @.author;
  has ContactDetail @.editor;
  has Code $.intent;
  has Dosage @.dosage;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Canonical @.library;
  has Canonical $.profile;
  has Str $.subtitle;
  has ContactDetail @.reviewer;
  has ContactDetail @.endorser;
  has Code $.priority;
  has Reference $.location;
  has Quantity $.quantity;
  has CodeableConcept @.bodySite;
  has Str $.publisher;
  has Markdown $.copyright;
  has ChoiceField $.timing where Age|Duration|DateTime|Period|Range|Timing;
  has Canonical $.transform;
  has Identifier @.identifier;
  has ChoiceField $.subject where CodeableConcept|Reference;
  has UsageContext @.useContext;
  has ChoiceField $.product where CodeableConcept|Reference;
  has Markdown $.description;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has Date $.approvalDate;
  has Bool $.doNotPerform;
  has Date $.lastReviewDate;
  has Period $.effectivePeriod;
  has RelatedArtifact @.relatedArtifact;
  has Reference @.specimenRequirement;
  has Reference @.observationRequirement;
  has Reference @.observationResultRequirement;
  has ActivityDefinition_Participant @.participant;
  has ActivityDefinition_DynamicValue @.dynamicValue;
}
class Contract_Rule is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has ChoiceField $.content is required where Attachment|Reference;
  has Extension @.modifierExtension;
}

class Contract_Legal is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has ChoiceField $.content is required where Attachment|Reference;
  has Extension @.modifierExtension;
}

class Contract_Signer is FHIR is export {
  has Str $.id;
  has Coding $.type is required;
  has Reference $.party is required;
  has Extension @.extension;
  has Signature @.signature is required;
  has Extension @.modifierExtension;
}

class Contract_Friendly is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has ChoiceField $.content is required where Attachment|Reference;
  has Extension @.modifierExtension;
}

class Contract_ContentDefinition is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has CodeableConcept $.subType;
  has Extension @.extension;
  has Reference $.publisher;
  has Markdown $.copyright;
  has DateTime $.publicationDate;
  has Extension @.modifierExtension;
  has Code $.publicationStatus is required;
}

class Contract_Term_Offer_Party is FHIR is export {
  has Str $.id;
  has CodeableConcept $.role is required;
  has Extension @.extension;
  has Reference @.reference is required;
  has Extension @.modifierExtension;
}

class Contract_Term_Offer_Answer is FHIR is export {
  has Str $.id;
  has ChoiceField $.value is required where Attachment|Bool|Coding|Real|Date|DateTime|Int|Instant|Quantity|Reference|Str|UriStr;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class Contract_Term_Offer is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Str $.text;
  has Reference $.topic;
  has Str @.linkId;
  has CodeableConcept $.decision;
  has Extension @.extension;
  has Identifier @.identifier;
  has CodeableConcept @.decisionMode;
  has Extension @.modifierExtension;
  has UnsignedInt @.securityLabelNumber;
  has Contract_Term_Offer_Party @.party;
  has Contract_Term_Offer_Answer @.answer;
}

class Contract_Term_SecurityLabel is FHIR is export {
  has Str $.id;
  has UnsignedInt @.number;
  has Coding @.control;
  has Coding @.category;
  has Extension @.extension;
  has Coding $.classification is required;
  has Extension @.modifierExtension;
}

class Contract_Term_Action_Subject is FHIR is export {
  has Str $.id;
  has CodeableConcept $.role;
  has Extension @.extension;
  has Reference @.reference is required;
  has Extension @.modifierExtension;
}
class Contract_Term_Action is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type is required;
  has Annotation @.note;
  has CodeableConcept $.intent is required;
  has Str @.linkId;
  has CodeableConcept $.status is required;
  has Str @.reason;
  has Reference $.context;
  has Extension @.extension;
  has Reference @.requester;
  has Reference $.performer;
  has CodeableConcept @.reasonCode;
  has Bool $.doNotPerform;
  has Str @.reasonLinkId;
  has Str @.contextLinkId;
  has ChoiceField $.occurrence where DateTime|Period|Timing;
  has CodeableConcept @.performerType;
  has CodeableConcept $.performerRole;
  has Str @.requesterLinkId;
  has Str @.performerLinkId;
  has Reference @.reasonReference;
  has Extension @.modifierExtension;
  has UnsignedInt @.securityLabelNumber;
  has Contract_Term_Action_Subject @.subject;
}

class Contract_Term_Asset_Context is FHIR is export {
  has Str $.id;
  has CodeableConcept @.code;
  has Str $.text;
  has Extension @.extension;
  has Reference $.reference;
  has Extension @.modifierExtension;
}

class Contract_Term_Asset_ValuedItem is FHIR is export {
  has Str $.id;
  has Money $.net;
  has Real $.factor;
  has Real $.points;
  has Str @.linkId;
  has Str $.payment;
  has Quantity $.quantity;
  has Extension @.extension;
  has ChoiceField $.entity where CodeableConcept|Reference;
  has Money $.unitPrice;
  has Reference $.recipient;
  has Identifier $.identifier;
  has DateTime $.paymentDate;
  has Reference $.responsible;
  has DateTime $.effectiveTime;
  has Extension @.modifierExtension;
  has UnsignedInt @.securityLabelNumber;
}
class Contract_Term_Asset is FHIR is export {
  has Str $.id;
  has CodeableConcept @.type;
  has Str $.text;
  has CodeableConcept $.scope;
  has Period @.period;
  has Str @.linkId;
  has Contract_Term_Offer_Answer @.answer;
  has CodeableConcept @.subtype;
  has Extension @.extension;
  has Str $.condition;
  has Period @.usePeriod;
  has CodeableConcept @.periodType;
  has Coding $.relationship;
  has Reference @.typeReference;
  has Extension @.modifierExtension;
  has UnsignedInt @.securityLabelNumber;
  has Contract_Term_Asset_Context @.context;
  has Contract_Term_Asset_ValuedItem @.valuedItem;
}
class Contract_Term is FHIR is export {
  has Str $.id;
  has CodeableConcept $.type;
  has Str $.text;
  has Contract_Term @.group;
  has DateTime $.issued;
  has Period $.applies;
  has CodeableConcept $.subType;
  has ChoiceField $.topic where CodeableConcept|Reference;
  has Extension @.extension;
  has Identifier $.identifier;
  has Extension @.modifierExtension;
  has Contract_Term_Offer $.offer is required;
  has Contract_Term_SecurityLabel @.securityLabel;
  has Contract_Term_Action @.action;
  has Contract_Term_Asset @.asset;
}

class Contract is DomainResource is export {
  method resourceType(--> 'Contract') {}
  has UriStr $.url;
  has Reference @.site;
  has Str $.name;
  has CodeableConcept $.type;
  has Str $.title;
  has Str @.alias;
  has CodeableConcept $.scope;
  has Code $.status;
  has DateTime $.issued;
  has Reference @.domain;
  has Reference $.author;
  has Str $.version;
  has Period $.applies;
  has Reference @.subject;
  has CodeableConcept @.subType;
  has Str $.subtitle;
  has ChoiceField $.topic where CodeableConcept|Reference;
  has Reference @.authority;
  has Identifier @.identifier;
  has CodeableConcept $.legalState;
  has CodeableConcept $.expirationType;
  has Reference @.supportingInfo;
  has UriStr $.instantiatesUri;
  has Reference @.relevantHistory;
  has CodeableConcept $.contentDerivative;
  has ChoiceField $.legallyBinding where Attachment|Reference;
  has Reference $.instantiatesCanonical;
  has Contract_Rule @.rule;
  has Contract_Legal @.legal;
  has Contract_Signer @.signer;
  has Contract_Friendly @.friendly;
  has Contract_ContentDefinition $.contentDefinition;
  has Contract_Term @.term;
}
class ValueSet_Expansion_Contains is FHIR is export {
  has Str $.id;
  has Code $.code;
  has UriStr $.system;
  has Str $.version;
  has Str $.display;
  has Bool $.abstract;
  has Bool $.inactive;
  has ValueSet_Expansion_Contains @.contains;
  has Extension @.extension;
  has ValueSet_Compose_Include_Concept_Designation @.designation;
  has Extension @.modifierExtension;
}

class ValueSet_Expansion_Parameter is FHIR is export {
  has Str $.id;
  has Str $.name is required;
  has ChoiceField $.value where Bool|Code|Real|DateTime|Int|Str|UriStr;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class ValueSet_Expansion is FHIR is export {
  has Str $.id;
  has Int $.total;
  has Int $.offset;
  has Extension @.extension;
  has DateTime $.timestamp is required;
  has UriStr $.identifier;
  has Extension @.modifierExtension;
  has ValueSet_Expansion_Contains @.contains;
  has ValueSet_Expansion_Parameter @.parameter;
}

class ValueSet_Compose_Include_Filter is FHIR is export {
  has Str $.id;
  has Code $.op is required;
  has Str $.value is required;
  has Code $.property is required;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class ValueSet_Compose_Include_Concept_Designation is FHIR is export {
  has Str $.id;
  has Coding $.use;
  has Str $.value is required;
  has Code $.language;
  has Extension @.extension;
  has Extension @.modifierExtension;
}
class ValueSet_Compose_Include_Concept is FHIR is export {
  has Str $.id;
  has Code $.code is required;
  has Str $.display;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has ValueSet_Compose_Include_Concept_Designation @.designation;
}
class ValueSet_Compose_Include is FHIR is export {
  has Str $.id;
  has UriStr $.system;
  has Str $.version;
  has Canonical @.valueSet;
  has Extension @.extension;
  has Extension @.modifierExtension;
  has ValueSet_Compose_Include_Filter @.filter;
  has ValueSet_Compose_Include_Concept @.concept;
}
class ValueSet_Compose is FHIR is export {
  has Str $.id;
  has ValueSet_Compose_Include @.exclude;
  has Bool $.inactive;
  has Extension @.extension;
  has Date $.lockedDate;
  has Extension @.modifierExtension;
  has ValueSet_Compose_Include @.include is required;
}

class ValueSet is DomainResource is export {
  method resourceType(--> 'ValueSet') {}
  has UriStr $.url;
  has Str $.name;
  has DateTime $.date;
  has Str $.title;
  has Code $.status is required;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Str $.publisher;
  has Bool $.immutable;
  has Markdown $.copyright;
  has Identifier @.identifier;
  has UsageContext @.useContext;
  has Markdown $.description;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has ValueSet_Expansion $.expansion;
  has ValueSet_Compose $.compose;
}

class Basic is DomainResource is export {
  method resourceType(--> 'Basic') {}
  has CodeableConcept $.code is required;
  has Reference $.author;
  has Reference $.subject;
  has Date $.created;
  has Identifier @.identifier;
}
class ElementDefinition_Base is FHIR is export {
  has Str $.id;
  has UnsignedInt $.min is required;
  has Str $.max is required;
  has Str $.path is required;
  has Extension @.extension;
}

class ElementDefinition_Example is FHIR is export {
  has Str $.id;
  has Str $.label is required;
  has ChoiceField $.value is required where Address|Age|Annotation|Attachment|Base64Binary|Bool|Canonical|Code|CodeableConcept|Coding|ContactDetail|ContactPoint|Contributor|Count|DataRequirement|Distance|Dosage|Real|Duration|Expression|Date|DateTime|HumanName|Id|Identifier|Int|Instant|Markdown|Money|OID|ParameterDefinition|Period|PositiveInt|Quantity|Range|Ratio|Reference|RelatedArtifact|SampledData|Signature|Str|Timing|TriggerDefinition|UUID|UnsignedInt|UriStr|UrlStr|UsageContext|DateTime;
  has Extension @.extension;
}

class ElementDefinition_Mapping is FHIR is export {
  has Str $.id;
  has Str $.map is required;
  has Str $.comment;
  has Id $.identity is required;
  has Code $.language;
  has Extension @.extension;
}

class ElementDefinition_Type is FHIR is export {
  has Str $.id;
  has UriStr $.code is required;
  has Canonical @.profile;
  has Extension @.extension;
  has Code $.versioning;
  has Code @.aggregation;
  has Canonical @.targetProfile;
}

class ElementDefinition_Binding is FHIR is export {
  has Str $.id;
  has Code $.strength is required;
  has Canonical $.valueSet;
  has Extension @.extension;
  has Str $.description;
}

class ElementDefinition_Constraint is FHIR is export {
  has Str $.id;
  has Id $.key is required;
  has Str $.human is required;
  has Str $.xpath;
  has Canonical $.source;
  has Code $.severity is required;
  has Extension @.extension;
  has Str $.expression;
  has Str $.requirements;
}

class ElementDefinition_Slicing_Discriminator is FHIR is export {
  has Str $.id;
  has Code $.type is required;
  has Str $.path is required;
  has Extension @.extension;
}
class ElementDefinition_Slicing is FHIR is export {
  has Str $.id;
  has Code $.rules is required;
  has Bool $.ordered;
  has Extension @.extension;
  has Str $.description;
  has ElementDefinition_Slicing_Discriminator @.discriminator;
}

class ElementDefinition is BackboneElement is export {
  has UnsignedInt $.min;
  has Str $.max;
  has Str $.path is required;
  has Coding @.code;
  has Str $.label;
  has Str $.short;
  has Str @.alias;
  has Markdown $.comment;
  has ChoiceField $.fixed where Address|Age|Annotation|Attachment|Base64Binary|Bool|Canonical|Code|CodeableConcept|Coding|ContactDetail|ContactPoint|Contributor|Count|DataRequirement|Distance|Dosage|Real|Duration|Expression|Date|DateTime|HumanName|Id|Identifier|Int|Instant|Markdown|Money|OID|ParameterDefinition|Period|PositiveInt|Quantity|Range|Ratio|Reference|RelatedArtifact|SampledData|Signature|Str|Timing|TriggerDefinition|UUID|UnsignedInt|UriStr|UrlStr|UsageContext|DateTime;
  has Str $.sliceName;
  has Int $.maxLength;
  has Id @.condition;
  has Bool $.isSummary;
  has Markdown $.definition;
  has ChoiceField $.pattern where Address|Age|Annotation|Attachment|Base64Binary|Bool|Canonical|Code|CodeableConcept|Coding|ContactDetail|ContactPoint|Contributor|Count|DataRequirement|Distance|Dosage|Real|Duration|Expression|Date|DateTime|HumanName|Id|Identifier|Int|Instant|Markdown|Money|OID|ParameterDefinition|Period|PositiveInt|Quantity|Range|Ratio|Reference|RelatedArtifact|SampledData|Signature|Str|Timing|TriggerDefinition|UUID|UnsignedInt|UriStr|UrlStr|UsageContext|DateTime;
  has Bool $.isModifier;
  has ChoiceField $.minValue where Real|Date|DateTime|Int|Instant|PositiveInt|Quantity|UnsignedInt|DateTime;
  has ChoiceField $.maxValue where Real|Date|DateTime|Int|Instant|PositiveInt|Quantity|UnsignedInt|DateTime;
  has Bool $.mustSupport;
  has Markdown $.requirements;
  has Str $.orderMeaning;
  has Code @.representation;
  has ElementDefinition_Base $.base;
  has ChoiceField $.defaultValue where Address|Age|Annotation|Attachment|Base64Binary|Bool|Canonical|Code|CodeableConcept|Coding|ContactDetail|ContactPoint|Contributor|Count|DataRequirement|Distance|Dosage|Real|Duration|Expression|Date|DateTime|HumanName|Id|Identifier|Int|Instant|Markdown|Money|OID|ParameterDefinition|Period|PositiveInt|Quantity|Range|Ratio|Reference|RelatedArtifact|SampledData|Signature|Str|Timing|TriggerDefinition|UUID|UnsignedInt|UriStr|UrlStr|UsageContext|DateTime;
  has UriStr $.contentReference;
  has Str $.isModifierReason;
  has ElementDefinition_Example @.example;
  has ElementDefinition_Mapping @.mapping;
  has ElementDefinition_Type @.type;
  has Markdown $.meaningWhenMissing;
  has Bool $.sliceIsConstraining;
  has ElementDefinition_Binding $.binding;
  has ElementDefinition_Constraint @.constraint;
  has ElementDefinition_Slicing $.slicing;
}
class PlanDefinition_Goal_Target is FHIR is export {
  has Str $.id;
  has Duration $.due;
  has CodeableConcept $.measure;
  has Extension @.extension;
  has ChoiceField $.detail where CodeableConcept|Quantity|Range;
  has Extension @.modifierExtension;
}
class PlanDefinition_Goal is FHIR is export {
  has Str $.id;
  has CodeableConcept $.start;
  has CodeableConcept $.category;
  has CodeableConcept $.priority;
  has Extension @.extension;
  has CodeableConcept @.addresses;
  has CodeableConcept $.description is required;
  has RelatedArtifact @.documentation;
  has Extension @.modifierExtension;
  has PlanDefinition_Goal_Target @.target;
}

class PlanDefinition_Action_Condition is FHIR is export {
  has Str $.id;
  has Code $.kind is required;
  has Extension @.extension;
  has Expression $.expression;
  has Extension @.modifierExtension;
}

class PlanDefinition_Action_Participant is FHIR is export {
  has Str $.id;
  has Code $.type is required;
  has CodeableConcept $.role;
  has Extension @.extension;
  has Extension @.modifierExtension;
}

class PlanDefinition_Action_DynamicValue is FHIR is export {
  has Str $.id;
  has Str $.path;
  has Extension @.extension;
  has Expression $.expression;
  has Extension @.modifierExtension;
}

class PlanDefinition_Action_RelatedAction is FHIR is export {
  has Str $.id;
  has Id $.actionId is required;
  has Extension @.extension;
  has ChoiceField $.offset where Duration|Range;
  has Code $.relationship is required;
  has Extension @.modifierExtension;
}
class PlanDefinition_Action is FHIR is export {
  has Str $.id;
  has CodeableConcept @.code;
  has CodeableConcept $.type;
  has Str $.title;
  has DataRequirement @.input;
  has Str $.prefix;
  has CodeableConcept @.reason;
  has Id @.goalId;
  has DataRequirement @.output;
  has PlanDefinition_Action @.action;
  has TriggerDefinition @.trigger;
  has Code $.priority;
  has Extension @.extension;
  has ChoiceField $.timing where Age|Duration|DateTime|Period|Range|Timing;
  has Canonical $.transform;
  has ChoiceField $.subject where CodeableConcept|Reference;
  has Str $.description;
  has RelatedArtifact @.documentation;
  has ChoiceField $.definition where Canonical|UriStr;
  has Str $.textEquivalent;
  has Code $.groupingBehavior;
  has Code $.requiredBehavior;
  has Code $.precheckBehavior;
  has Extension @.modifierExtension;
  has Code $.selectionBehavior;
  has Code $.cardinalityBehavior;
  has PlanDefinition_Action_Condition @.condition;
  has PlanDefinition_Action_Participant @.participant;
  has PlanDefinition_Action_DynamicValue @.dynamicValue;
  has PlanDefinition_Action_RelatedAction @.relatedAction;
}

class PlanDefinition is DomainResource is export {
  method resourceType(--> 'PlanDefinition') {}
  has UriStr $.url;
  has Str $.name;
  has CodeableConcept $.type;
  has DateTime $.date;
  has Str $.title;
  has Str $.usage;
  has CodeableConcept @.topic;
  has Code $.status is required;
  has ContactDetail @.author;
  has ContactDetail @.editor;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Canonical @.library;
  has Str $.subtitle;
  has ContactDetail @.reviewer;
  has ContactDetail @.endorser;
  has Str $.publisher;
  has Markdown $.copyright;
  has Identifier @.identifier;
  has ChoiceField $.subject where CodeableConcept|Reference;
  has UsageContext @.useContext;
  has Markdown $.description;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has Date $.approvalDate;
  has Date $.lastReviewDate;
  has Period $.effectivePeriod;
  has RelatedArtifact @.relatedArtifact;
  has PlanDefinition_Goal @.goal;
  has PlanDefinition_Action @.action;
}
class SearchParameter_Component is FHIR is export {
  has Str $.id;
  has Extension @.extension;
  has Canonical $.definition is required;
  has Str $.expression is required;
  has Extension @.modifierExtension;
}

class SearchParameter is DomainResource is export {
  method resourceType(--> 'SearchParameter') {}
  has UriStr $.url is required;
  has Str $.name is required;
  has DateTime $.date;
  has Code $.code is required;
  has Code @.base is required;
  has Code $.type is required;
  has Str $.xpath;
  has Str @.chain;
  has Code $.status is required;
  has Code @.target;
  has Str $.version;
  has ContactDetail @.contact;
  has Markdown $.purpose;
  has Code @.modifier;
  has Str $.publisher;
  has UsageContext @.useContext;
  has Str $.expression;
  has Code $.xpathUsage;
  has Bool $.multipleOr;
  has Code @.comparator;
  has Canonical $.derivedFrom;
  has Markdown $.description is required;
  has Bool $.multipleAnd;
  has Bool $.experimental;
  has CodeableConcept @.jurisdiction;
  has SearchParameter_Component @.component;
}
class BiologicallyDerivedProduct_Storage is FHIR is export {
  has Str $.id;
  has Code $.scale;
  has Period $.duration;
  has Extension @.extension;
  has Str $.description;
  has Real $.temperature;
  has Extension @.modifierExtension;
}

class BiologicallyDerivedProduct_Collection is FHIR is export {
  has Str $.id;
  has Reference $.source;
  has Extension @.extension;
  has Reference $.collector;
  has ChoiceField $.collected where DateTime|Period;
  has Extension @.modifierExtension;
}

class BiologicallyDerivedProduct_Processing is FHIR is export {
  has Str $.id;
  has ChoiceField $.time where DateTime|Period;
  has Reference $.additive;
  has Extension @.extension;
  has CodeableConcept $.procedure;
  has Str $.description;
  has Extension @.modifierExtension;
}

class BiologicallyDerivedProduct_Manipulation is FHIR is export {
  has Str $.id;
  has ChoiceField $.time where DateTime|Period;
  has Extension @.extension;
  has Str $.description;
  has Extension @.modifierExtension;
}

class BiologicallyDerivedProduct is DomainResource is export {
  method resourceType(--> 'BiologicallyDerivedProduct') {}
  has Code $.status;
  has Reference @.parent;
  has Reference @.request;
  has Int $.quantity;
  has Identifier @.identifier;
  has CodeableConcept $.productCode;
  has Code $.productCategory;
  has BiologicallyDerivedProduct_Storage @.storage;
  has BiologicallyDerivedProduct_Collection $.collection;
  has BiologicallyDerivedProduct_Processing @.processing;
  has BiologicallyDerivedProduct_Manipulation $.manipulation;
}