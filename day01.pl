use Term::ANSIColor;
my $filename = "${0}_input";
open(my $fh, $filename);

chomp (my $input = <$fh>);

my $sum;
my $sum2;
my $len = length $input;
for (my $i = 0; $i < $len; $i++) {
	my $current = substr($input, $i, 1);
	my $next  = substr($input, ($i+1) % ($len), 1);
	my $halfway = substr($input, ($i+$len/2)%($len), 1);

	$sum += $current if( $current == $next );
	$sum2 += $current if( $current == $halfway );
}
print "Sum of al chars that are equal to their follower is ", colored( $sum, "bright_red" ), ".\n";
print "Sum of al chars that are equal to their halfway equal is ", colored($sum2,"bright_red"), " .\n";