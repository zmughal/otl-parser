use Language::VimOutliner::Setup;
package Language::VimOutliner::Semantics;

use aliased 'Language::VimOutliner::Semantic::CheckboxHeading';
use aliased 'Language::VimOutliner::Semantic::PreTextObject';
use aliased 'Language::VimOutliner::Semantic::TableObject';
use aliased 'Language::VimOutliner::Semantic::TextObject';
use aliased 'Language::VimOutliner::Semantic::UserPreTextObject';
use aliased 'Language::VimOutliner::Semantic::UserTextObject';

sub classify($class, $text) { ## no critic (signature, not prototype)
	my @custom_headings = qw(
		CheckboxHeading
		PreTextObject TextObject
		TableObject
		UserPreTextObject UserTextObject
	);

	for my $heading_type (@custom_headings) {
		no strict 'refs'; ## no critic (using to look up heading by short name)
		return $heading_type if $text =~ &{"$heading_type"}()->MATCH;
	}

	return 'SimpleHeading';
}


1;
