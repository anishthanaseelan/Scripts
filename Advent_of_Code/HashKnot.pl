use strict;
#our $File = CopyFile("KnotHash.fl");
#our @Lengths = (3, 4, 1, 5);
our @Lengths = (197,97,204,108,1,29,5,71,0,50,2,255,248,78,254,63);

#our @List = (0, 1, 2, 3, 4);
our @List = ();
for ( my $i = 0 ; $i < 256 ; $i++ ){
	$List[$i] = $i;
}
our $pointer = 0;
our $SkipLength = 0;
our $Hash = Knot();

print "HASH is $Hash \n";
sub Knot(){
	print "<LIST> @List \n";
	print "<LENGTH> @Lengths \n";
	foreach my $Length (@Lengths){
		print "Current Length $Length Pointer $pointer\n";
		#Extract elements
		my @Temp = ();
		my $i = 0;
		for ( $i = 0 ; $i < $Length ; $i++){
			if ( $pointer+$i < scalar @List ){
				$Temp[$i] = $List[$pointer+$i];	
			}else{
				$Temp[$i] = $List[($pointer+$i) - (scalar @List)];
			}
		}
		print "@Temp \n";

		#Reverse Element
		@Temp = reverse @Temp;
		print "Reverase @Temp \n";
		#Set Elelment
		for ( $i = 0 ; $i < $Length ; $i++){
			if ( $pointer+$i < scalar @List ){
				$List[$pointer+$i] = $Temp[$i] ;	
			}else{
				$List[($pointer+$i) - (scalar @List)] = $Temp[$i] ;
			}
		}
		print "Set List @List \n";
		#Set pointer
		if ( $pointer+$Length+$SkipLength < scalar @List ){
			$pointer = $pointer+$Length+$SkipLength;	
		}else{
			$pointer = (($pointer+$Length+$SkipLength) % (scalar @List));
			#$pointer = ($pointer+$Length+$SkipLength) - (scalar @List);
		}

		print "New Pointer  $pointer\n";
		#Increment SkipLength
		$SkipLength++;

	}
	#Calculate Hash
	return( $List[0] * $List[1]);
}

sub CopyFile()
{
   my $File = shift;
   my @File = ();
   if ( open ( FILE , "<$File" ) )
   {
      @File = <FILE>;
      close ( FILE );
   }
   else
   {
      die ("<ERROR>unable to open $File\n");
   }
   return ( \@File );
}