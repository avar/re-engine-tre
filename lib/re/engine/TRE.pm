package re::engine::TRE;
# ABSTRACT: TRE regular expression engine

=head1 SYNOPSIS

    use re::engine::TRE max_cost => 1;

    if ("A pearl is a hard object produced..." =~ /\(Perl\)/i) {
        say $1; # "pearl"
    }

=head1 DESCRIPTION

Replaces Perl's regex engine in a given lexical scope with POSIX
regular expressions provided by the TRE regular expression
library. L<tre-0.8.0|http://laurikari.net/tre/download/> is shipped with this module.

=head1 PRAGMA OPTIONS

=for :list
* C<cost_ins>: The default cost of an inserted character, that is, an extra character in string (default: 1).
* C<cost_del>: The default cost of a deleted character, that is, a character missing from string (default: 1).
* C<cost_subst>: The default cost of a substituted character (default: 1).
* C<max_cost>: The maximum allowed cost of a match. If this is set to zero, an exact matching is searched for (default: 0).
* C<max_ins>: Maximum allowed number of inserted characters (default: unspecified).
* C<max_del>: Maximum allowed number of deleted characters (default: unspecified).
* C<max_subst>: Maximum allowed number of substituted characters (default: unspecified).
* C<max_err>: Maximum allowed number of errors (inserts + deletes + substitutes; default: unspecified).

Set any value to C<-1> to represent "unspecified, but very high".

=head1 REFERENCES

=head2 Algorithm & Implementation

=for :list
* L<Bitap algorithm|https://en.wikipedia.org/wiki/Bitap>
* L<Introduction to the TRE regexp matching library.|http://laurikari.net/tre/about/>

=head2 Salvaged several parts from

=for :list
* L<re::engine::PCRE> (recent Perl compatibility)
* L<re::engine::RE2> (parameter passing)
* L<String::Approx> (tests for approximate matching)

=cut

use strict;
use utf8;
use warnings qw(all);

use 5.010000;
use Scalar::Util qw(looks_like_number);
use XSLoader ();

# All engines should subclass the core Regexp package
our @ISA = 'Regexp';

BEGIN {
    # VERSION
    XSLoader::load __PACKAGE__, $VERSION;
}

=for Pod::Coverage
ENGINE
=cut

sub import {
    shift;

    $^H{regcomp} = ENGINE;

    if (@_) {
        my %args = @_;
        $^H{__PACKAGE__ . '::' . $_} =
            $args{$_} < 0
                ? 0x7fff
                : int($args{$_})
            for grep {
                exists $args{$_}
                and looks_like_number($args{$_})
            } qw(
                cost_ins
                cost_del
                cost_subst
                max_cost
                max_ins
                max_del
                max_subst
                max_err
            );
    }
}

sub unimport {
    delete $^H{regcomp}
        if $^H{regcomp} == ENGINE;
}

1;
