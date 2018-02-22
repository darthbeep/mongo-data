#!/usr/bin/env perl
use strict;
use warnings;
use MongoDB;
use 5.010;

my $client = MongoDB->connect('homer.stuy.edu');
my $db = $client->get_database('test');
my $coll = $db->get_collection('restaurants');
my $use = $coll->find({'borough'=> 'Brooklyn'});
#my $use = $

#print $use;
my @arr = $use->all;
my @first = $use->all;
my @test = keys $arr[0];
#for my $key (@test) {
#    print $arr[0]->{$key} . "\n";
#    display_object($arr[0]->{$key}, 0);
#}

my $num = 0;
print $num;

#print $arr[0]->{'borough'}."\n";

#print keys $use;

#while (my $curr = $use->next) {
#    print keys $curr->{'address'};
#}

sub display_object {
    my (@object_take, $steps) = @_;
    my @object = $object_take[0][0];
    print keys $object[0];
    #print "idk any more $steps $object \n";
    #my @object_start = "@{ $object_take }";
    #print $object_start;
    #my @object_again = $object_start[0];
    #print keys @object_again;
    #my $object = $object[0];
    #print keys $object2;
    #print "\n---\n";
    #print keys @object;
    #print "\n";
    #if (not ref(@object_again)) {
        #print "$steps: $object \n";
    #    return;
    #}
    #my @keys = keys @object;
    #print @keys;
    #for my $key (@keys) {
    #    display_object($object->{$key}, $steps+1);
    #}

}



display_object(\@arr, 0);
print "hi\n";
