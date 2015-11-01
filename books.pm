#!/usr/bin/perl

package books;


use Exporter;

our @ISA = 'Exporter';
our @EXPORT = qw(%bibletrans @books_hun @books_en @books_web %book_map);


%bibletrans = (

"1Móz",  "Genesis",
"2Móz",  "Exodus",
"3Móz",  "Leviticus",
"4Móz",  "Numbers",
"5Móz",  "Deuteronomy",
"Józs",  "Joshua",
"Bír",   "Judges",
"Ruth",  "Ruth",
"1Sám",  "1 Samuel",
"2Sám",  "2 Samuel",
"1Kir",  "1 Kings",
"2Kir",  "2 Kings",
"1Krón", "1 Chronicles",       
"2Krón", "2 Chronicles",       
"Ezsd",  "Ezra",
"Neh",   "Nehemiah",
"Eszt",  "Esther",
"Jób",   "Job",
"Zsolt", "Psalms",             
"Péld",  "Proverbs",
"Préd",  "Ecclesiastes",
"Énekek","Song of Solomon",    
"Ézs",   "Isaiah",
"Jer",   "Jeremiah",
"Jsir",  "Lamentations",
"Ez",    "Ezekiel",
"Dán",   "Daniel",
"Hós",   "Hosea",
"Jóel",  "Joel",
"Ám",    "Amos",
"Abd",   "Obadiah",
"Jón",   "Jonah",
"Mik",   "Micah",
"Náh",   "Nahum",
"Hab",   "Habakkuk",
"Zof",   "Zephaniah",
"Hag",   "Haggai",
"Zak",   "Zechariah",
"Mal",   "Malachi",
         

"Mt",   "Matthew",         
"Mk",   "Mark",            
"Lk",   "Luke",            
"Jn",   "John",            
"ApCsel", "Acts",   
"Róm",  "Romans",          
"1Kor", "1 Corinthians",   
"2Kor", "2 Corinthians",   
"Gal",  "Galatians",       
"Ef",   "Ephesians",       
"Fil",  "Philippians",     
"Kol",  "Colossians",      
"1Thessz","1 Thessalonians",   
"2Thessz","2 Thessalonians",
"1Tim", "1 Timothy",       
"2Tim", "2 Timothy",       
"Tit",  "Titus",           
"Filem","Philemon",            
"Zsid", "Hebrews",         
"Jak",  "James",           
"1Pt",  "1 Peter",         
"2Pt",  "2 Peter",         
"1Jn",  "1 John",          
"2Jn",  "2 John",          
"3Jn",  "3 John",          
"Jud",  "Jude",            
"Jel",  "Revelation"

);

@books_hun = ("1Móz", "2Móz", "3Móz", "4Móz", "5Móz", "Józs", "Bír", "Ruth", "1Sám", "2Sám", "1Kir", "2Kir", "1Krón", "2Krón", "Ezsd", "Neh", "Eszt", "Jób", "Zsolt", "Péld", "Préd", "Énekek", "Ézs", "Jer", "Jsir", "Ez", "Dán", "Hós", "Jóel", "Ám", "Abd", "Jón", "Mik", "Náh", "Hab", "Zof", "Hag", "Zak", "Mal",   "Mt", "Mk", "Lk", "Jn", "ApCsel", "Róm", "1Kor", "2Kor", "Gal", "Ef", "Fil", "Kol", "1Thessz", "2Thessz", "1Tim", "2Tim", "Tit", "Filem", "Zsid", "Jak", "1Pt", "2Pt", "1Jn", "2Jn", "3Jn", "Jud", "Jel");

@books_en = ( 
          "Gen", "Exod", "Lev", "Num", "Deut", "Josh", "Judg", "Ruth", "1Sam", "2Sam", "1Kgs", "2Kgs", "1Chr", "2Chr", "Ezra", "Neh", "Esth", "Job", "Ps", "Prov", "Eccl", "Song", "Isa", "Jer", "Lam", "Ezek", "Dan", "Hos", "Joel", "Amos", "Obad", "Jonah", "Mic", "Nah", "Hab", "Zeph", "Hag", "Zech", "Mal", "Matt", "Mark", "Luke", "John", "Acts", "Rom", "1Cor", "2Cor", "Gal", "Eph", "Phil", "Col", "1Thess", "2Thess", "1Tim", "2Tim", "Titus", "Phlm", "Heb", "Jas", "1Pet", "2Pet", "1John", "2John", "3John", "Jude", "Rev");

@books_web = (
"GEN","EXO","LEV","NUM","DEU","JOS","JDG","RUT","1SA","2SA","1KI","2KI","1CH","2CH","EZR","NEH","EST","JOB","PSA","PRO","ECC","SNG","ISA","JER","LAM","EZK","DAN","HOS","JOL","AMO","OBA","JON","MIC","NAM","HAB","ZEP","HAG","ZEC","MAL","MAT","MRK","LUK","JHN","ACT","ROM","1CO","2CO","GAL","EPH","PHP","COL","1TH","2TH","1TI","2TI","TIT","PHM","HEB","JAS","1PE","2PE","1JN","2JN","3JN","JUD","REV");

%book_map = ();

$i = 0;

sub booksInit{
	foreach $book (@books_web){
		$book_map{$book} = $books_en[$i];
		$i++;
		}
}    

return 1;

