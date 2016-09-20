package Language::VimOutliner::Semantic::HeadingBase;

use Moo;
use Types::Standard qw(ArrayRef InstanceOf);
use MooX::HandlesVia;

has nodes => (
	is => 'rw',
	isa => ArrayRef[InstanceOf['Tree::Simple']],
	handles_via => 'Array',
	handles => {
		add_node => 'push',
	},
	default => sub { [] },
);

1;
