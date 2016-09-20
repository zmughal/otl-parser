package Language::VimOutliner::Semantic::TableObject;

use Moo;
extends qw(Language::VimOutliner::Semantic::HeadingBase);

sub MATCH { qr/^ \Q|\E /x; }
sub ADD_SIBLING {
	0;
}

1;
