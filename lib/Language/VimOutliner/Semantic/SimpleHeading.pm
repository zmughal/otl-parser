package Language::VimOutliner::Semantic::SimpleHeading;

use Moo;
extends qw(Language::VimOutliner::Semantic::HeadingBase);

sub MATCH { qr/^ .* /x; }
sub ADD_SIBLING {
	0;
}

1;
