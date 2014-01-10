use utf8;
package RA::SmsArc::DB::Result::Phone;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("phone");
__PACKAGE__->add_columns(
  "id",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "name",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->has_many(
  "contacts",
  "RA::SmsArc::DB::Result::Contact",
  { "foreign.phone_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "messages",
  "RA::SmsArc::DB::Result::Message",
  { "foreign.phone_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07037 @ 2014-01-10 12:37:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Pcys+0u8XhW429gIAjEgMg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
