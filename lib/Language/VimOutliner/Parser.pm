use Language::VimOutliner::Setup;
package Language::VimOutliner::Parser;

use Path::Tiny;
use Data::TreeDumper;
use Tree::Simple;

use aliased qw(Language::VimOutliner::Shallow::Heading);
use aliased qw(Language::VimOutliner::Shallow::EmptyHeading);

sub _tree_simple_filter {
	my $s = shift;

	if('Tree::Simple' eq ref $s) {
		my $counter = 0 ;

		return (
			'ARRAY'
			, $s->{_children}
			, map{[$counter++, $_->{_node}]} @{$s->{_children}} # index generation
		);
	}

	return(Data::TreeDumper::DefaultNodesToDisplay($s)) ;
}

sub Dump($class, $tree) { ## no critic (signature, not prototype)
	say DumpTree($tree, 'root', FILTER => \&_tree_simple_filter );
}

sub parse($class, $file) { ## no critic (signature, not prototype)
	my $input = path($file)->slurp_utf8;

	my $matches;
	my $re = qr/
		^
		(?<indent> \t*)
		(?<text> .*)
		$
	/mx;
	my $root = Tree::Simple->new( EmptyHeading->new, Tree::Simple->ROOT );
	my $current_level = -1;
	my $current_node = $root;


	while( $input =~ /$re/g ) {
		my $match = { %+, pos => $-[0] };
		my $next_level = $match->{level} = length $match->{indent}; # how many tabs?

		next unless length $match->{text};

		#say "Starting at $current_level";#DEBUG
		while( $next_level < $current_node->getDepth ) {
			$current_node = $current_node->getParent;
		}

		while( $current_node->getDepth < $next_level
			and $current_node->getDepth + 1 != $next_level
		) {
			$current_node = Tree::Simple->new( EmptyHeading->new, $current_node );
		}

		#use DDP; say np($match);#DEBUG
		my $heading = Heading->new( text => $match->{text} );
		if( $current_node->getDepth < $next_level ) {
			$current_node = Tree::Simple->new( $heading, $current_node );
		} else {
			$current_node = Tree::Simple->new( $heading, $current_node->getParent );
			# level stays the same
		}
	}

	$root;
}

1;
