use Language::VimOutliner::Setup;
package Language::VimOutliner::Info::todo;

use Moo;
use Language::VimOutliner::Info::yaml;
use List::AllUtils qw(first);

has node => (
	is => 'ro',
	requried => 1,
);

has _todo => ( is => 'lazy',);

has [ qw[text inner_text done due start] ] => ( is => 'lazy',);

sub _build_inner_text {
	my ($self) = @_;
	$self->node->getNodeValue->inner_text;
}

sub _build_text {
	my ($self) = @_;
	$self->node->getNodeValue->stringify;
}

sub _build_done {
	my ($self) = @_;
	$self->text =~ m/^ \[X\] /x;
}

sub _build_due {
	my ($self) = @_;
	return unless $self->_todo;
	my $data = $self->_todo->data;
	exists $data->{due} and $data->{due};
}

sub _build_start {
	my ($self) = @_;
	return unless $self->_todo;
	my $data = $self->_todo->data;
	exists $data->{due} and $data->{start};
}

sub _build__todo {
	my ($self) = @_;
	my $node = $self->node;
	do {
		my $todo_child = first {
			$_->getNodeValue->isa('Language::VimOutliner::Semantic::UserPreTextObject')
			and $_->getNodeValue->user_type eq 'todo'
		} $node->getAllChildren;
		if($todo_child) {
			return Language::VimOutliner::Info::yaml->new(
					node => $todo_child
					);
		}
		$node = $node->getParent;
	} while( ! $node->isRoot );
}


1;
