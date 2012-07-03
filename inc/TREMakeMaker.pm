package inc::TREMakeMaker;
use Moose;

extends 'Dist::Zilla::Plugin::MakeMaker::Awesome';

override _build_WriteMakefile_args => sub { +{
    # Add LIBS => to WriteMakefile() args
    %{ super() },
    LDDLFLAGS => '-shared tre/*.o',
} };

__PACKAGE__->meta->make_immutable;
