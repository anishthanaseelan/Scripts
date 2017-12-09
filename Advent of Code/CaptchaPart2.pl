my $firstchar = undef;
my $char = undef;
my $Total = 0;
my $pairindex = 0;
my $CharCount = 0;
my @Char = ();

  if ( open ( FILE , "<captchatest.fl.txt" ) )   {
    	while ($read = read FILE, $char, 1) {
    		chomp($char);
        $Char[$i] = $char;
        $i++;
    		}
              close ( FILE );
    }else{
      die ("<ERROR>unable to open $File\n");
    }

  for ( my $j=0 ; $j < scalar @Char ; $j++){
     $CharCount++;
    if ( ((scalar @Char) - 1 )/2   > $j ){
      $pairindex = (((scalar @Char) - 1 )/2)+$j;
    }else{
      $pairindex = $j - (((scalar @Char) -1 )/2);
    }
    if ( $Char[$j] == $Char[$pairindex] ){
      print "Got : $Char[$j] == $Char[$pairindex] \n";
      $Total += $Char[$j];
    }
  }

  		print "<TOTAL> $Total \n";
  		print "<TOTAL Char> $CharCount \n";
