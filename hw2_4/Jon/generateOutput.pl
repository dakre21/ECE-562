#!/usr/bin/perl

$| = 1;
use Cwd;

my $directory = $ARGV[0];

my @tmp;
my %CacheStats;


my $directory = $directory;

opendir (DIR, $directory) or die $!;
my $count = 0;
while (my $file = readdir(DIR)) 
{

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
				CACHEACCESS     => $tmp[0],
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

my $indexToHighestCacheAccess = 0;
my $indexToBestMissRate = 1;
my $tmpCacheAccess = 0;
my $tmpMiss = 1;
my $baseCase = 0;

foreach my $name (sort keys %CacheStats) 
{

    my $tmpNumOfSets = 0;
    my $tmpAssociativity = 0;
    my $tmpLineSize = 0;

    foreach my $subject (keys %{ $CacheStats{$name} }) 
    {

	if ($subject eq CACHEACCESS)
	{
		
		if ($CacheStats{$name}{$subject} lt $tmpCacheAccess)
		{
			$tmpCacheAccess = $CacheStats{$name}{$subject};
			$indexToHighestCacheAccess = $name;
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
my $ipcImprovement=0;
if ($CacheStats{$baseCase}{CACHEACCESS} > 0)
{
	$ipcImprovement = (($CacheStats{$indexToHighestCacheAccess}{CACHEACCESS} - $CacheStats{$baseCase}{CACHEACCESS}) / $CacheStats{$baseCase}{CACHEACCESS}) * 100;
}
print "Benchmark              = ", $CacheStats{$indexToHighestCacheAccess}{BENCH},"\n";
print "Base CACHEACCESS       = ", $CacheStats{$baseCase}{CACHEACCESS},"\n";
print "Best CACHEACCESS       = ", $CacheStats{$indexToHighestCacheAccess}{CACHEACCESS},"\n";
print "Rate Improvement (%)   = ", $ipcImprovement,"\n";
print "Best CACHEACCESS config = NUM_OF_SETS   : ",$CacheStats{$indexToHighestCacheAccess}{NUM_OF_SETS},"\n";
print "                          LINESIZE      : ",$CacheStats{$indexToHighestCacheAccess}{LINESIZE},"\n"; 
print "                          ASSOCIATIVITY : ",$CacheStats{$indexToHighestCacheAccess}{ASSOCIATIVITY},"\n";


print "\n";

my $missImprovement=0;
if ($CacheStats{$baseCase}{CACHEMISS} > 0)
{
	$missImprovement = (($CacheStats{$baseCase}{CACHEMISS} - $CacheStats{$indexToBestMissRate}{CACHEMISS}) / $CacheStats{$baseCase}{CACHEMISS}) * 100;
}

print "Benchmark              = ", $CacheStats{$indexToBestMissRate}{BENCH},"\n";
print "Base CacheMiss Rate    = ", $CacheStats{$baseCase}{CACHEMISS},"\n";
print "Best CacheMiss Rate    = ", $CacheStats{$indexToBestMissRate}{CACHEMISS},"\n";
print "Rate Improvement (%)   = ", $missImprovement,"\n";
print "Best CacheMiss config  = NUM_OF_SETS   : ",$CacheStats{$indexToBestMissRate}{NUM_OF_SETS},"\n";
print "                         LINESIZE      : ",$CacheStats{$indexToBestMissRate}{LINESIZE},"\n"; 
print "                         ASSOCIATIVITY : ",$CacheStats{$indexToBestMissRate}{ASSOCIATIVITY},"\n";


print "Base Config Results:\n";
print "CACHEACCESS       = ", $CacheStats{$baseCase}{CACHEACCESS},"\n";
print "CACHEMISS         = ", $CacheStats{$baseCase}{CACHEMISS},"\n";
print "NUM_OF_SETS       = ", $CacheStats{$baseCase}{NUM_OF_SETS},"\n";
print "LINESIZE          = ", $CacheStats{$baseCase}{LINESIZE},"\n";
print "ASSOCIATIVITY     = ", $CacheStats{$baseCase}{ASSOCIATIVITY},"\n";
print "BENCH             = ", $CacheStats{$baseCase}{BENCH},"\n";



