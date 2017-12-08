my $File = CopyFile("registertest.txt");
my $Register = PerformInst($File);

PrintRegister ( $Register );
PrintBiggest ( $Register );

sub PrintBiggest(){
  $Register = shift;
  my $bigval = 0;
  my $bigvar = undef;
  foreach my $variable ( keys %{$Register}){
    if ( $bigval < $Register->{$variable} ){
        $bigval = $Register->{$variable};
        $bigvar = $variable;
    }
  }
  print "<BIG VAR> <$bigvar> < BIG VAL> <$bigval> \n"
}


sub PrintRegister(){
  $Register = shift;
  foreach my $variable ( sort keys %{$Register}){
    print "$variable->". $Register->{$variable} . "\n";
  }
}

sub PerformInst(){

my $File = shift;
my %Variable = () ;
my $exec = 0;
my $bigval = 0;
my $bigvar = undef;

foreach $ins (@{$File}){
   chomp($ins);
   $exec = 0;
   if ( $ins =~ m/^(\w+) (\w+) (-?\d+) if (\w+) (.*) (-?\d+)$/ ){
      $var = $1;
      $op = $2;
      $offset = $3;
      $refvar = $4;
      $refcon = $5;
      $refval = $6;
      print " <$var> <$op> <$offset><$refvar><$refcon><$refval> \n";
      $Variable{$var} = 0 if ( !exists $Variable{$var}  );
      $Variable{$refvar} = 0 if ( !exists $Variable{$refvar}  );

      if ( $refcon eq ">"){ $exec = 1 if ( $Variable{$refvar} > $refval ) ; }
      elsif ( $refcon eq "<"){ $exec = 1 if ( $Variable{$refvar} < $refval ) ; }
      elsif ( $refcon eq ">="){ $exec = 1 if ( $Variable{$refvar} >= $refval ) ;}
      elsif ( $refcon eq "<="){ $exec = 1 if ( $Variable{$refvar} <= $refval ) ;}
      elsif ( $refcon eq "=="){ $exec = 1 if ( $Variable{$refvar} == $refval ) ;}
      elsif ( $refcon eq "!="){ $exec = 1 if ( $Variable{$refvar} != $refval ) ;}
      else { die  (" UNHANDLED CONDITION   <$refcon>\n" ); }

      if ( $exec ) {

          if ( $op eq "inc" ){
             $Variable{$var} = $Variable{$var} + $offset;
          } elsif ( $op eq "dec" ){
              $Variable{$var} = $Variable{$var} - $offset;
          } else { die  (" UNHANDLED OPERATION <$op>\n" ); }
          $exec = 0;
      # To find the highest Value 
         if ( $bigval < $Variable{$var} ){
         $bigval = $Variable{$var};
         $bigvar = $var;
    }

      }
      
    } else {
      die  (" UNHANDLED INSTRUCTION <$ins>\n" );
    }
}
  print "<WHILE EXEC><BIG VAR> <$bigvar> < BIG VAL> <$bigval> \n";

return \%Variable;
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
