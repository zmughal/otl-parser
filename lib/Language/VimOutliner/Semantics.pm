use Language::VimOutliner::Setup;
package Language::VimOutliner::Semantics;

use Tree::Simple;

use Language::VimOutliner::Semantic::CheckboxHeading;
use Language::VimOutliner::Semantic::PreTextObject;
use Language::VimOutliner::Semantic::TableObject;
use Language::VimOutliner::Semantic::TextObject;
use Language::VimOutliner::Semantic::UserPreTextObject;
use Language::VimOutliner::Semantic::UserTextObject;

use Language::VimOutliner::Semantic::SimpleHeading;

use Language::VimOutliner::Shallow::EmptyHeading;

sub classify($class, $text) { ## no critic (signature, not prototype)
	my @custom_headings = qw(
		Language::VimOutliner::Semantic::CheckboxHeading

		Language::VimOutliner::Semantic::PreTextObject
		Language::VimOutliner::Semantic::TextObject

		Language::VimOutliner::Semantic::TableObject

		Language::VimOutliner::Semantic::UserPreTextObject
		Language::VimOutliner::Semantic::UserTextObject
	);

	for my $heading_type (@custom_headings) {
		return $heading_type if $text =~ $heading_type->MATCH;
	}

	return 'Language::VimOutliner::Semantic::SimpleHeading';
}

sub semantic_tree($class, $tree) { ## no critic (signature, not prototype)
	my @nodes = $tree->getAllChildren;
	my $semantic_root = Tree::Simple->new(
		Language::VimOutliner::Shallow::EmptyHeading->new,
		Tree::Simple->ROOT );
	$class->_semantic_tree($tree, $semantic_root);
	return $semantic_root;
}

sub _semantic_tree($class, $tree, $parent) { ## no critic (signature, not prototype)
	my @children = $tree->getAllChildren();
	my $last_semantic_child = undef;
	do {
		my $node = shift @children;
		my $node_text = $node->getNodeValue->text;
		my $node_type = $class->classify($node->getNodeValue->text);
		my $semantic_node;
		if( $last_semantic_child
				and $last_semantic_child->getNodeValue->ADD_SIBLING($node_text)
				and $last_semantic_child->getNodeValue->isa($node_type)
			) {
			$semantic_node = $last_semantic_child;
		} else {
			$semantic_node = Tree::Simple->new( $node_type->new() , $parent );
		}

		$semantic_node->getNodeValue->add_node($node);

		if( $node->isLeaf ) {
			$last_semantic_child = $semantic_node;
		} else {
			$last_semantic_child = undef;
			$class->_semantic_tree( $node, $semantic_node );
		}
	} while(@children);
}


1;
