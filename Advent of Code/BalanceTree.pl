my $File = CopyFile("fullnode.txt");
#my $File = CopyFile("node.txt");
my $ChildHash = BuildChildHash($File);
my $Parent  = LinkChildAndGetParent($ChildHash);

print "The Top Parent is $Parent \n" ;

my @Tab = undef;
$Tab[1] = "\t";
$Tab[2] = "\t\t";
$Tab[3] = "\t\t\t";
$Tab[4] = "\t\t\t\t";
$Tab[5] = "\t\t\t\t\t";
$Tab[6] = "\t\t\t\t\t\t";
$Tab[7] = "\t\t\t\t\t\t\t";
$Tab[8] = "\t\t\t\t\t\t\t\t";
$Tab[9] = "\t\t\t\t\t\t\t\t\t";
$Tab[9] = "\t\t\t\t\t\t\t\t\t\t";
$Tab[10] = "\t\t\t\t\t\t\t\t\t\t";




GetWeightByTower($ChildHash->{$Parent});
PrintTree($ChildHash->{$Parent} );

sub PrintTree(){
  $Level++;
  my $ChildHash = shift;
  my $siblingWeight = undef;


  foreach my $node ( keys %{$ChildHash->{R}} ){
     #print "\n".$Tab[$Level]. " -><$node>\(" . %{$ChildHash}->{R}{$node}{W} . "\)  ";
      $siblingWeight = $ChildHash->{R}{$node}{TW} if ( $siblingWeight == undef ) ;

     PrintTree($ChildHash->{R}{$node});

     print "\n".$Tab[$Level]. " -><$node>\(" . $ChildHash->{R}{$node}{TW} . "\)" . "\(" . $ChildHash->{R}{$node}{W} . "\) " if ( $Level != 0 ) ;

     if ( $ChildHash->{R}{$node}{TW} != $siblingWeight ){
        $diff = $ChildHash->{R}{$node}{TW} - $ChildHash->{R}{$node}{W} ;
        print " <>ODD<> \($diff \) " if ( $Level != 0 );
        #$siblingWeight = %{$ChildHash}->{R}{$node}{TW};
     }
  }
  $Level--;
}


sub GetWeightByTower()
{
  $Level++;
  my $ChildHash = shift;

  foreach my $node ( keys %{$ChildHash->{R}} ){
     $ChildHash->{TW} = $ChildHash->{TW} + $ChildHash->{R}{$node}{W} + $ChildHash->{R}{$node}{TW};
     GetWeightByTower($ChildHash->{R}{$node});
     #$ChildHash->{TW} = $ChildHash->{TW} + %{$ChildHash}->{W} ;
     $ChildHash->{R}{$node}{TW} = $ChildHash->{R}{$node}{TW} +  $ChildHash->{R}{$node}{W};
     #print "\n".$Tab[$Level]. " -><$node>\(" . %{$ChildHash}->{R}{$node}{W} . "\)  ";
     #print "\n".$Tab[$Level]. " -><$node>\(" . %{$ChildHash}->{R}{$node}{TW} . "\)" . "\(" . %{$ChildHash}->{R}{$node}{W} . "\) " if ( $Level < 5 )  ;
  }
  $Level--;


}



sub LinkChildAndGetParent(){
   my $Child = shift;
   my $parentnode  = undef;
   #foreach my $child ( keys %{$Child}->{R} ){
   foreach my $child ( keys %{$Child} ){
        #print "<CHILD> $child \n";
     my $Parent = FindParent( $Child , $child );
     if (  $Parent != undef ){
        #print "Pre Parent $Parent \n ";
        $Parent->{R}{$child} = $Child->{$child};
        #print "$Parent".$Parent->{W}. " \n ";
        #print "$Parent".$Parent->{R}. " \n ";
     }else{
        #print "<CHILD> $child \n";
        $parentnode = $child;
     }
   }
  return $parentnode;
}

sub FindParent(){
  my $Parents = shift;
  my $child = shift;
  foreach my $parent ( keys %{$Parents} ){
      if ( exists $Parents->{$parent}{R}{$child} ){
         #print "<CHILD><$child><PARENT><$parent> \n";
         #return %{$Parents}->{$parent}{R}{$child}
         return $Parents->{$parent};
      } else {
         #print "<Failed FIND LOOP><CHILD><$child><PARENT><$parent>\n";
     }
  }
  print "<CHILD><$child><PARENT><None>\n";

  return undef;
}

sub BuildChildHash()
{
   my $File = shift;
   my %ChildHash = ();
   foreach my $line ( @{$File} ){
      #print $line;
      chomp ( $line);
      if (  $line =~ m/^(.*) \((\d+)\)$/ ){
        #print "<$1><$2> \n";
        $ChildHash{$1}{W} = $2;

      } elsif ( $line =~ m/^(.*) \((\d+)\) \-\> (.*)$/ ){
        #print " <$1><$2><$3>  \n";
        $ChildHash{$1}{W} = $2;
        foreach my $child ( split /, / , $3 ){
           #print "<EXTRACTED CHILD><$child>\n";
           $ChildHash{$1}{W} = $2;
           $ChildHash{$1}{R}{$child} = 1;
        }
      } else {
        die " ><><><><><><> UNHANDLED Line<><><><><><><>< \n ";
      }
   }
   return ( \%ChildHash );
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
