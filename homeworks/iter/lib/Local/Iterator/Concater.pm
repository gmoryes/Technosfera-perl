package Local::Iterator::Concater;

use strict;
use warnings;
use DDP;

BEGIN {
	use base 'Local::Iterator';
}

sub new {
	my ($class, %params) = @_;
	$params{"lastIter"} = 0;
	$params{"lenIter"} = scalar(@{$params{"iterators"}});
	$params{"end"} = 0;
	return bless \%params, $class;
}

sub next {
	my ($self) = @_;
	if ($self->{"end"}) {
		return (undef, 1);
	} else {
		my ($next, $end) = $self->{"iterators"}->[$self->{"lastIter"}]->next();
		if ($end) {
			if ($self->{"lastIter"} + 1 == $self->{"lenIter"}) {
				$self->{"end"} = 1;
				return (undef, 1);
			} else {
				$self->{"lastIter"}++;
				($next, $end) = $self->{"iterators"}->[$self->{"lastIter"}]->next();
				return ($next, 0);
			}
		} else {
			return ($next, 0);
		}
	}
}


=encoding utf8

=head1 NAME

Local::Iterator::Concater - concater of other iterators

=head1 SYNOPSIS

    my $iterator = Local::Iterator::Concater->new(
        iterators => [
            $another_iterator1,
            $another_iterator2,
        ],
    );

=cut

1;
