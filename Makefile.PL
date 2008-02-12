use 5.009005;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME		  => 're::engine::TRE',
    AUTHOR        => 'Ævar Arnfjörð Bjarmason <avar@cpan.org>',
    VERSION_FROM  => 'TRE.pm',
    ABSTRACT_FROM => 'TRE.pm',
    LICENSE       => 'perl',
    LIBS          => [ '-lpcre' ],
    DIR           => [ 'tre' ],
    INC           => '-Itre',
    LDDLFLAGS     => '-shared tre/*.o',
);
