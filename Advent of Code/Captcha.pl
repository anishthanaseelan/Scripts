my $firstchar = undef;
my $char = undef;
my $Total = 0;
my $prechar = undef;
my $CharCount = 0;

  if ( open ( FILE , "<captchatest.fl.txt" ) )   {
    	while ($read = read FILE, $char, 1) {
    		chomp($char);
    		print "got: $char\n";
    		$CharCount++;
      		 
      		if ( $firstchar == undef){
      			$firstchar = $char;
      			$prechar = $char;
      			next;
      		}

      		
      		if ( $prechar == $char){
      			$Total += $char;
      		}
      		
      		$prechar = $char if ( $char ne "");
  		}

  		if ( $firstchar == $prechar){
  		print "got: $firstchar == $prechar\n";
      		$Total += $prechar;
      	}
  		close ( FILE );
  		print "<TOTAL> $Total \n";
  		print "<TOTAL Char> $CharCount \n";
  	}else{
    	die ("<ERROR>unable to open $File\n");
  	}
