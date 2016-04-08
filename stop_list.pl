#!/usr/bin/perl


while(<>)
	{
		push(@data,$_);

	}

$c1 = percentile("15",\@data);

sub percentile {
    my ($p,$aref) = @_;
    my $percentile = int($p * $#{$aref}/100);
    return (sort @$aref)[$percentile];
}

@lignes = `cat TD_IDF/tf_idf.txt`;
foreach $ligne (@lignes)
{
    if ($ligne =~ /([\d.]+) (.*)\t/)
    {
        if($1<=$c1){
        	print $2,"\n";
        }
    }
}
# calculer moyenne
while (<>){
    if (/([\d.]+) (.*?)\s/)
    {
        if(!exists $mots{"$2"}){
            $mots{"$2"}=$1;
            $occ{"$2"}=1;
        } else {
            $mots{"$2"}+=$1;
            $occ{"$2"}++;
        }
    }
}

while(($cle,$val)=each(%mots)){
   $moy{"$cle"} = $val/$occ{"$cle"};
}

# calculer ecart type
@lignes = `cat TD_IDF/tf_idf.txt`;

foreach $ligne (@lignes){
    if (/([\d.]+) (.*?)\s/)
    {
        if(!exists $ET{"$2"}){
            $ET{"$2"}=($moy{"$2"}-$1)^2;
        } else {
            $ET{"$2"}+=($moy{"$2"}-$1)^2;
        }
    }
}
while(($cle,$val)=each(%ET)){
   print $moy{"$cle"}," ",sqrt($val/$occ{"$cle"})," ",$cle,"\n";
}
