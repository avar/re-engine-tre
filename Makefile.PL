use utf8;
use inc::Module::Install;

name 're-engine-TRE';

perl_version '5.009005';

author 'Ævar Arnfjörð Bjarmason <avar@cpan.org>';
abstract_from 'TRE.pm';
license_from 'TRE.pm';

# t/
build_requires 'XSLoader'   => 0;
build_requires 'Test::More' => 0; # 5.007003

makemaker_args DIR => [ 'tre' ];
makemaker_args INC => '-Itre';
makemaker_args LDDLFLAGS => '-shared tre/*.o';

tests 't/*.t';

auto_install;
WriteAll;
