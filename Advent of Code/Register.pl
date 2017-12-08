my $File = CopyFile("registertest.txt");
my  $exec = 0;

foreach $ins (@{$File}){
   chomp($ins);
   $exec = 0;
   if ( $ins =~ m/^(\w+) (\w+) (-?\d+) if (\w+) (.*) (-?\d+)$/ ){
      print " <$1> <$2> <$3><$4><$5><$6> \n";
      $Variable{$1} = 0 if ( ! exists $Variable{$1}  );
         switch ( $5 ){
=Anish
           case "\>" { $exec = 1 if ( $4 > $6 ) ; }
           case "\<" { $exec = 1 if ( $4 < $6 ) ; }
           case "\>\=" {$exec = 1 if ( $4 >= $6 ) ;}
           case "\<\=" {$exec = 1 if ( $4 <=  $6 ) ; }
           case "\=\=" { $exec = 1 if ( $4 == $6 ) ;}
           case "\!\=" { $exec = 1 if ( $4 != $6 ) ; }
           else { die  (" UNHANDLED CONDITION   <$1>\n" ); }
=cut
         }
         if ( $exec ) {
             if ( $2 == "inc" ){
             $Variable{$1} = $Variable{$1} + $3;
             } else {
              $Variable{$1} = $Variable{$1} - $3;
             }
         }
          $exec = 0;
   } else {
    die  (" UNHANDLED INSTRUCTION <$ins>\n" );
   }
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
