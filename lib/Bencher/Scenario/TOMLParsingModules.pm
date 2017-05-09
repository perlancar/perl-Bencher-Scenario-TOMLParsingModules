package Bencher::Scenario::TOMLParsingModules;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use File::ShareDir::Tarball qw(dist_dir);

our $scenario = {
    summary => 'Benchmark TOML parsing modules',
    modules => {
        # minimum versions
    },
    extra_modules => ['File::Slurper'],
    participants => [
        {
            module => 'TOML',
            code_template => 'TOML::from_toml(File::Slurper::read_text(<filename>))',
        },
        {
            module => 'TOML::Parser',
            code_template => 'state $parser = TOML::Parser->new; $parser->parse(File::Slurper::read_text(<filename>))',
        },
    ],

    datasets => [
    ],
};

my $dir = dist_dir('TOML-Examples')
    or die "Can't find share dir for TOML-Examples";
for my $filename (glob "$dir/examples/iod/extra-bench-*.toml") {
    my $basename = $filename; $basename =~ s!.+/!!;
    push @{ $scenario->{datasets} }, {
        name => $basename,
        args => {filename => $filename},
    };
}

1;
# ABSTRACT:
