package RA::SmsArc::DB::PhonePermsCmp;

use strict;
use warnings;

# DBIC Component class to be loaded to enforce Row-level write
# permissions. These permissions should never need to be enforced 
# in practice because the interfaces already only show rows the 
# user is allowed to access.

use base 'DBIx::Class';

use RapidApp::Include qw(sugar perlutil);
use RA::SmsArc::Util;

sub _enforce_permission {
  my $self = shift;
  
  my $phn = RA::SmsArc::Util->context_limit_phones or return;
 
  # if there is no phone_id column, assume this is the Phone source itself
  my $col = $self->has_column('phone_id') ? 'phone_id' : 'id';
  
  die "Permission denied" unless ($phn->{ $self->get_column($col) });
}

sub insert {
  my $self = shift;
  my $columns = shift;
  $self->set_inflated_columns($columns) if $columns;
  $self->_enforce_permission;
  return $self->next::method;
}

sub update {
  my $self = shift;
  $self->_enforce_permission;
  return $self->next::method(@_);
}

sub delete {
  my $self = shift;
  $self->_enforce_permission;
  return $self->next::method(@_);
}

1;
