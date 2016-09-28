use Modern::Perl;
package Language::VimOutliner::Shallow::Heading;

use Moo;
use Language::VimOutliner::Setup;
use Types::Standard qw(Str);
use Language::VimOutliner::Semantics;

use overload
	'""' => sub { $_[0]->stringify };

has text => ( is => 'rw', isa => Str );

sub stringify($self, @) { ## no critic (signature, not prototype)
	return $self->text;
}

1;
