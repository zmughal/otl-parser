package Language::VimOutliner::Shallow::Heading;

use Moo;
use Types::Standard qw(Str);
use Language::VimOutliner::Semantics;

use overload
	'""' => sub {
		Language::VimOutliner::Semantics->classify($_[0]->text) . " : "
		. $_[0]->text
			=~ s/[A-Z]/%/gr
			=~ s/[A-Za-z0-9]/x/gr
			=~ s/%/X/gr
	};

has text => ( is => 'rw', isa => Str );

1;
