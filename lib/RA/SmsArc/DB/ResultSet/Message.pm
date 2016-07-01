package RA::SmsArc::DB::ResultSet::Message;

use strict;
use warnings;

use base 'RA::SmsArc::DB::PhonePermsRs';

use RapidApp::Util qw(:all);
use RA::SmsArc::Parser;

sub schema { (shift)->result_source->schema }

sub import {
  my ($self, $phone_id, $file) = @_;
  
  my $P = RA::SmsArc::Parser->new( file => $file );
  
  my $PhoneRs = $self->schema->resultset('Phone');
  my $ContactRs = $self->schema->resultset('Contact');
  
  my $PhRow = $PhoneRs->find_or_new({ id => $phone_id });
  unless ($PhRow->in_storage) {
    # If this is a brand new phone_id, we know that there will not
    # be any existing Message or Contact rows, so we can use the
    # faster populate() call:
    $PhRow->insert;
    $self->populate([ map {{
      phone_id  => $phone_id,
      timestamp => join(' ',$_->{date_dt}->ymd,$_->{date_dt}->hms),
      contact => {
        phone_id  => $phone_id,
        number => $_->{address},
        full_name => $_->{contact_name}
      },
      type_id => $_->{type},
      read => $_->{read},
      body => $_->{body}
    }} @{$P->messages} ]);
    
    # Just return the count of messages passed to populate():
    return scalar @{$P->messages};
  }
  
  # We're importing messages for an existing phone, so we need to
  # check for and skip duplicate messages and contacts:
  my @added = ();
  for my $msg (@{$P->messages}) {
    my $Row = $self->find_or_new({
      phone_id  => $phone_id,
      timestamp => join(' ',$msg->{date_dt}->ymd,$msg->{date_dt}->hms),
      contact => $ContactRs->find_or_create({
        phone_id  => $phone_id,
        number => $msg->{address},
        full_name => $msg->{contact_name}
      },{ key => 'phone_id_number_unique' }),
      type_id => $msg->{type},
      read => $msg->{read},
      body => $msg->{body}
    });
    push @added, $Row->insert unless ($Row->in_storage); 
  }
  
  # Return the added rows or a count of added rows:
  return wantarray ? @added : scalar @added;
}

1;
