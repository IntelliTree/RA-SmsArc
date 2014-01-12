package RA::SmsArc::Controller::Import;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

use RapidApp::Include qw(sugar perlutil);

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  die "Permission denied" unless ($c->user);
  
  my $upload = $c->req->upload('Filedata') or die "no upload object";
  my $phone_id = $c->req->params->{phone_id} or die "no phone_id";
  
  my $cS = $c->model('RapidApp::CoreSchema');
  
  $cS->txn_do( sub {

    my $role_name = "phone:$phone_id";
    if($cS->resultset('Role')->find({ role => $role_name })) {
      die usererr "You do not have permission to import messages for '$phone_id'"
        unless ($c->check_any_user_role('administrator',$role_name));
    }
    else {
      $cS->resultset('UserToRole')->create({
        username => $c->user->username,
        role => {
          role => $role_name, 
          description => "Access to phone_id '$phone_id'"
        }
      });
    }
    
    $c->model('DB::Message')->import($phone_id, $upload->tempname);
    
  });
  
  my $packet = { success => 1 };
  return $c->res->body(encode_json($packet));
}



__PACKAGE__->meta->make_immutable;

1;
