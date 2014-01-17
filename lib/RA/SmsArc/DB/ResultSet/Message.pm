package RA::SmsArc::DB::ResultSet::Message;

use strict;
use warnings;

use base 'RA::SmsArc::DB::PhonePermsRs';

use RapidApp::Include qw(sugar perlutil);
use RA::SmsArc::Parser;

sub schema { (shift)->result_source->schema }

sub import {
  my ($self, $phone_id, $file) = @_;
  
  my $P = RA::SmsArc::Parser->new( file => $file );
  
  my $PhoneRs = $self->schema->resultset('Phone');
  my $ContactRs = $self->schema->resultset('Contact');
  
  $PhoneRs->find_or_create({ id => $phone_id });
  
  my @added = ();
  
  for my $msg (@{$P->messages}) {
    my $Row = $self->find_or_new({
      phone_id  => $phone_id,
      timestamp => join(' ',$msg->{date_dt}->ymd,$msg->{date_dt}->hms),
      number => $ContactRs->find_or_create({
        phone_id  => $phone_id,
        number => $msg->{address},
        full_name => $msg->{contact_name}
      },{ key => 'primary' })->number,
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
