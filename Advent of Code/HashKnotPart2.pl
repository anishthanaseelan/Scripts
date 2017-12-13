
use strict;
use warnings;

chomp($_ = <197,97,204,108,1,29,5,71,0,50,2,255,248,78,254,63>);

printf "Part 1: %d\n", eval join "*", (hash(m/\d+/g))[0,1];
printf "Part 2: @{['%02x' x 16]}\n",
    eval join("^", hash((unpack("c*"), 17, 31, 73, 47, 23) x 64))
        =~ s/(?:\^\d+){15}\K\^/,/gr;

sub hash {
    my ($i, $skip, @a) = (0, 0, 0..255);
    push @a, splice @a, 0, ($_ + $skip) % unshift @a, reverse splice @a, 0, $_ and $i += $_ + $skip++ for @_;
    return splice @a, 0, unshift @a, splice @a, -$i % @a;
}