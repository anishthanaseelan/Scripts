use strict;
our @File = ();
CopyFile("jumpOffsetstext.txt");
findExit();

sub findExit(){
	my $Offsets = shift;
	my $jumps = 0;
	my $i = 0;
	my $lastinst = undef;

	while(1) {

			#print "Current Pointer $i -> ". $File[$i] . " \n";

			#Jump to the offset
			$i = $i + $File[$i];
			
			#print "Next Pointer $i -> ". $File[$i] . " \n";


			#Increment the last jump position
			if ( $jumps != undef){
				if ( $File[$lastinst] >= 3 ){
						$File[$lastinst]--;
					}else {
						$File[$lastinst]++;
					}
				 

			}

			#print " Current state of the skip inst @File  \n";

			#Set the lst jump pointer
			$lastinst = $i;
			
			#count jumps
			$jumps++;
			
			#Break if end of file
			last if ( $i >= scalar ( @File ));
			
			#Safty
			die (" Infinit loop") if ($jumps > 100000000) ;

		} 

		print "<TOTAL JUMPS > $jumps \n"
}

sub CopyFile()
{
   my $File = shift;
   @File = ();
   my $i = 0;
   if ( open ( FILE , "<$File" ) )
   {
      @File = <FILE>;
      close ( FILE );

      foreach my $line ( @File ){
      	chomp($File[$i]);
      	$i++;
      }
      print "@File \n";;
   }
   else
   {
      die ("<ERROR>unable to open $File\n");
   }
   return ( );
}