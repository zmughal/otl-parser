package Language::VimOutliner::Shallow::Heading;

use Moo;
use Types::Standard qw(Str);
use Language::VimOutliner::Semantics;

use overload
	'""' => sub {
		my $text = $_[0]->text;
		#return $text;

		#DEBUG
		return
			Language::VimOutliner::Semantics->classify($text) . " : "
				. $text =~ s/[A-Z]/%/gr
					=~ s/[A-Za-z0-9]/x/gr
					=~ s/%/X/gr;
	};

has text => ( is => 'rw', isa => Str );

1;
