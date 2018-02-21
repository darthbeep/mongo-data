#!/usr/bin/env perl
use strict;
use warnings;
use MongoDB;
use 5.010;

my $client = MongoDB->connect('homer.stuy.edu');
my $db = $client->get_database('test');
my $coll = $db->get_collection('restaurants');
my $use = $coll->find;
#my $use = $

print $use;

while (my $curr = $use->next) {
    print $curr->{'borough'} . "\n";
}


print "hi\n";
