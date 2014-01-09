package RA::SmsArc::Parser;

use strict;
use warnings;
use Moo;

use XML::Simple;
use DateTime;

has 'file', is => 'ro', required => 1;
has 'messages', is => 'ro', required => 1;

around BUILDARGS => sub {
  my $orig = shift;
  my $class = shift;
  my %params = (ref($_[0]) eq 'HASH') ? %{ $_[0] } : @_; # <-- arg as hash or hashref

  $params{messages} = $class->_parse_file($params{file}) 
    if ($params{file} && ! $params{messages});

  return $class->$orig(%params);
};


sub _parse_file {
  my $class = shift;
  my $file = shift;
  
  die "File '$file' not found" unless (-e $file);
  
  my $data = XMLin( $file ) or die "Parsing '$file' failed - unknown error";
  die "Unexpected XML data" unless (ref($data->{sms}) eq 'ARRAY');
  
  my @messages = map {{ %$_,
    date_dt => DateTime->from_epoch( epoch => int($_->{date}/1000) ),
  }} @{$data->{sms}};
  
  return \@messages;
}

1;
