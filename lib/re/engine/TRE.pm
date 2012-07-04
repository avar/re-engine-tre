package re::engine::TRE;
# ABSTRACT: TRE regular expression engine

=head1 SYNOPSIS

    use re::engine::TRE;

    if ("mooh!" =~ /\([mo]*\)/) {
        say $1; # "moo"
    }

=head1 DESCRIPTION

Replaces perl's regex engine in a given lexical scope with POSIX
regular expressions provided by the TRE regular expression
library. tre-0.8.0 is shipped with this module.

=cut

use strict;
use utf8;
use warnings qw(all);

use 5.009005;
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
        $^H{__PACKAGE__ . '::' . $_} = int($args{$_})
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
