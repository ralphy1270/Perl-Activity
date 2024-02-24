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

 

#$/="<\/STORY>";

 tr/dogs/cat/;

while (<INFILE>){

# Fixed content found within <p></p> tags. 
	while(/<p(\s+[^>]*?)?>([^\000]*?)<\/p>/){
	$ptag=$2; #content to be fix. 
	$ptag=~s/<\/?b(\s+[^>]*?)?>//g; #remove b tags found within p tags
	s/<p(\s+[^>]*?)?>([^\000]*?)<\/p>/<p_temp>$ptag<\/p_temp>/; #rename p tag to p_temp to not encountered infinite loop
	}
	s/(<\/?p)_temp>/$1>/g; #rename back to <p></p> tag
	 
	#removing multiple tags in oneline.
	#s/<\/?(b|i)(\s+[^>]*?)?>//g;
	 
	#removing attributes in multiple tags
	#s/(<\/?(b|i))(\s+[^>]*?)?>/$1>/g;
 
  print OUTFILE $_;

}

close(INFILE);

close(OUTFILE);