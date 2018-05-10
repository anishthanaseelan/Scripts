my $ox = 300;
my $oy = 300;
my $x = $ox;
my $y = $oy;
my $dx = 0;
my $dy = 0;
my $ndest = 289326;

my $level = 0;
my $n =1;
my @Grid = ();

do{
	
	for ( my $l = 0 ; $l < $level ; $l++ ){
		$x++;
		$n++;
		if ( $n == $ndest){
			print "$n at [$x],[$y]\n" ;
			$dx = $x;
			$dy = $y; 
		
		}
		$Grid[$x][$y] = $n;
	}
	for ( my $l = 0 ; $l < $level ; $l++ ){
		$y++;
		$n++;
		if ( $n == $ndest){
			print "$n at [$x],[$y]\n" ;
			$dx = $x;
			$dy = $y; 
		}
		$Grid[$x][$y] = $n;
	}
	$level++;
	for ( my $l = 0 ; $l < $level ; $l++ ){
		$x--;
		$n++;
		if ( $n == $ndest){
			print "$n at [$x],[$y]\n" ;
			$dx = $x;
			$dy = $y; 
		
		}		$Grid[$x][$y] = $n;
	}
	for ( my $l = 0 ; $l < $level ; $l++ ){
		$y--;
		$n++;
		if ( $n == $ndest){
			print "$n at [$x],[$y]\n" ;
			$dx = $x;
			$dy = $y; 
		
		}		$Grid[$x][$y] = $n;
	}
	$level++;
}while ( $n <= $ndest );

=Anish
for ( my $xx= 0 ; $xx < 40 ; $xx++  ){
for ( my $yy= 0 ; $yy < 40 ; $yy++  ){
	print "$Grid[$xx][$yy]\t";
}	
	print "\n";
}
=cut
print " ($ox,$oy),($dx,$dy)\n";

#my $dist = sqrt ( ($ox-$dx)*($ox-$dx) + ($oy-$dy)*($oy-$dy) );
my $dist = abs ($dx-$ox)+ abs ($oy-$dy) ;
my $blocks = $dist / sqrt(2); 
my $steps = $blocks*2;

print "Distance : $dist Blocks : $blocks Steps : $steps  \n";







