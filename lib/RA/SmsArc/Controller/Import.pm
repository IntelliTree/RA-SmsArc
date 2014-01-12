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
  
  # default state of return packet - should never be returned
  my $packet = { success => 0, msg => 'unknown error' };
  
  # Do our own simple error handling so that Ajax 'failure' function will 
  # be called which we need to happen so our button will be re-enabled.
  # See the client/view side Ext.ux.SmsArc.ImportMessagesPlugin (local.js)
  try {
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
    
    $packet = { success => 1 };
  }
  catch {
    my $err = shift;
    $packet = { success => 0, msg => "$err" };
  };
  
  return $c->res->body(encode_json($packet));
}



__PACKAGE__->meta->make_immutable;

1;
