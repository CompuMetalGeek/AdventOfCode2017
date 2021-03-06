use strict;
use Term::ANSIColor;
use Win32::Console::ANSI;
use Time::HiRes qw/time/;

my $time = time;
my $filename = "${0}_input";
open(my $fh, $filename);

my $genAVal = <$fh>;
$genAVal = (split " ",$genAVal)[-1];
my $genAVal2 = $genAVal;
my $genAFactor = 16_807;
my $genAMultiple = 4;

my $genBVal = <$fh>;
$genBVal = (split " ",$genBVal)[-1];
my $genBVal2 = $genBVal;
my $genBFactor = 48_271;
my $genBMultiple = 8;

my $divisor = 2_147_483_647;
my $bitmask = 0b1111111111111111;

my $count = 0;
my $count2 = 0;

my $iterations = 40_000_000;
for (my $i = 0; $i < 40_000_000; $i++) {
	$genAVal = ($genAVal * $genAFactor) % $divisor;
	$genBVal = ($genBVal * $genBFactor) % $divisor;

	if(($genAVal & $bitmask) == ($genBVal & $bitmask)){
		$count++;
	}
	if($i % ($iterations/100) == 0 ){
		local $| = 1;
		printf "\r%3d %% completed -- current count is %d", $i / ($iterations/100), $count;
	}
}

print "\rThe final count is ", colored( $count, "black on_red" ), ". ( ", sprintf ("%.3f",time - $time) ," s )                           \n";

$time = time;
$count = 0;

$iterations = 5_000_000;
for (my $i = 0; $i < $iterations; $i++) {

	do{
		$genAVal2 = ($genAVal2 * $genAFactor) % $divisor;
	} while( $genAVal2 % $genAMultiple != 0 );

	do {
		$genBVal2 = ($genBVal2 * $genBFactor) % $divisor;
	} while( $genBVal2 % $genBMultiple != 0 );

	if(($genAVal2 & $bitmask) == ($genBVal2 & $bitmask)){
		$count++;
	}
	if($i % ($iterations/100) == 0 ){
		local $| = 1;
		printf "\r%3d %% completed -- current count is %d", $i / ($iterations/100), $count;
	}
}

print "\rThe final count for multiples of $genAMultiple and $genBMultiple is ", colored( $count, "black on_red" ), ". ( ", sprintf ("%.3f",time - $time) ," s )\n";

