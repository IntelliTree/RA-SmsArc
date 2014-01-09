package RA::SmsArc;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

use RapidApp;

use Catalyst qw/
    -Debug
    RapidApp::RapidDbic
/;

extends 'Catalyst';

our $VERSION = '0.01';

__PACKAGE__->config(
    name => 'RA::SmsArc',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,

    'Plugin::RapidApp::RapidDbic' => {
	dbic_models => ['DB']
    }

);

# Start the application
__PACKAGE__->setup();


=head1 NAME

RA::SmsArc - Catalyst based application

=head1 SYNOPSIS

    script/ra_smsarc_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<RA::SmsArc::Controller::Root>, L<Catalyst>

=head1 AUTHOR

root

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
