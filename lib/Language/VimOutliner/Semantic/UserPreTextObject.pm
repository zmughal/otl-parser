package Language::VimOutliner::Semantic::UserPreTextObject;

use Moo;
extends qw(Language::VimOutliner::Semantic::HeadingBase);

sub MATCH { qr/^ \Q<\E /x; }
sub ADD_SIBLING { 0; }

1;
