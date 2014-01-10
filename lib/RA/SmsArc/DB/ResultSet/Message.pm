package RA::SmsArc::DB::ResultSet::Message;

use strict;
use warnings;

use base 'DBIx::Class::ResultSet';

use RA::SmsArc::Parser;

sub schema { (shift)->result_source->schema }

sub import {
  my ($self, $phone_id, $file) = @_;
  
  my $P = RA::SmsArc::Parser->new( file => $file );
  
  my $PhoneRs = $self->schema->resultset('Phone');
  my $ContactRs = $self->schema->resultset('Contact');
  
  $PhoneRs->find_or_create({ id => $phone_id });
  
  $self->populate([ map {{
    phone_id  => $phone_id,
    timestamp => join(' ',$_->{date_dt}->ymd,$_->{date_dt}->hms),
    number => $ContactRs->find_or_create({
      phone_id  => $phone_id,
      number => $_->{address},
      full_name => $_->{contact_name}
    },{ key => 'primary' })->number,
    type_id => $_->{type},
    read => $_->{read},
    body => $_->{body}
  }} @{$P->messages} ]);
}


1;
