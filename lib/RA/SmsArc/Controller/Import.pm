package RA::SmsArc::Controller::Import;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

use RapidApp::Include qw(sugar perlutil);

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  die "Permission denied" unless ($c->user);
  
  my $upload = $c->req->upload('Filedata') or die "no upload object";
  
  
  # TODO ......
  
  
  # temp
  my $packet = {
    success => \1,
    filename => $upload->filename,
    added_count => 123
  };

  return $c->res->body(encode_json($packet));
}

__PACKAGE__->meta->make_immutable;

1;
