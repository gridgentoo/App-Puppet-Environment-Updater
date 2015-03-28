requires "Carp" => "0";
requires "File::pushd" => "0";
requires "Git::Wrapper" => "0";
requires "List::MoreUtils" => "0";
requires "Log::Dispatchouli" => "0";
requires "Moose" => "0";
requires "MooseX::FollowPBP" => "0";
requires "MooseX::Getopt" => "0";
requires "MooseX::Types::Path::Class" => "0";
requires "Path::Class::Dir" => "0";
requires "Term::ANSIColor" => "0";
requires "Try::Tiny" => "0";
requires "namespace::autoclean" => "0";
requires "strict" => "0";
requires "warnings" => "0";

on 'build' => sub {
  requires "Module::Build" => "0.3601";
};

on 'test' => sub {
  requires "Directory::Scratch" => "0";
  requires "File::Find" => "0";
  requires "File::Temp" => "0";
  requires "Test::Class" => "0";
  requires "Test::Exception" => "0";
  requires "Test::More" => "0.88";
  requires "parent" => "0";
};

on 'configure' => sub {
  requires "Module::Build" => "0.3601";
};

on 'develop' => sub {
  requires "Test::CPAN::Changes" => "0.19";
  requires "version" => "0.9901";
};
