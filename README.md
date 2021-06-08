# RakuFHIR
A FHIR (v4.0.1) domain model and client implementation for Raku (née Perl6), with json serdes

Immature, unperformant and and experimental.

Serialization is currently intended to be done via the coercion API, though this might revert

A usage might be something like:
```
# Import
use FHIR::Base;
use FHIR::DomainModel;
use FHIR::JsonSerdes;
use FHIR::Client;

# Create a client
my SyncFHIRClient $cli .= new: :fhir-server<http://localhost:8082>;

# Create an observation resource
my Observation $obs .= new: :status<final>, :code(CodeableConcept.new: :coding([Coding.new: :code<abc>, :system<http://foo.bar/baz>]));

# Write observation to remote fhir server
my Str $loc = $cli.create($obs);

# Retrieve observation
my Observation $r = $cli.read: Observation, $loc;
```