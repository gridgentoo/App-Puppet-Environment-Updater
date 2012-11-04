package App::Puppet::EnvironmentUpdaterTest;
use parent qw(Test::Class);

use strict;
use warnings;

use Carp;
use Test::More;
use Test::Exception;
use App::Puppet::EnvironmentUpdater;

sub test_new : Test(1) {
	my ($self) = @_;

	my $app = App::Puppet::EnvironmentUpdater->new({
		environment => 'testing',
		from => 'development',
	});
}

1;
