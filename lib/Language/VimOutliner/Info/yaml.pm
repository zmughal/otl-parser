use Language::VimOutliner::Setup;
package Language::VimOutliner::Info::yaml;

use Moo;
use YAML;

has node => (
	is => 'ro',
	requried => 1,
);

has data => (
	is => 'lazy',
);

sub _build_data {
	my $self = shift;
	my $data = Load($self->node->getNodeValue->inner_text);
}

1;
