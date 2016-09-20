package Language::VimOutliner::Shallow::EmptyHeading;

use Moo;
use Types::Standard qw(Str);

extends qw(Language::VimOutliner::Shallow::Heading);

has text => ( is => 'ro', isa => Str, default => sub { '[empty]' } );

1;
