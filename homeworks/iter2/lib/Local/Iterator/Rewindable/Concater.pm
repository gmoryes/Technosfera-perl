package Local::Iterator::Rewindable::Concater;

use strict;
use warnings;
use DDP;
use base 'Local::Iterator::Rewindable';


sub next {
	my ($self) = @_;
	if ($self->{"end"}) {
		return (undef, 1);
	} else {
		my ($next, $end) = $self->{"iterators"}->[$self->{"cur"}]->next();
		if ($end) {
			if ($self->{"cur"} + 1 == $self->{"length"}) {
				$self->{"end"} = 1;
				return (undef, 1);
			} else {
				$self->{"cur"}++;
				($next, $end) = $self->{"iterators"}->[$self->{"cur"}]->next();
				return ($next, 0);
			}
		} else {
			return ($next, 0);
		}
	}
}

sub init {
	my ($self) = @_;
	$self->{"length"} = scalar(@{$self->{"iterators"}});
}

sub goToBegin {
	my ($self) = @_;
	$self->{"cur"} = 0;
	$self->{"end"} = 0;
}

=encoding utf8

=head1 NAME

Local::Iterator::Rewindable::Concater - concater of other iterators

=head1 SYNOPSIS

    my $iterator = Local::Iterator::Concater->new(
        iterators => [
            $another_iterator1,
            $another_iterator2,
        ],
    );

=cut

1;
