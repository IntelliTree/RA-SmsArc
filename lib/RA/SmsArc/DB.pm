use utf8;
package RA::SmsArc::DB;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use Moose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07037 @ 2014-01-09 17:16:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:u1rTaCuyOqcfCRbyFxllEw


after 'deploy' => sub {
  my $self = shift;
  
  $self->resultset('MessageType')->populate([
    { id => 1, name => 'Received' },
    { id => 2, name => 'Sent' },
    { id => 3, name => 'Draft' },
    { id => 4, name => 'Outbox' },
    { id => 5, name => 'Failed' },
    { id => 6, name => 'Queued' },
  ]);

};

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
