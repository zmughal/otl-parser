package Language::VimOutliner::Semantic::UserObjectBase;

use Moo;
extends qw(Language::VimOutliner::Semantic::ObjectBase);
use Language::VimOutliner::Info::yaml;

sub ADD_SIBLING {
	my ($self, $text) = @_;
	my $prefix = $self->_object_prefix;
	return $text !~ m/^ $prefix \S+/x;
}

sub user_type {
	my ($self) = @_;
	my $nodes = $self->nodes;
	my $prefix = $self->_object_prefix;
	if( @$nodes && $nodes->[0]->getNodeValue->text =~ m/^ $prefix (?<type>\S+) /x ) {
		return $+{type};
	}

	# otherwise we do not have a type
	return undef; ## no critic
}

sub inner_text {
	my ($self) = @_;
	my $prefix = $self->_object_prefix;
	my $nodes = $self->nodes;
	join "\n", map {
		$_->getNodeValue->text =~ s/^$prefix[ ]//r
	} @$nodes[1..@$nodes-1];
}

sub stringify {
	my ($self) = @_;
	my $user_type = $self->user_type;
	if( $user_type ) {
		if( $user_type eq 'todo' ) {
			use JSON::XS;
			my $data = Language::VimOutliner::Info::yaml->new(
				node => Tree::Simple->new($self)
				)->data;
			return $user_type .  " : " . encode_json($data);
		} else {
			return $user_type;
		}
	}
	return $self->SUPER::stringify;
}

1;
