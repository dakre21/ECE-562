#!/usr/bin/perl

#use warnings;
#use strict;

$| = 1;
use Cwd;

my $set = $ARGV[0];

my $pwd = cwd();

my @tmp;


my %CacheStats;

my $directory = $pwd."/Results/csv/".$set;

opendir (DIR, $directory) or die $!;
my $count = 0;
while (my $file = readdir(DIR)) 
{

	#my @values = split('_', $file);

	if ($file ne '.' && $file ne '..')
	{
		my @values = split /[:_,\s\/]+/, $file;

		  foreach my $val (@values) {
			    $val =~ s/
		        (.)             # matches any character
		        \.              # the literal dot starting an extension
		        [^.]+           # one or more NON-dots
		        $               # end of the string
			/$1/x;
		  }

		my $bench = $values[0];
		my $size = $values[1];
		my $line_size = $values[2];
		my $associativity = $values[3];

		open(my $data, '<', $directory."/".$file) or die "couldnot";

		while (my $line = <$data>) 
		{
		   chomp $line;
		   @tmp = split "," , $line;

			$CacheStats{ $count } = 
			{
				IPC		=> $tmp[0],
				CACHEMISS	=> $tmp[1],
				NUM_OF_SETS	=> $size,
				LINESIZE	=> $line_size,
				ASSOCIATIVITY	=> $associativity,
				BENCH		=> $bench,
			};
		}
		$count = $count + 1;
	}

}

my $indexToBestIpc = 0;
my $indexToBestMissRate = 1;
my $tmpIPC = 0;
my $tmpMiss = 1;
my $baseCase = 0;

foreach my $name (sort keys %CacheStats) 
{

    my $tmpNumOfSets = 0;
    my $tmpAssociativity = 0;
    my $tmpLineSize = 0;

    foreach my $subject (keys %{ $CacheStats{$name} }) 
    {

	if ($subject eq IPC)
	{
		
		if ($CacheStats{$name}{$subject} gt $tmpIPC)
		{
			$tmpIPC = $CacheStats{$name}{$subject};
			$indexToBestIpc = $name;
		}	
	} 

	if ($subject eq CACHEMISS)
	{
		
		if ($CacheStats{$name}{$subject} lt $tmpMiss)
		{
			$tmpMiss = $CacheStats{$name}{$subject};
			$indexToBestMissRate = $name;
		}	
	} 
	if ($subject eq NUM_OF_SETS)
	{
		$tmpNumOfSets = $CacheStats{$name}{$subject};
	} 
	if ($subject eq LINESIZE)
	{
		$tmpLineSize = $CacheStats{$name}{$subject};		
	} 
	if ($subject eq ASSOCIATIVITY)
	{
		$tmpAssociativity = $CacheStats{$name}{$subject};	
	} 
    }

    if ( ($tmpNumOfSets eq 32) && ($tmpLineSize eq 64) && ($tmpAssociativity eq 4))
    {
	$baseCase = $name;
    }
    else
    {
	$tmpNumOfSets = 0;
	$tmpLineSize = 0;
	$tmpAssociativity = 0;
    }
	
}

my $ipcImprovement = (($CacheStats{$indexToBestIpc}{IPC} - $CacheStats{$baseCase}{IPC}) / $CacheStats{$baseCase}{IPC}) * 100;
print "Benchmark              = ", $CacheStats{$indexToBestIpc}{BENCH},"\n";
print "Base IPC               = ", $CacheStats{$baseCase}{IPC},"\n";
print "Best IPC               = ", $CacheStats{$indexToBestIpc}{IPC},"\n";
print "Rate Improvement (%)   = ", $ipcImprovement,"\n";
print "Best IPC config        = NUM_OF_SETS   : ",$CacheStats{$indexToBestIpc}{NUM_OF_SETS},"\n";
print "                         LINESIZE      : ",$CacheStats{$indexToBestIpc}{LINESIZE},"\n"; 
print "                         ASSOCIATIVITY : ",$CacheStats{$indexToBestIpc}{ASSOCIATIVITY},"\n";

print "\n";

print $CacheStats{$baseCase}{CACHEMISS},"\n";

if ($CacheStats{$baseCase}{CACHEMISS} > 0)
{
	my $missImprovement = (($CacheStats{$baseCase}{CACHEMISS} - $CacheStats{$indexToBestMissRate}{CACHEMISS}) / $CacheStats{$baseCase}{CACHEMISS}) * 100;
}

print "Benchmark              = ", $CacheStats{$indexToBestMissRate}{BENCH},"\n";
print "Base CacheMiss Rate    = ", $CacheStats{$baseCase}{CACHEMISS},"\n";
print "Best CacheMiss Rate    = ", $CacheStats{$indexToBestMissRate}{CACHEMISS},"\n";
print "Rate Improvement (%)   = ", $missImprovement,"\n";
print "Best CacheMiss config  = NUM_OF_SETS   : ",$CacheStats{$indexToBestMissRate}{NUM_OF_SETS},"\n";
print "                         LINESIZE      : ",$CacheStats{$indexToBestMissRate}{LINESIZE},"\n"; 
print "                         ASSOCIATIVITY : ",$CacheStats{$indexToBestMissRate}{ASSOCIATIVITY},"\n";


print "Base Config Results:\n";
print "IPC               = ", $CacheStats{$baseCase}{IPC},"\n";
print "CACHEMISS         = ", $CacheStats{$baseCase}{CACHEMISS},"\n";
print "NUM_OF_SETS       = ", $CacheStats{$baseCase}{NUM_OF_SETS},"\n";
print "LINESIZE          = ", $CacheStats{$baseCase}{LINESIZE},"\n";
print "ASSOCIATIVITY     = ", $CacheStats{$baseCase}{ASSOCIATIVITY},"\n";
print "BENCH             = ", $CacheStats{$baseCase}{BENCH},"\n";



