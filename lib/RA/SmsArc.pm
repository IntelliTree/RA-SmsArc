package RA::SmsArc;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

use RapidApp 0.99028;

use Catalyst qw/
    -Debug
    RapidApp::RapidDbic
    RapidApp::AuthCore
    RapidApp::NavCore
    RapidApp::CoreSchemaAdmin
/;

extends 'Catalyst';

our $VERSION = '0.01';

__PACKAGE__->config(
    name => 'RA::SmsArc',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,

    'Plugin::RapidApp::RapidDbic' => {
      dbic_models => ['DB'],
      # automatically hide columns like 'type_id' and 'phone_id' because
      # we can access them via their single relnames 'type' and 'phone'
      hide_fk_columns => 1,
      # don't *show* the grid links in the tree
      menu_require_role => 'administrator',
      configs => {
        DB => {
          grid_params => {
            # Enable full read/write in all sources:
            #  Note, in a real app, probably only delete would make sense,
            #  but I'm leaving them all on, including manual create, for
            #  the purposes of demoing RapidApp basic CRUD features
            '*defaults' => { # Defaults for all Sources
               updatable_colspec => ['*'],
               creatable_colspec => ['*'],
               destroyable_relspec => ['*']
            }, # ('*defaults')
            Message => {
              # Load the grid plugin for the import interface view
              # (see Ext.ux.SmsArc.ImportMessagesPlugin in local.js)
              plugins => ['smsarc-grid-import-messages']
            }
          },
          TableSpecs => {
            Contact => {
              display_column => 'full_name'
            },
            Message => {
              columns => {
                id => { hidden  => 1 },
                read => { profiles => ['bool'], hidden => 1 },
                number => { width => 140 },
                phone => { hidden => 1 },
                body => { width => 300 }
              }
            },
            MessageType => {
              display_column => 'name'
            },
            Phone => {
            
            }
          
          }
        }
      }
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
