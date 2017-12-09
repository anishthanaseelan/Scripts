my $read;
my $weight = 0;
my $TotalWeight = 0;
my $skipnext = 0;
my $GroupCount = 0;
my $gcharcount = 0;
  #if ( open ( FILE , "<C:/Users/anish/Desktop/input.txt" ) )
  if ( open ( FILE , "<WeightedCodeBlocks.fl" ) )
   {
      while ($read = read FILE, $char, 1) {
         print "got: $char\n";
         if ( $skipnext ){
          $skipnext = 0;
          next;
         }
        if ( $char eq "!"){
          $skipnext = 1;
          next ;
        }

        print "got: $char\n";

        

        if ( $char eq ">" ){
          $garbage = 0 ;
        }
        if ( $garbage ){
          $gcharcount++;
          next;
        }
        if ( $char eq "<" ){
          $garbage = 1 ;
        }
        
        $weight++ if ( $char eq "{" ) ;
        if ( $char eq "}" ){
          $TotalWeight += $weight;
          $GroupCount++;
          $weight-- ;
        }

      }

      print "<TOTAL WEIGHT> $TotalWeight \n";
      print "<GROUP COUNT> $GroupCount \n";
      print "<GRABAGE CHAR COUNT> $gcharcount \n";

      die "read error: $!" if not defined $read;
      close ( FILE );
  }else{
    die ("<ERROR>unable to open $File\n");
  }
