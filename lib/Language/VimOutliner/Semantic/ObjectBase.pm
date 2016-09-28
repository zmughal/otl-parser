package Language::VimOutliner::Semantic::ObjectBase;

use Moo;
extends qw(Language::VimOutliner::Semantic::HeadingBase);


sub _object_prefix { ... }

sub inner_text {
	my ($self) = @_;
	my $prefix = $self->_object_prefix;
	my $nodes = $self->nodes;
	join "\n", map {
		$_->getNodeValue->text =~ s/^$prefix[ ]//r
	} @$nodes;
}


sub stringify {
	my ($self) = @_;
	my $node_count = @{$self->nodes};
	return $self->SUPER::stringify
		. ($node_count > 1
			? " [ and @{[ $node_count - 1 ]} more lines ]"
			: "")
	;
}

1;
