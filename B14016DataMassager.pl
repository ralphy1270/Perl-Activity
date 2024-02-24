#!/xce/bin/perl

# ===================================================================

#   Licensed Materials - Property of LexisNexis.

#   (C) Copyright 2014 - 2021 LexisNexis, a division of Reed Elsevier Inc.

#   All rights reserved.

#   =======================================================================

#     Filename : B14016DataMassager.pl

#     Product  : For Training use only

#     Applic   : B14016 (TIMEED)

#     Author   : Lou Ismael Montenegro (SPi Global)

#     Date     : May 06, 2014

#

#     USAGE:  B14016DataMassager.pl <inputfile> <outputfile>

#     where inputfile is the name of your data file while the

#     outputfile MASSAGEDDATA.DAT

#

# ===================================================================

 

$infile = $ARGV[0];

$outfile = $ARGV[1];

$tempfile = $outfile.TMP;

 

$errorlog = "./";

$encoding = "utf-8";

 

open(INFILE,"<:encoding($encoding)","$infile") || die "cannot open input file";

open(OUTFILE,">:encoding($encoding)","$outfile") || die "cannot open output file";

 

$/="<\/STORY>";

 

while (<INFILE>){
 #s/<EDITION number="([^"]+)"[^>]*>/\<lnv:Edition\>\<lnvxe:desc\>Edition$1\<\/lnvxe:desc\>\<\/lnv:Edition\>/g;
 #s/<EDITION number="([^"]+)"[^>]*>/\<Edition\>Edition$1\<\/Edition\>/;

#Answers: Activity 1
 #s/.*(<EDITION\s+number="2"\s+type="NS"\s+date="2020-12-04"\s+pnbdate="4 December 2020"\s+created="20201204 1345"\s+year="2020"\s+month="December"\s+dayofweek="Friday"\s*\/>).*/$1/s;
 #s/<EDITION number="([^"]+)"[^>]*>/<lnv:Edition>\n  <lnvxe:desc>Edition$1<\/lnvxe:desc>\n<\/lnv:Edition>/g;


#Answers: Activity 2
#s/(<book id="[^"]+">\s*<author>[^<]+<\/author>\s*<title>[^<]+<\/title>\s*<genre>[^<]+<\/genre>\s*<price>)([^<]+)(<\/price>)/$1\$$2$3/g;
#s/(<book id="[^"]+">\s*<author>[^<]+<\/author>\s*<title>[^<]+<\/title>\s*<genre>)([^<]+)(<\/genre>\s*<price>)([^<]+)(<\/price>)/$1<li>$2<\/li>$3$4$5/g;
#s/(<publish_date>)(\d{4})-(\d{2})-(\d{2})(<\/publish_date>)/$1$2\/$3\/$4$5/g;
#s/(<book id="[^"]+">)(.*?)(<author>.*?<\/author>)(.*?)(<title>.*?<\/title>)(.*?)(<genre>.*?<\/publish_date>)(.*?)(<description>.*?<\/description>)(.*?)(<\/book>)/$1$2$5$4$9$6$7$8$3$10$11/gs; 
#s/(<title>)(.*?)(<\/title>)(.*?)<description>(.*?)<\/description>/$1$2,\ $5$3/gs;

#Answer: Activity 3
#s/.*(<pub_copyright\>Akire Tecnologia Da Informacao Ltda<\/pub_copyright>).*/$1/s;
#s/<pub_copyright>(.*?)<\/pub_copyright>/<lnv:COPYRIGHT>\n<lnv:PUB-COPYRIGHT>Copyright\n         <lnvxe:copyright.year year="2023">2023<\/lnvxe:copyright.year>\n         <lnvxe:copyright.holder>$1\n         <\/lnvxe:copyright.holder>, todos os direitos reservados<\/lnv:PUB-COPYRIGHT>\n<\/lnv:COPYRIGHT>\n<lnv:SPEC-LIB>#03FIN# #REPL# <\/lnv:SPEC-LIB>/g;
s/.*(<spec_lib value="([\s\S#]*?)"\/>([\s\S]*?)<pub_copyright\>Akire Tecnologia Da Informacao Ltda<\/pub_copyright>).*/$1/s;
s/<spec_lib value="([\s\S#]*?)"\/>([\s\S]*?)<pub_copyright>(.*?)<\/pub_copyright>/<lnv:COPYRIGHT>\n<lnv:PUB-COPYRIGHT>Copyright\n         <lnvxe:copyright.year year="2023">2023<\/lnvxe:copyright.year>\n         <lnvxe:copyright.holder>$3\n         <\/lnvxe:copyright.holder>, todos os direitos reservados<\/lnv:PUB-COPYRIGHT>\n<\/lnv:COPYRIGHT>\n<lnv:SPEC-LIB>$1 #REPL# <\/lnv:SPEC-LIB>/gs;




  print OUTFILE $_;

}

close(INFILE);

close(OUTFILE);