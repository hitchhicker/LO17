#!/usr/bin/perl -w

while(<>)
{
    if(/(\d+) (.*)/)
    {
        $tmp = log10($1) + 1;
        print "$tmp $2\n";
    }
}
sub log10 {
  my $n = shift;
  return log($n)/log(10);
}