#!/usr/bin/perl
$numFichier=0;
$numTitre=0;
$numRubrique=0;
$numNumRub=0;
$numDate=0;
$numTexte=0;
$numUrl=0;
$numLegend=0;
$numContact=0;
$numBulletin=0;

while(<>){
	if(/<bulletin>/){
		$numBulletin++;
	}
	if(/<fichier>.*<\/fichier>/){
		$numFichier++;
	}
	if(/<titre>.*<\/titre>/){
		$numTitre++;
	}
	if(/<rubrique>.*<\/rubrique>/){
		$numRubrique++;
	}
	if(/<numero>.*<\/numero>/){
		$numNumRub++;
	}
	if(/<date>.*<\/date>/){
		$numDate++;
	}
	if(/<texte>.*<\/texte>/){
		$numTexte++;
	}
	if(/<urlImage>.*<\/urlImage>/){
		$numUrl++;
	}
	if(/<legendeImage>.*<\/legendeImage>/){
		$numLegend++;
	}
	if(/<contact>.*<\/contact>/){
		$numContact++;
	}
}

print("nombre de bulletins : $numBulletin\n");
print("nombre de fichiers : $numFichier\n");
print("nombre de rubriques : $numRubrique\n");
print("nombre de numéros de rubrique : $numNumRub\n");
print("nombre de titres : $numTitre\n");
print("nombre de dates : $numDate\n");
print("nombre de textes : $numTexte\n");
print("nombre de Url d'image : $numUrl\n");
print("nombre de legendes d'image : $numLegend\n");
print("nombre de contacts : $numContact\n");
