use strict;
my $File = CopyFile("jumpOffsetstext.txt");
findExit($File);

sub findExit(){
	my $Offsets = shift;
	my $jumps = 0;
	my $i = 0;
	my $lastinst = 0;

	do {

			$i = $i + $Offsets->[$i];
			
			($Offsets->[$lastinst])++ if ( $jumps != 0);

			$lastinst = $i;
			
			last if ( $i >= scalar ( @{$Offsets}));
			$jumps++;
			
			die (" Infinit loop") if ($jumps > 10) ;

		} while ($i <= scalar ( @{$Offsets}) );

		print "<TOTAL JUMPS > $jumps \n"
}

sub CopyFile()
{
   my $File = shift;
   my @File = ();
   my $i = 0;
   if ( open ( FILE , "<$File" ) )
   {
      @File = <FILE>;
      close ( FILE );

      foreach my $line ( @File ){
      	chomp($File[$i]);
      	$i++;
      }
      print @File;
   }
   else
   {
      die ("<ERROR>unable to open $File\n");
   }
   return ( \@File );
}