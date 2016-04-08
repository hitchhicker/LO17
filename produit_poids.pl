#!/usr/bin/perl -w
use Data::Dumper qw(Dumper);
use warnings;
# use strict;
@ligne_df = `cat TD_IDF/idf.txt`;
my %map_df;

foreach $ligne (@ligne_df)
{
    if ($ligne =~ /([\d\.]+) (.*)/)
    {
        $map_df{"$2"} = $1;
    }
}
# print Dumper \%map_df;
@ligne_tf = `cat TD_IDF/log_tf.txt`;

foreach $ligne (@ligne_tf)
{
    if ($ligne =~ /([\d.]+) (.*)\t/)
    {
        # print $ligne;
        # print "$2\n";
        $tmp = $1 * $map_df{$2};
        $ligne=~s/$1/$tmp/;
        print $ligne;
    }
    # print $ligne;
}   
