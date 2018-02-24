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
#for my $key (@test) {
#    print $arr[0]->{$key} . "\n";
#    display_object($arr[0]->{$key}, 0);
#}

my $num = 0;
#print $num;

#print $arr[0]->{'borough'}."\n";

#print keys $use;

#while (my $curr = $use->next) {
#    print keys $curr->{'address'};
#}

sub display_object {
    my ($object_take, $steps) = @_;
    #print "recieved as" . ref($object_take) . "\n";
    #print ref($object_take) . "start\n";
    #print $steps;

    #print keys $object_start[0];

    if (not ref($object_take) eq "ARRAY" and not ref($object_take) eq "HASH") {
        print "$steps: $object_take\n";
        return;
        #print "idk";
    }
    print 'again: '. ref($object_take) . ",$object_take \n";
    my @object_start = "";#@{ $object_take };;
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
    #print "$object[0]\n";
    my @keys;# = keys $object;
    eval {
        @keys = keys $object[0];
    } or do {
        @keys = keys @object;
    };


    print "keys printed: @keys\n";
    for my $key (@keys) {
        my @send = $object[0]->{$key};
        #print "send: @send from $key as ". ref(@send) . "\n";
        #print ref(@send) . "and the ref, @send\n";
        eval {
            display_object(\@send, $steps+1);
            print "yeped\n";
        } or do {
            print "noped\n";
            display_object(@send, $steps+1);
        };

    }
}


#display_object(\@arr0, 0);
#print "hi\n";
