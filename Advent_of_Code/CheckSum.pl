my $File = CopyFile("checksumtext.fl.txt");

my $checksum = 0;
my $Divchecksum = 0;

foreach my $row ( @{$File}){
  chomp($row);
  $row =~ s/\t/ /g;
  $row =~ s/\s+/ /g;

  
  @elements = sort {$b <=> $a} ( split / / , $row );

  print " Got @elements \n";
  $checksum += ($elements[0] - $elements[-1]) ;

  #print "Got $diff = $elements[0] - $elements[-1] \n";

  foreach $element ( @elements){
  foreach $element2 ( sort {$a <=> $b} @elements){
  
    next if ( $element == $element2 );
   if ( int ( $element / $element2 ) == ( $element / $element2 ) && $element  > $element2 ){
    print "Got $element / $element2  \n";
      $Divchecksum += ($element / $element2) ;
   }
  }

}
}

print "<Checksum> $checksum \n ";
print "<Divchecksum> $Divchecksum \n ";

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