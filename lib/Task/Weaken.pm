package Task::Weaken;

use 5.005;
use strict;

use vars qw{$VERSION};
BEGIN {
	$VERSION = '0.99';
}

1;

__END__

=pod

=head1 NAME

Task::Weaken - Ensure that a platform has weaken support

=head1 DESCRIPTION

One recurring problem in modules that use L<Scalar::Util>'s C<weaken>
function is that it is not present in the pure-perl variant.

While this isn't necesarily always a problem in a straight CPAN-based
Perl environment, some operating system distributions only include the
pure-Perl versions, don't include the XS version, and so weaken is
then "missing" from the platform, B<despite> passing a dependency on
L<Scalar::Util> successfully.

Most notably this is RedHat Linux at time of writing, but other come
and go and do the same thing, hence "recurring problem".

The normal solution is to manually write tests in each distribution
to ensure that C<weaken> is available.

This restores the functionality testing to a dependency you do once
in your F<Makefile.PL>, rather than something you have to write extra
tests for each time you write a module.

It should also help make the package auto-generators for the various
operating systems play more nicely, because it introduces a dependency
that they B<have> to have a proper weaken in order to work.

=head2 How this Task works

Part of the problem seems to stem from the fact that some distributions
continue to include modules even if they fail some of their tests.

To get around that for this module, it will do a few dirty tricks.

If L<Scalar::Util> is not available at all, it will issue a normal
dependency on the module. However, if L<Scalar::Util> is relatively
new ( it is >= 1.14 ) and the module does B<not> have weaken, the
install will bail out altogether with a "platform does not support
this module" error.

This means that a distributor cannot just force the install, as there
will be no F<Makefile> at all to do the installation phase.

This is to some degree lying, so it is somewhat debatable if this
strategy should continue, and may be removed later.

This distribution also contains tests to ensure that weaken is
available using more normal methods.

So if your module uses C<weaken>, you can just add the following to
your L<Module::Install>-based F<Makefile.PL> (or equivalent).

  requires 'Task::Weaken';

=head1 AUTHOR

Adam Kennedy E<lt>cpan@ali.asE<gt>, L<http://ali.as/>

=head1 SEE ALSO

L<Task>, L<Scalar::Util>, L<http://ali.as/>

=head1 COPYRIGHT

Copyright 2006 Adam Kennedy.

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut
