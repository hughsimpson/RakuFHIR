#!/usr/bin/env perl6
use v6.d;

use UUID;

use FHIR::Base;
use FHIR::DomainModel;
use FHIR::JsonSerdes;

unit module Store;

role AbstractStore is export {
    method insert(Resource:D $rsc --> Nil) {
        ...
    }
    method update(Resource:D $rsc --> Nil) {
        ...
    }
    method search(&filter --> Array[::Resource]) {
        ...
    }
    method read(Str $tpe, Str $id --> Resource) {
        ...
    }
    method patch(Str $tpe, Str $id, &patch --> Nil) {
        ...
    }
}

class InMemory does AbstractStore is export {
    has Resource %!resources;
    method insert(Resource:D $rsc --> Str) {
        my $id = ~UUID.new;
        my $rsc2 = $rsc.clone: :$id;
        %!resources{"{$rsc2.resourceType}/$id"} = $rsc2;
        $id;
    }
    method update(Resource:D $rsc --> Nil) {
        my $el = %!resources{[$rsc.WHAT, $rsc.id]};
        $el.defined ?? {$el := $rsc} !! die "cannot update missing resource";
    }
    method search(&filter --> Array[::Resource]) {
        %!resources.values.grep(&filter)
    }
    method read(Str $tpe, Str $id --> Resource) {
        %!resources{"$tpe/$id"}
    }
    method patch(Str $tpe, Str $id, &patch --> Nil) {
        my $el = %!resources{"$tpe/$id"};
        $el.defined ?? { $el := patch $el } !! die "cannot update missing resource";
    }
}
