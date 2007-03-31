package Gtk2::Ex::FileQuickFind;
use strict;
use warnings;

use Gtk2;
use Glib qw(TRUE FALSE);
use Gtk2::Ex::FileLocator;

use Glib::Object::Subclass
  Gtk2::Window::,
  ;

sub import {
	my $class = shift;
	my $run   = 0;
	foreach (@_) {
		if (/^-?run$/) {
			$run = 1;
		}
	}
	$class->run(@ARGV) if $run;
}

sub run {
	Gtk2->init;
	my ( $class, $filename ) = @_;
	my $this = $class->new;
	$this->show;
	$this->present;
	$this->set_filename($filename);
	Gtk2->main;
	return;
}

sub INIT_INSTANCE {
	my ( $this, $filename ) = @_;

	$this->set_title('File QuickFind');
	$this->set_position('GTK_WIN_POS_MOUSE');
	$this->set_default_size( 300, -1 );
	#$this->set_size_request( 300, -1 );

	$this->{fileLocator} = new Gtk2::Ex::FileLocator;
	$this->{fileLocator}->show;

	$this->add( $this->{fileLocator} );

	$this->signal_connect( delete_event => sub { Gtk2->main_quit } );
}

sub set_filename {
	my ( $this, $filename ) = @_;
	$this->{fileLocator}->set_filename($filename);
	return;
}

sub show {
	my ( $this, $filename ) = @_;
	$this->show_all;
}

1;
__END__

=head1 NAME

Gtk2::Ex::FileQuickFind - find an icon on the system

=head1 SYNOPSIS

	use strict;
	use warnings;
	
	use Gtk2::Ex::FileQuickFind -run;

=head1 DESCRIPTION

The File QuickFind dialog allows the user to retrieve the icon for a
particular file, or conversely to obtain the fully-qualified filename for
an icon.

The File QuickFind dialog presents a small window containing a drop
pocket and a text field.  If the user drags an icon from the 
Desktop into the drop pocket, the text field will show the
icon's location on the system with its full path name.  If the user types
a name in the text field, the dialog will search for an icon matching
that name in the user's home directory, then, if no matching icon is
found, in the directories specified in the user's path environment
variable.  Icons that appear in the drop pocket can be dragged out onto
the Desktop or manipulated in place (ex., double-clicked).

=head1 SEE ALSO

http://techpubs.sgi.com/library/tpl/cgi-bin/getdoc.cgi/srch21@pathbar%20pathnamefield/0650/bks/SGI_EndUser/books/Desktop_UG/sgi_html/ch13.html#LE20204-PARENT

=head1 AUTHOR

Holger Seelig <holger.seelig@yahoo.de>

=cut
