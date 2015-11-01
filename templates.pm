#!/usr/bin/perl

package templates;


use Exporter;

our @ISA = 'Exporter';
our @EXPORT = qw($tpl_osis $tpl_book $tpl_chapter $tpl_section $tpl_verse $tpl_note);


$tpl_osis = <<END;
<?xml version="1.0" encoding="UTF-8"?>
<osis
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns="http://www.bibletechnologies.net/2003/OSIS/namespace"
        xmlns:osis="http://www.bibletechnologies.net/2003/OSIS/namespace"
        xsi:schemaLocation="http://www.bibletechnologies.net/2003/OSIS/namespace http://www.bibletechnologies.net/osisCore.2.1.1.xsd">

<osisText osisIDWork="HunUjR" osisRefWork="defaultReferenceScheme" xml:lang="hu"  canonical="true">

        <header>
                <work osisWork="HunUj">
                        <title>Magyar Revideált Újfordítású</title>
                        <identifier type="OSIS">Bible.HunUj</identifier>
                        <refSystem>Bible.German</refSystem>
                </work>
                <work osisWork="defaultReferenceScheme">
                        <refSystem>Bible.German</refSystem>
                </work>
        </header>

<div type="bookGroup">
    <title>Ószövetség</title>
__oszov__
</div> <!-- end book group //-->
<div type="bookGroup">
        <title>Újszövetség</title>
__ujszov__
</div>  <!-- end book group //-->       

</osisText>
</osis>
END

$tpl_book =<<END;
<div osisID="__bookid__" type="book">
__bookcontent__
</div> <!-- end book __bookid__ //-->
END

$tpl_chapter=<<END;
<chapter osisID="__chapterid__">
__chaptercontent__
</chapter> 
END

$tpl_section =<<END;
<div type="section"><title subType="x-preverse">__sectiontitle__</title>
__sectioncontent__
</div> <!-- end section //-->
END

$tpl_verse =<<END;
<verse osisID="__verseid__">__versecontent__</verse>
END

=POD
$tpl_note =<<END;
<note osisID="__verseid__!crossReference.a" n="__counter__" osisRef="__verseid__" type="crossReference">
                __references__
              </note>
END

$tpl_reference =<<END;
<reference osisRef="__verseid__">__verseidhun__</reference>
END
=cut

return 1;

