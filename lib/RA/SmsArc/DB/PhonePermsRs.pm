package RA::SmsArc::DB::PhonePermsRs;

use strict;
use warnings;

# Base ResultSet class for sources which we need to limit access
# to allowed phones according to roles

use base 'RapidApp::DBIC::ResultSet::BaseRs';

use RapidApp::Include qw(sugar perlutil);
use RA::SmsArc::Util;

sub phone_id_column { 'phone_id' }

sub base_rs {
  my $self = shift;
  
  my $phn = RA::SmsArc::Util->context_limit_phones or return $self;
  
  # Use 'as_subselect_rs' to prevent ambiguous column exceptions
  return $self->search_rs({ 
    $self->phone_id_column => { -in => [ keys %$phn ] }
  })->as_subselect_rs;
}

1;
