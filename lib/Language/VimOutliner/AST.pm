package Language::VimOutliner::AST;

use Modern::Perl;
use Marpa::R2;
use feature qw(signatures);
no warnings qw(experimental::signatures);

sub grammar {
	return \(<<'GRAMMAR');

:start ::= Top

Top ::=
	Items

Items ::= Item+

Item ::=
	  OptIndent Heading (Newline)
	| (Newline)

OptIndent ::= Indent
OptIndent ::= # empty

Text ~ [^\t\n] RestText
RestText ~ [^\n]*

Heading ::=
	  CheckboxHeading     # [_] [X]
	 | TextObject          # :
	 | PreTextObject       # ;
	 | TableObject         # |
	 | UserTextObject      # >
	 | UserPreTextObject   # >
	#|| SimpleHeading

SimpleHeading ::=
	Text

# [_] ...
CheckboxHeading ::=
	CheckboxPrefix Space Text

#   :      body text (wrapping)
TextObject ::=
	TextObjectPrefix Text


#   ;      preformatted body text (non-wrapping)
PreTextObject ::=
	PreTextObjectPrefix Text

#   |      table
TableObject ::=
	TableObjectPrefix Text

#   >      user-defined, text block (wrapping)
UserTextObject ::=
	UserTextObjectPrefix Text

#   <      user-defined, preformatted text block (non-wrapping)
UserPreTextObject ::=
	UserPreTextObjectPrefix Text

Space ~ ' '

LeftBrace ~ '['
RightBrace ~ ']'
CheckboxInner ~ [_X]
CheckboxPrefix ~ LeftBrace CheckboxInner RightBrace

TextObjectPrefix ~ ':'
PreTextObjectPrefix ~ ';'
TableObjectPrefix ~ '|'
UserTextObjectPrefix ~ '>'
UserPreTextObjectPrefix ~ '<'

Indent ~ [\t]+
Newline ~ [\n]

GRAMMAR
}

sub parse($file) { ## no critic (signature, not prototype)
	my $grammar = Marpa::R2::Scanless::G->new({
		#default_action => '::array',
		default_action => '[name,values]',
		source => Language::VimOutliner::AST->grammar,
	});

	my $recce = Marpa::R2::Scanless::R->new( {
		grammar => $grammar,
		#trace_terminals => 1,
		#trace_file_handle => $trace_fh
		} );

	my $input = $file->slurp_utf8;

	$recce->read( \$input );
	#use DDP; p $recce->value;
}

1;
=pod

=head1 SYNOPSIS

  use Language::VimOutliner::AST;

=head1 DESCRIPTION

A grammar for parsing Vim Outliner files.

=cut
