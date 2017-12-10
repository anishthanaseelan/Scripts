my $ox = 40;
my $oy = 40;
my $x = $ox;
my $y = $oy;
my $dx = 0;
my $dy = 0;
my $ndest= 289326;

my $level = 1;
my $n =1;
our @Grid = {};
my $i =0;
$Grid[$x][$y] = 1;


do{
	$i++;
	
	for ( my $l = 0 ; $l < $level ; $l++ ){
		$x++;
	
		$n = getAdjustSum($x,$y);
		print "R $n at [$x],[$y]\n" ;
		if ( $n >= $ndest){
			print "$n at [$x],[$y]\n" ;
			$dx = $x;
			$dy = $y; 
			$Grid[$x][$y] = $n;
			last;
		}
		$Grid[$x][$y] = $n;
	}
	for ( my $l = 0 ; $l < $level ; $l++ ){
		$y++;
		
		$n = getAdjustSum($x,$y);
		print "U $n at [$x],[$y]\n" ;
		if ( $n >= $ndest){
			print "$n at [$x],[$y]\n" ;
			$dx = $x;
			$dy = $y;
			$Grid[$x][$y] = $n;
			last; 
		}
		$Grid[$x][$y] = $n;
	}
	$level++;
	for ( my $l = 0 ; $l < $level ; $l++ ){
		$x--;
		
		$n = getAdjustSum($x,$y);
		print "l $n at [$x],[$y]\n" ;
		if ( $n >= $ndest){
			print "$n at [$x],[$y]\n" ;
			$dx = $x;
			$dy = $y; 
		$Grid[$x][$y] = $n;
			last;
		}		$Grid[$x][$y] = $n;
	}
	for ( my $l = 0 ; $l < $level ; $l++ ){
		$y--;
		
		$n = getAdjustSum($x,$y);
		if ( $n >= $ndest){
			print "$n at [$x],[$y]\n" ;
			$dx = $x;
			$dy = $y; 
			$Grid[$x][$y] = $n;
			last;
		
		}		$Grid[$x][$y] = $n;
	}
	$level++;

	last if ( $i > 10 );
}while ( $n <= $ndest  );


printGrid();
print " ($ox,$oy),($dx,$dy)\n";


sub printGrid(){
	for ( my $yy= 20 ; $yy < 50 ; $yy++  ){
	for ( my $xx= 20 ; $xx < 50 ; $xx++  ){

		print "$Grid[$yy][$xx]\t\t";
	}	
	print "\n";

	}
}

sub getAdjustSum (){
	my $xx = shift;
	my $yy =  shift ;
	
	my $sum =  $Grid[$xx+1][$yy] + $Grid[$xx+1][$yy+1] + $Grid[$xx][$yy+1]  +  $Grid[$xx-1][$yy+1] + $Grid[$xx-1][$yy] + $Grid[$xx-1][$yy-1] + $Grid[$xx][$yy-1] + $Grid[$xx+1][$yy-1];
#printGrid();
	 print "Got1 <$xx> <$yy> $sum  $Grid[$xx+1][$yy] + $Grid[$xx+1][$yy+1] + $Grid[$xx][$yy+1]  +  $Grid[$xx-1][$yy+1] + $Grid[$xx-1][$yy] + $Grid[$xx-1][$yy-1] + $Grid[$xx][$yy-1] + $Grid[$xx+1][$yy-1] \n";
	return ($sum);
}