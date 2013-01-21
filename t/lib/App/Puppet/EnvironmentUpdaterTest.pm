package App::Puppet::EnvironmentUpdaterTest;
use parent qw(Test::Class);

use strict;
use warnings;

use Carp;
use Test::More;
use Test::Exception;
use App::Puppet::EnvironmentUpdater;
use Directory::Scratch;
use Log::Dispatchouli;
use Git::Wrapper;

sub setup : Test(setup) {
	my ($self) = @_;

	$self->{test_logger} = Log::Dispatchouli->new_tester();
	$self->{tmp} = Directory::Scratch->new();

	my $repos_dir = $self->{tmp}->mkdir('repos');
	my $env = $repos_dir->subdir('environment');
	$env->mkpath();
	$self->{env_git} = Git::Wrapper->new($env);
	$self->{env_git}->init();
	$self->{tmp}->create_tree({
		'repos/environment/site.pp' => "node example.com {}",
	});
	$self->{env_git}->add('.');
	$self->{env_git}->commit('-m', 'first commit');
	$self->{env_git}->branch('foo');

	$self->{workdir} = $self->{tmp}->mkdir('work');
	$self->{work_git} = Git::Wrapper->new($self->{workdir});
	$self->{work_git}->clone($env, $self->{workdir});
}

sub teardown : Test(teardown) {
	my ($self) = @_;

	undef $self->{tmp};
}

sub test_new : Test(1) {
	my ($self) = @_;

	new_ok('App::Puppet::EnvironmentUpdater' => [
		environment => 'testing',
		from        => 'development',
	], 'instance created');
}


sub remote_branch_for_test : Test(2) {
	my ($self) = @_;

	my $branch = $self->create_updater()->remote_branch_for('bar');
	is($branch, 'origin/bar', 'remote branch name constructed');

	$branch = $self->create_updater(
		remote => 'github',
	)->remote_branch_for('bar');
	is($branch, 'github/bar', 'remote can be set in constructor');
}


sub create_and_switch_to_branch_test : Test(1) {
	my ($self) = @_;

	my $app = $self->create_updater();
	$app->create_and_switch_to_branch('foo');
	is_deeply(
		[ '* foo', '  master' ],
		[ $self->{work_git}->branch() ],
		'branch created'
	);
}


sub create_updater {
	my ($self, %arg) = @_;

	return App::Puppet::EnvironmentUpdater->new({
		environment => 'testing',
		from        => 'development',
		workdir     => $self->{workdir},
		logger      => $self->{test_logger},
		%arg,
	})
}


1;
