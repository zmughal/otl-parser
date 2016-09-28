use Language::VimOutliner::Setup;
package Language::VimOutliner::Shallow::DebugHeadingRole;

use Moo::Role;

around stringify => sub {
	my $orig = shift; # not calling $orig
	my $text = $_[0]->text;
	return
		Language::VimOutliner::Semantics->classify($text) . " : "
			. $text =~ s/[A-Z]/%/gr
				=~ s/[A-Za-z0-9]/x/gr
				=~ s/%/X/gr;
};

1;
