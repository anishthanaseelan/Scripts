my $File = CopyFile("input.fl");
our %groups = undef;
our $count = 0;
my $node;
my $neib;

foreach my $comm ( @$File ){
  chomp($comm) ;
  #print "Got $comm \n";
  if ( $comm =~ m/^(\d+) <->(.*)$/ ){
     $node = $1;
     $neib = $2;
  } else{
     die ( "BAD REGEX \n");
  }

  $found = 0;
  foreach $group ( keys %groups ){
     if ( $groups{$group} =~ m/ $node,/ ){
       $groups{$group} = $groups{$group} . ",  $node, $neib, ";
       $found = 1;

       #last;
     }
  }
  if ( 1 ){
     foreach my $inode ( split (/,/ , $neib) ){
        $inode =~ s/\s//g;
        #print " Got inner Node <$inode> \n";
        foreach my $igroup ( keys %groups ){
           #print "Match $groups{$igroup}  \n";
           if ( $groups{$igroup} =~ m/ $inode,/ ){
           #print "Matched $groups{$igroup}  \n";

               $groups{$igroup} = $groups{$igroup} . ",  $inode,  $node, $neib, ";
               $found = 1;
               #last;
           }
        }
     }
  }
  if (!$found){
    $groups{$node} = ", $node, $neib," ;
    #print "<$node>-><$groups{$node} \n";
  }

}
  #Print
  our %UGroup = undef;
  foreach my $group ( sort keys %groups ){
     my @uniq = ();
     $groups{$group}  =~ s/\s//g;
     $groups{$group}  =~ s/,,/,/g;
     $groups{$group}  =~ s/^,//g;
     $groups{$group}  =~ s/,$//g;
     #print " <$group> -> <$groups{$group}> \n";
     @uniq =   do { my %seen; grep { !$seen{$_}++ } split(/,/ ,$groups{$group} )  } ;
     $UGroup{$group} = \@uniq;
     #print " <$group> -> <@{$UGroup{$group}}> \n";
  }
  #print " COUNT ". scalar @{$UGroup{0}}. "\n";

foreach my $ogroup ( sort keys %UGroup ){
   foreach my $node ( sort @{$UGroup{$ogroup}} ){
      foreach my $igroup ( sort keys %UGroup ){
         next if ( $ogroup == $igroup );
         if ( grep(/^$node$/, @{$UGroup{$igroup}})){
            push(@{$UGroup{$ogroup}},  @{$UGroup{$igroup}} );
            delete $UGroup{$igroup} ;
            last;
         }
      }
   }
}
foreach my $ogroup ( sort keys %UGroup ){
   foreach my $node ( sort @{$UGroup{$ogroup}} ){
      foreach my $igroup ( sort keys %UGroup ){
         next if ( $ogroup == $igroup );
         if ( grep(/^$node$/, @{$UGroup{$igroup}})){
            push(@{$UGroup{$ogroup}},  @{$UGroup{$igroup}} );
            delete $UGroup{$igroup} ;
            last;
         }
      }
   }
}
foreach my $ogroup ( sort keys %UGroup ){
   foreach my $node ( sort @{$UGroup{$ogroup}} ){
      foreach my $igroup ( sort keys %UGroup ){
         next if ( $ogroup == $igroup );
         if ( grep(/^$node$/, @{$UGroup{$igroup}})){
            push(@{$UGroup{$ogroup}},  @{$UGroup{$igroup}} );
            delete $UGroup{$igroup} ;
            last;
         }
      }
   }
}

foreach my $group ( sort keys %UGroup ){
  my @uniq = ();
  @uniq =   do { my %seen; grep { !$seen{$_}++ }  @{$UGroup{$group}}  } ;
  $UGroup{$group} = \@uniq;
}
foreach my $group ( sort keys %UGroup ){
  print " <$group> -> <@{$UGroup{$group}}> \n";
}

  print " COUNT ". scalar @{$UGroup{531}}. " " . scalar keys ( %UGroup ) .  "\n";

sub CopyFile()
{
   my $File = shift;
   my @File = ();
   if ( open ( FILE , "<$File" ) ) {
      @File = <FILE>;
      close ( FILE );
   }
   else {
      die ("<ERROR>unable to open $File\n");
   }
   return ( \@File );
}
