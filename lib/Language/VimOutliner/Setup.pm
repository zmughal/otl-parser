use Modern::Perl;
package Language::VimOutliner::Setup;
# ABSTRACT: Packages that can be imported into every module

use autodie;

use Import::Into;
use Try::Tiny ();

sub import {
	my ($class) = @_;

	my $target = caller;

	Modern::Perl->import::into( $target );
	autodie->import::into( $target );
	Try::Tiny->import::into( $target );
	feature->import::into( $target, qw(signatures switch));
	warnings->unimport::out_of( $target, qw(experimental::signatures experimental::smartmatch));

	return;
}

1;
