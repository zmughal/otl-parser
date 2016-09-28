package Language::VimOutliner::Semantic::HeadingBase;

use Moo;
use Types::Standard qw(ArrayRef InstanceOf);
use MooX::HandlesVia;

use overload
	'""' => sub { $_[0]->stringify };

has nodes => (
	is => 'rw',
	isa => ArrayRef[InstanceOf['Tree::Simple']],
	handles_via => 'Array',
	handles => {
		add_node => 'push',
	},
	default => sub { [] },
);

sub stringify {
	my ($self) = @_;
	my $node_count = @{[$self->nodes]};
	$node_count
		and
		$self->nodes->[0]->getNodeValue->text
	;
}

1;
