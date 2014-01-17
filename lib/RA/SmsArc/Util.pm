package RA::SmsArc::Util;

use strict;
use warnings;

use RapidApp::Include qw(sugar perlutil);

# returns hashref of phone_id (keys) the user is allowed to access,
# or undef for no limit (access to all phone_ids)
sub context_limit_phones {
  my $class = shift;
  my $c = RapidApp->active_request_context;
  
  # invalid sessions are automatically handled by RapidApp
  return undef unless ($c && $c->session_is_valid);
  
  my %roles = map { 
    $_->get_column('role') => 1
  } $c->user->user_to_roles->all;
  
  # administrators can see all phones:
  return undef if ($roles{administrator});
  
  # Get all the phone ids this user is allowed to access according
  # to the special 'phone:phone_id' role syntax
  my @phone_ids = map {
    my ($pre,$id) = split(/phone:/,$_,2);
    $id
  } grep { /phone:/ } keys %roles;
  
  return { map {$_=>1} @phone_ids };
}


1;
