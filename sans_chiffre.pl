#!/usr/bin/perl
while (<>){
	if (/<texte>(.+)<\/texte>/ || /<titre>(.+)<\/titre>/) {
		while (/(\d+[.,]?\d*)/g) {
			s/$1//;
		}
		print;
	}
	else {
		print;
	}
}
