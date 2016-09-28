package Language::VimOutliner::Semantic::UserPreTextObject;

use Moo;
extends qw(Language::VimOutliner::Semantic::UserObjectBase);

sub MATCH { qr/^ \Q<\E /x; }
sub _object_prefix { '<'; }

1;
