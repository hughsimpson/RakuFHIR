#!/usr/bin/env perl6
use v6.d;

use Red:api<2>;
use UUID;

use FHIR::Base;
use FHIR::DomainModel;
use FHIR::JsonSerdes;

unit module Store;

role AbstractStore is export {
    method insert(Resource:D $rsc --> Str) {
        ...
    }
    method update(Resource:D $rsc --> OperationOutcome) {
        ...
    }
    method delete(Str $tpe, Str $id --> Nil) {
        ...
    }
    method search(&filter --> Array[::Resource]) {
        ...
    }
    method read(Str $tpe, Str $id --> Resource) {
        ...
    }
    method vread(Str $tpe, Str $id, Int $vid --> Resource) {
        ...
    }
    method patch(Str $tpe, Str $id, &patch --> Nil) {
        ...
    }
}

class InMemory does AbstractStore is export {
    has %!resources;
    method insert(Resource:D $rsc --> Str) {
        my $id = ~UUID.new;
        my $rsc2 = $rsc.clone: :$id;
        %!resources{"{$rsc2.resourceType}/$id"} = [$rsc2];
        $id;
    }
    method update(Resource:D $rsc --> OperationOutcome) {
        my OperationOutcome_Issue @issues;
        my Int $status = 202;
        my $el := %!resources{"{$rsc.resourceType}/{$rsc.id}"};
        $status = 422 and push @issues, OperationOutcome_Issue.new(
                :code<not-found>, :severity<error>, :diagnostics{"Cannot find resource {$rsc.id} to update"}
                ) unless $el.defined;
        $el.push: $rsc;
        push @issues, OperationOutcome_Issue.new:
                :code<informational>, :severity<information>, :diagnostics("New version id is {$el - 1}");
        $el.defined ?? OperationOutcome.new(:issue(@issues)) !! die "cannot update missing resource";
    }
    method delete(Str $tpe, Str $id --> Nil) {
        %!resources{"$tpe/$id"}:delete
    }
    method search(&filter --> Array[::Resource]) {
        %!resources.values.grep(&filter)
    }
    method read(Str $tpe, Str $id --> Resource) {
        my $el := %!resources{"$tpe/$id"};
        $el.defined ?? $el[*-1] !! ::("DomainModel::$tpe")
    }
    method vread(Str $tpe, Str $id, Int $vid --> Resource) {
        %!resources{"$tpe/$id"}[$vid] // ::("DomainModel::$tpe")
    }
    method patch(Str $tpe, Str $id, &patch --> Nil) {
        my $el := %!resources{"$tpe/$id"};
        $el.defined ?? { $el.push: patch $el[*-1] } !! die "cannot update missing resource";
    }
}

model Rsc is rw is table('Rsc') {
    has Str         $.id        is column{ :id, :unique };
    has Int         $.vid       is column{ :id };
    has Resource    $.rsc       is column{
        :type<string>,
        :deflate{ &jencode },
        :inflate{ &jdecode }
    };
}

class RedStore does AbstractStore is export {

    my $*RED-DB = database "SQLite";

    Rsc.^create-table: :if-not-exists;

    method insert(Resource:D $rsc --> Str) {
        my $id = ~UUID.new;
        Rsc.^create: :id("{$rsc.resourceType}/$id"), :vid(0), :rsc($rsc.clone: :$id);
        $id;
    }
    method update(Resource:D $rsc --> OperationOutcome) {
        my $tid := "{$rsc.resourceType}/{$rsc.id}";
        my OperationOutcome_Issue @issues;
        my $vid = Rsc.^load(:id($tid)).elems;
        push @issues, OperationOutcome_Issue.new(
                :code<not-found>, :severity<error>, :diagnostics{"Cannot find resource {$rsc.id} to update"}
                ) unless ?$vid;
        Rsc.^create: :id($tid), :$vid, :$rsc;
        push @issues, OperationOutcome_Issue.new:
                :code<informational>, :severity<information>, :diagnostics("New version id is $vid");
        $vid ?? OperationOutcome.new(:issue(@issues)) !! die "cannot update missing resource";
    }
    method delete(Str $tpe, Str $id --> Nil) {
#        Rsc.^load(:id("$tpe/$id"))».^delete;
    }
    method search(&filter --> Array[::Resource]) {
        # %!resources.values.grep(&filter)
        []
    }
    method read(Str $tpe, Str $id --> Resource) {
        my $tid := "$tpe/$id";
        my $el = try Rsc.^load(:id($tid)).sort(*.vid)[*-1];
        $el.defined ?? $el !! ::("DomainModel::$tpe")
    }
    method vread(Str $tpe, Str $id, Int $vid --> Resource) {
        Rsc.^load: :id("$tpe/$id"), :$vid;
    }
    method patch(Str $tpe, Str $id, &patch --> Nil) {
        my $tid := "$tpe/$id";
        my $rscs = Rsc.^load(:id($tid));
        my $vid = $rscs.elems;
        my $el = $rscs.sort(*.vid)[*-1];
        $el.defined ?? { Rsc.^create: :id($tid), :$vid, :rsc(patch $el); } !! die "cannot update missing resource";
    }
}
