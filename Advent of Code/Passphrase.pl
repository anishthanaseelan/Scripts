my $File = CopyFile("1.txt");

my $Phrases = 0;
my $BadPhrases = 0;
my $Bad2Phrases = 0;
my $GoodPhrase = 0;

foreach my $PassPhrase ( @{$File} ){
$Phrases++;
chomp ($PassPhrase);
my @words = split / /, $PassPhrase;
my %words = map { $_ => 1 } @words;

my @newKeys = keys %words;

if ( scalar ( @words ) != scalar (@newKeys) ){
        print "Bad Phrase $PassPhrase \n";
        $BadPhrases++;
}
else{
  $SWords = SortedWords(\@words);
  @SSWords = sort @{$SWords};
  my %SHwords = map { $_ => 1 } @SSWords;
  my @newSHKeys = keys %SHwords;

  print "Got YOU>>> \n" if ( scalar ( @words ) != scalar ( @SSWords ));
  print "<Keys><@words><@SSWords> \n";

  if ( scalar (  @words ) != scalar (@newSHKeys) ){
        print "Bad 2 Phrase $PassPhrase \n";
        $Bad2Phrases++;
}else{
print "Good Phrase Phrase $PassPhrase \n";
$GoodPhrase++;

}
}

}
print "Total  : $Phrases : Bad Phrases : $BadPhrases Bad Phrase two : $Bad2Phrases  Good Phrase : $GoodPhrase\n";

sub SortedWords(){
   my $Words = shift;
   my @SWords = {};
   my $i = 0;

   foreach my $Word ( @{$Words}){
     @tw = join '' , sort ( split //,$Word) ;
     $SWords[$i++] =  join '', sort ( split //,$Word);
   }
   return \@SWords;
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
