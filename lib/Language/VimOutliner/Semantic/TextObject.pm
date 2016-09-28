package Language::VimOutliner::Semantic::TextObject;

use Moo;
extends qw(Language::VimOutliner::Semantic::ObjectBase);

sub MATCH { qr/^ \Q:\E /x; }
sub ADD_SIBLING { 1; }
sub _object_prefix { ':'; }

1;
