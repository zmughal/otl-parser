package Language::VimOutliner::Semantic::CheckboxHeading;

use Moo;
extends qw(Language::VimOutliner::Semantic::HeadingBase);

sub MATCH { qr/^ \Q[\E [X_] \Q]\E /x; }
sub ADD_SIBLING { 0; }

sub inner_text {
	my ($self) = @_;
	my $prefix_re = $self->MATCH;
	$self->stringify =~ s/$prefix_re[ ]//r;
}

1;
