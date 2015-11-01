#!/usr/bin/perl
use lib('.');
use books;
use templates;


books::booksInit();

#we work from a fixed place
chdir 'abibliamindenkie.hu'  or die "No bible dump found";

#init our variables
$i = 0;
$bible=$tpl_osis; #this will contain the bible text on osis format
%bibtle_text=(); #store the two testaments
$test = "oszov"; #we start with the old testament

foreach $book (@books_web){ #let's iterate the books from the web list
    print "$book ";
    if($book eq "MAT"){  #with Matthew starts the new testament
        $test = "ujszov";
        }
    open $fh, "uj/$book/index.html"; #this is the book TOC
    my $bookcontent="";
    my $bookid=$books_en[$i];
    while(<$fh>){
        if(/href=\"\/uj\/$book\/(\d+)\/\"/){ #we found a chapter, lets process it
            $chapter = $1;
            my $chapterid = "${bookid}.$chapter";
            my $chaptercontent = "";
            #print "$chapterid found\n";
            #/*read chapter content*/
            open $ch, "uj/$book/$chapter/index.html";
            my $versecontent = "";
            my $inverse = 0;
            my $insection = 0;
            my $prev_inverse = 0;
            my $refid = ord('a');
            my $endnoteid = 1;
            while(<$ch>){
                #detect if we are in section / verse
                if(/>([^<]+)<\/h3>/){
                    $section_title = $1;
                    $inverse = 0;
                    if($insection eq "1"){
                            $chaptercontent .= "\n<\/div> <!-- end section //-->\n";
                        }
                    $chaptercontent .= "<div type=\"section\"><title subType=\"x-preverse\">$section_title</title>\n"; 
                    $insection = 1;
                    }
                if(/<\/p>/){
                    $inverse = 0;
                    }
                if(/verse/ && /id=\"v(\d+)\"/){
                    $inverse = $1;
                    }
                
                if($inverse ne $prev_inverse && $prev_inverse ne "0"){ #process each verse
                    #$versecontent =~ s/<span>.*<\/span>//g;
                    #$versecontent =~ s/<[^>]+>//g;
                    $versecontent =~ s/<a href[^>]+>\d+<\/a>//;
                    $versecontent =~ s/<\!\-\- Bookmark[^\-]+\-\->//;
                    
                    $versecontent =~ s/<\/{0,1}p[^>]*>//g;
                    $versecontent =~ s/\s+/ /g;
                    $versecontent =~ s/^\s+|\s+$//g;
                    $versecontent =~ s/<\/{0,1}span[^>]*>//g;
                    $versecontent =~ s/<a href=\"\/uj\/([A-Za-z0-9]+)\/(\d+)\/(\d+)\/#\d*\">([^<]+)<\/a>/\xA<reference osisRef=\"$book_map{$1}.$2.$3\">$4<\/reference>/g;
                    $versecontent =~ s/<a href=\"\/uj\/([A-Za-z0-9]+)\/(\d+)\/#\d*\">([^<]+)<\/a>/\n<reference osisRef=\"$book_map{$1}.$2\">$3<\/reference>/g;
                    #$refid_c = chr($refid);
                    $refid_c = $refid - ord('a') + 1;
                    $versecontent =~ s/<reference/\n<note osisID="$chapterid.$prev_inverse!crossReference.$refid_c" n="$refid_c" osisRef="$chapterid.$prev_inverse" type="crossReference"><reference/;
                    $versecontent =~ s/<\/reference>\s*$/<\/reference><\/note>/;
                    
                    $versecontent =~ s/<a href="#" class=\"footnote-switch\">\*<\/a>([^<]+)/"<note type=\"x-footnote\" n=\"".$endnoteid++."\">$1<\/note>"/ge;
                    
                    if($versecontent =~ /reference/){
                        $refid++;
                        }
                    #if($versecontent =~ /x-footnote/){
                    #    $endnoteid++;
                     #   }
                        
                    $versecontent =~ s/\s+;\s+/; /g;
                    my $verse_text = $tpl_verse;
                    $verse_text =~ s/__verseid__/$chapterid.$prev_inverse/;
                    $verse_text =~ s/__versecontent__/$versecontent/;
                    $verse_text =~ s/__note__/$notecontent/;
                    $chaptercontent .= $verse_text;
                    $versecontent = "";
                    }
                #cleanup state
                if($inverse ne "0"){
                    s/[\r\n]+//g;
                    $versecontent .= $_;
                    }
                $prev_inverse = $inverse;
                }
            #cleanup section    
            if($insection eq "1"){
                        $chaptercontent .= "\n<\/div> <!-- end section //-->\n";
                        }
            close $ch;
            
            
            #/*parse chapter template*/
            my $chapter_text = $tpl_chapter;
            $chapter_text =~ s/__chapterid__/$chapterid/;
            $chapter_text =~ s/__chaptercontent__/$chaptercontent/;
            $bookcontent .= $chapter_text;
            }
        }
    my $book_text = $tpl_book;
    $book_text =~ s/__bookid__/$bookid/g;
    $book_text =~ s/__bookcontent__/$bookcontent/;
    #print $book_text;
    $bible_text{$test} .= $book_text;
    close $fh;
    $i++;
   #last if($i == 1);
    }
print "\n";    
$bible =~ s/__oszov__/$bible_text{oszov}/;
$bible =~ s/__ujszov__/$bible_text{ujszov}/;

open $bh, "> ../hunujr.osis.xml";
print $bh $bible;
close $bh;
