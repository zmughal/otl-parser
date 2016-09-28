package Language::VimOutliner::Semantic::UserTextObject;

use Moo;
extends qw(Language::VimOutliner::Semantic::UserObjectBase);

sub MATCH { qr/^ \Q>\E /x; }
sub _object_prefix { '>'; }

1;
