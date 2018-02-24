#!/usr/bin/env perl
use strict;
use warnings;
use MongoDB;
use 5.010;
use JSON; # imports encode_json, decode_json, to_json and from_json.

# simple and fast interfaces (expect/generate UTF-8)

my $client = MongoDB->connect('homer.stuy.edu');
my $db = $client->get_database('test');
my $coll = $db->get_collection('astroids');
my $use = $coll->find();


while (my $object = $use->next) {
    my $json = encode_json($object);
    print "hi$json\n";
}
my @arr = $use->all;
my @arr0 = $arr[0];
my @first = $use->all;

my @test = keys $arr[0];

my $num = 0;


#Don't touch this function. It is a purgatory from which you can never return.
sub display_object {
    my ($object_take, $steps) = @_;


    if (not ref($object_take) eq "ARRAY" and not ref($object_take) eq "HASH") {
        print "$steps: $object_take\n";
        return;
    }
    print 'again: '. ref($object_take) . ",$object_take \n";
    my @object_start = "";
    if (ref($object_take) eq "HASH") {
        @object_start = %{ $object_take };
        print "keys:";
        for my $thing (@object_start) {
            display_object($thing, $steps+1);
        }
        return;
    }
    else {
        @object_start = @{ $object_take };
    }


    my @object = $object_start[0];
    print "\nkeys:\tand". ref($object[0]). "\n";
    print keys @object;
    my @keys;
    eval {
        @keys = keys $object[0];
    } or do {
        @keys = keys @object;
    };


    print "keys printed: @keys\n";
    for my $key (@keys) {
        my @send = $object[0]->{$key};
        eval {
            display_object(\@send, $steps+1);
            print "yeped\n";
        } or do {
            print "noped\n";
            display_object(@send, $steps+1);
        };

    }
}
