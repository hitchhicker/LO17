#!/usr/bin/perl -w
use XML::XPath;
use XML::XPath::XMLParser;
use warnings;
# @lignes = `cat res.xml`;
%dates;


my $xp = XML::XPath->new(filename => 'res.xml');

my $nodeset = $xp->find('/corpus/bulletin/date'); # find all paragraphs

foreach my $node ($nodeset->get_nodelist) {
	$dates{$node->string_value}=
	$node->find('preceding-sibling::fichier');
}

while(($cle,$fich)=each(%dates)){
	print $cle.' '.$fich."\n";
}
