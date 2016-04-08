#!/usr/bin/perl -w

# nombre de ficiher
$N = 326;

while (<>) {
    if (/(\d+) .*/)
    {
        $tmp = log10($N / $1);
        s/$1/$tmp/;
        print;
    }
}
sub log10 {
  my $n = shift;
  return log($n)/log(10);
}