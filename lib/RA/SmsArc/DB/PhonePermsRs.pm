package RA::SmsArc::DB::PhonePermsRs;

use strict;
use warnings;

# Base ResultSet class for sources which we need to limit access
# to allowed phones according to roles

use base 'RapidApp::DBIC::ResultSet::BaseRs';

use RapidApp::Include qw(sugar perlutil);

sub phone_id_column { 'phone_id' }

sub base_rs {
  my $self = shift;
  my $c = RapidApp->active_request_context;
  
  return $self unless ($c && $c->can('user'));
  
  my %roles = map { 
    $_->get_column('role') => 1
  } $c->user->user_to_roles->all;
  
  # administrators can see all phones:
  return $self if ($roles{administrator});
  
  # Get all the phone ids this user is allowed to access according
  # to the special 'phone:phone_id' role syntax
  my @phone_ids = map {
    my ($pre,$id) = split(/phone:/,$_,2);
    $id
  } grep { /phone:/ } keys %roles;
  
  return $self->search_rs({ 
    $self->phone_id_column => { -in => \@phone_ids }
  });
}

1;
