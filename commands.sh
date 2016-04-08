# calculer tf
cat res.xml |perl sans_chiffre.pl |perl segmente_TT.pl -f |sort -n|uniq -c |perl log_tf.pl > TD_IDF/log_tf.txt

# calculer df
cat res.xml |perl sans_chiffre.pl |perl segmente_TT.pl -f|sort -u |cut -d$'\t' -f1 |uniq -c |perl log_df.pl > TD_IDF/idf.txt

# nombre de ficiher 
ls BULLETINS|wc -l

# ponderation par log_tf * idf
perl produit_poids.pl > TD_IDF/tf_idf.txt

# supprimer les mots selon le stoplist
cat TD_IDF/stop_liste.txt | perl newcreeFiltre.pl > supp_stop_list.pl
cat res.xml | perl sans_chiffre.pl | perl supp_stop_list > res_restreint.xml

# generer la liste des successeurs
cat res_restreint.xml | perl segmente_TT.pl | sort -u | perl successeurs_P16 > TD_IDF/succ.txt

# generer le fichier de mot-lemme
filtronc_P16.pl -v TD_IDF/succ.txt TD_IDF/lemme.txt

# remplacer mots par les lemmes pour titres et textes
cat TD_IDF/stop_liste.txt | perl newcreeFiltre.pl > mots_to_lemmes.pl
cat res_restreint | perl mots_to_lemmes > res_lemme.xml