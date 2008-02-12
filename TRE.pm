package re::engine::TRE;
use 5.009005;
use XSLoader ();

# All engines should subclass the core Regexp package
our @ISA = 'Regexp';

BEGIN
{
    $VERSION = '0.02';
    XSLoader::load __PACKAGE__, $VERSION;
}

sub import
{
    $^H{regcomp} = ENGINE;
}

sub unimport
{
    delete $^H{regcomp}
        if $^H{regcomp} == ENGINE;
}

1;

__END__

=head1 NAME

re::engine::TRE - TRE regular expression engine

=head1 SYNOPSIS

    use re::engine::TRE;

    if ("mooh!" =~ /\([mo]*\)/) {
        say $1; # "moo"
    }

=head1 DESCRIPTION

Replaces perl's regex engine in a given lexical scope with POSIX
regular expressions provided by the TRE regular expression
library. tre-0.7.5 is shipped with this module.

=head1 AUTHOR

E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avar@cpan.org>

=head1 LICENSE

Copyright 2007 E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

The included TRE library by I<Ville Laurikari> is under the GNU Lesser
General Public License version 2.1 or later. See the F<tre/LICENCE>
file for details.

=cut
