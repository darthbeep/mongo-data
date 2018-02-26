#!/usr/bin/env perl

#So, here's the comment explaining everything. Same dataset as the python one.
#But what you really want to know is the import mechanism
#Read a file line by line, perl style, then jsonified the whole thing
#Because it turned into an array, the array with import many
#For some reason import one didn't work, still WIP
#Only issue is it's hard to convert the results into something readable, fix is WIP

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
my $db = $client->get_database('lastMinute');
my $coll = $db->get_collection('astroids');

#clears the database every time you run the script.
$coll->drop;

#This works
my $result = $coll->insert_many($data[0]);
#This does not work in its current form. WIP.
my $id = 0;
#foreach my $part ($data[0]) { #The only issue with this is the _ids are a bit weird
#    #print %part{'i_deg'}; Hypothetically this should work. In practice it does not.
#    my $result = $coll->insert_one($part);
#    $id++;
#    print "$part, $result\n";
#

#Here are the find functions
#Because this is technecally my project I'm only including find functions I deem interesting
my $designation = $coll->find({'designation'=>qr/2015/i}); #Find everything with a designation including 2015
my @darr = $designation->all;
print $darr[0]->{'designation'};


print "\n";

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
