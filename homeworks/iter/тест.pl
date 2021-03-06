use lib '/home/gmoryes/Technosfera-perl/homeworks/iter/lib';


use DDP;
use strict;
use Local::Iterator::RewindableIterator::Array;
use Local::Iterator::Aggregator;
use Local::Iterator::Map;
use Local::Iterator::Interval;
use Local::Iterator::Filter;
use DateTime;
use DateTime::Duration;

my $it = Local::Iterator::Map->new(
	iterator => Local::Iterator::RewindableIterator::Array->new(array => [1,2,3,4]),
	callback => sub {
		my $var = shift;
		return $var * $var;
	},
);

my $ret = $it->all();
p $ret;

#
#\ [
#    [0] 1,
#    [1] 4,
#    [2] 9,
#    [3] 16
#]
#
