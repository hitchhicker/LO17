#!/usr/bin/perl -w
@list_fichiers = `ls BULLETINS `;
$flag = 0;
$flagIm = 0;

print("<corpus>\n");
foreach $fichier (@list_fichiers){
	@lignes = `./convert.pl BULLETINS/$fichier`;
	foreach $ligne (@lignes)
	{
		if($ligne =~ /<p><span class="style32">BE France (\d+).*?<span class="style42">.*?(\d{1,2}\/\d{1,2}\/\d{2,4})<\/span><\/p>/){
			$numRubrique = $1;
			$date = $2;
		}
		if($ligne=~ /<p class="style96"><span class="style42">(.*)?<br>.*?<span class="style17">(.*)<\/span><\/p>/){
			$rubrique=$1;
			$titre=$2;
		}
		if ($flag==0 && $ligne=~ /<p class="style96"><span class="style95">(.*)<\/span><\/p>/)
		{
			$text = $1;
			next;
			
		}
		elsif ($flag==0 && $ligne=~ /<p class="style96"><span class="style95">(.*)/)
		{
			$text = $1;
			$flag = 1;
			next;
		}
		if ($flag==1)
		{
			if ($ligne=~ /(.*)<\/span><\/p>/)
			{
				$text.=$1;
				$flag = 0;
			} 
			else 
			{
				$text.=$ligne;
				chop($text);
			}
		}
		if($ligne=~ /<p class="style44"><span class="style85">(.*)<\/span><\/p>/){

			$contact=$1;
		}
		if($ligne=~ /<div style="text-align: center"><.*="http:\/\/(.*\.jpg)/){
			$url = $1;
	 		$images{"$url"}=undef;
		}
		if($flagIm==0 && $ligne=~ /<span class="style21"><strong>(.*)<\/strong><br \/><\/span>/){
			$images{"$url"}=$1;
			next;
		}
		if($flagIm==0 && $ligne=~ /<span class="style21"><strong>(.*)<br \/>/){
			$images{"$url"}=$1;
			$flagIm=1;
			next;
		}
		if($flagIm==1){
			if($ligne=~/(.*)<\/strong><br \/><\/span>/){
				$images{"$url"}.=$1;
				$flagIm=0;
			} else {
				$images{"$url"}.=$1;
			}
		}
	 }
	 chop($fichier);

	 $text=~s/<span class="style88">.*?<\/span>//g;
	 $text=~s/<span class="style21">.*?<\/span>//g;
	 $text=~s/<.*?>/ /g;
	 $contact=~s/<.*?>//g;


	print("<bulletin>\n");
	print("<fichier>$fichier</fichier>\n");
	print("<numero>$numRubrique</numero>\n");
	print("<date>$date</date>\n");
	print("<rubrique>$rubrique</rubrique>\n");
	print("<titre>$titre</titre>\n");
	print("<texte>$text</texte>\n");
	print("<images>\n");
	while(($urlIm,$legendIm) = each(%images)){
		print("<image>\n");
		print("<urlImage>$urlIm</urlImage>\n");
		if($legendIm){
			print("<legendeImage>$legendIm</legendeImage>\n");
		}
		print("</image>\n");
		delete $images{"$urlIm"};
	}
	print("</images>\n");
	print("<contact>$contact</contact>\n");
	print("</bulletin>\n");
}
print("</corpus>\n");
