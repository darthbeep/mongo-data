#!/usr/bin/env perl
use strict;
use warnings;
use MongoDB;
use 5.010;
use JSON; # imports encode_json, decode_json, to_json and from_json.

#Read the file:
my $filename = "astroid.json";
open (my $fh, '<:encoding(UTF-8)', $filename) or die "couldn't find file";
my $alljson = "";
while (my $row = <$fh>) {
    chomp $row;
    $alljson.=$row;
}
my @data = decode_json($alljson);
#print "$data\n";

#connect to the database
my $client = MongoDB->connect('homer.stuy.edu');
my $db = $client->get_database('test');
my $coll = $db->get_collection('astroids');

#clears the database every time you run the script.
$coll->drop;

#This does not work due to to many options. Use the loop below instead.
#my $result = $coll->insert_many(\@data);
#This works
my $id = 0;
foreach my $part ($data[0]) { #The only issue with this is the _ids are a bit weird
    #print %part{'i_deg'}; Hypothetically this should work. In practice it does not.
    my $result = $coll->insert_one($part);
    $id++;
    print "$part, $result\n";
}

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
