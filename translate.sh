#for file in splitted/*;
#do trans file://${file} | tee "./split-translations/${file}";
#
#done
trans file://chinese-lines.txt | tee "./chinese-lines-english.txt"
