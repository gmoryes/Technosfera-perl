package Local::Iterator::Aggregator;

use strict;
use warnings;
use DDP;
use base 'Local::Iterator';

sub next {
	my ($self) = @_;
	my $ret = [];
	my $was = 0;
	for my $i (0..$self->{"chunk_length"} - 1) {
		my ($next, $end) = $self->{"iterator"}->next();
		if ($end) {
			last;
		} else {
			$ret->[$i] = $next;
		}
		$was = 1;
	}
	
	if ($was != 0) {
		return ($ret, 0);
	} else {
		$self->{"end"} = 1;
		return (undef, 1);
	}
}

sub init {
	my ($self) = @_;
}

=encoding utf8

=head1 NAME

Local::Iterator::Aggregator - aggregator of iterator

=head1 SYNOPSIS

    my $iterator = Local::Iterator::Aggregator->new(
        chunk_length => 2,
        iterator => $another_iterator,
    );

=cut

1;
