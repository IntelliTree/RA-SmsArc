use utf8;
package RA::SmsArc::DB::Result::Message;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("message");
__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "phone_id",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 32 },
  "timestamp",
  { data_type => "datetime", is_nullable => 0 },
  "contact_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "type_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "read",
  { data_type => "integer", default_value => 1, is_nullable => 0 },
  "body",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->belongs_to(
  "contact",
  "RA::SmsArc::DB::Result::Contact",
  { id => "contact_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);
__PACKAGE__->belongs_to(
  "phone",
  "RA::SmsArc::DB::Result::Phone",
  { id => "phone_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);
__PACKAGE__->belongs_to(
  "type",
  "RA::SmsArc::DB::Result::MessageType",
  { id => "type_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07037 @ 2014-01-23 16:01:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:q8uJjBC7FHpSCEvthf1WVQ

__PACKAGE__->load_components('+RA::SmsArc::DB::PhonePermsCmp');

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
