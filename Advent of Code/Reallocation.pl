use strict;

#our @MemBank = ( 0, 2, 7, 0);
#our @RefMemBank = ( 0, 2, 7, 0);
our @MemBank = ( 5,1,10,0,1,7,13,14,3,12,8,10,7,12,0,6);
our @RefMemBank = ( 5,1,10,0,1,7,13,14,3,12,8,10,7,12,0,6);

our $DistCount = 0;
our %Pattern = undef; 
while (1){

	#Find Biggest
	our $bigidx = 0;

	for ( my $i =0 ; $i < scalar ( @MemBank) ; $i++){
		 $bigidx = $i if ( $MemBank[$bigidx] < $MemBank[$i] );
	}

	#print "The Biggest : $bigidx -> $MemBank[$bigidx] \n";

	#Distribute
	our $DistVal = $MemBank[$bigidx];
	$MemBank[$bigidx] = 0;

	for ( my $i =0 ; $i < $DistVal ; $i++){
		 if ( ($i + $bigidx +1 ) < scalar ( @MemBank)){
		 	#print "IDX $i+ $bigidx \n";
		 	$MemBank[$i + $bigidx +1]++;
		 }else{
		 	$MemBank[($i+ $bigidx + 1) % scalar(@MemBank)]++;
		 	#print "IDX " . $i+ $bigidx +1 - scalar(@MemBank) . "\n";
		 }
	}



	#Match the pattern
=Anish
	my $NoMatch = 0;
	for ( my $i =0 ; $i < scalar ( @MemBank) ; $i++){
		 $NoMatch = 1 if ( $RefMemBank[$i] != $MemBank[$i] );
	}
=cut
	$DistCount++;

	print "After Distribution @MemBank -> $DistCount\n";
	my $key = join ( "_", @MemBank);
	if ( $Pattern{$key} > 0 ){
		print "NUMBER OF DISTRBUTIONS : $DistCount : $key " . $Pattern{$key}  . " \n";
		last;
	}else{
		$Pattern{$key} = $DistCount;
	}

	#Safty
	die ( " Infinite Loop \n ") if ( $DistCount > 10000 );
}
 



