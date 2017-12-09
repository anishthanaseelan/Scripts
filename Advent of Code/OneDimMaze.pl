my $File = CopyFile("jumpOffsets.txt");
findExist($File);

sub findExist(){
	my $Offsets = shift;
	my $jumps = 0;
	my $i = 0;
	my $lastinst = 0;

	do {

			print "$i = $Offsets->[$i] \n";
			
			print "$i = $i + $Offsets->[$i] \n";

			$i = $i + $Offsets->[$i];
			
			print "$i = $Offsets->[$i] \n";

			($Offsets->[$lastinst])++ if ( $jumps != 0);

			$lastinst = $i;
			
			last if ( $i >= scalar ( @{$Offsets}));
			
			print "$jumps $i Next Instruction $Offsets->[$i] <" . @{$Offsets} . ">\n";

			$jumps++;
			
			#die (" Infinit loop") if ($jumps > 10) ;

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

      foreach $line ( @File ){
      	chomp($File[$i]);
      	$i++;
      }
      #print @File;
   }
   else
   {
      die ("<ERROR>unable to open $File\n");
   }
   return ( \@File );
}