use utf8;
package RA::SmsArc::DB::Result::Contact;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("contact");
__PACKAGE__->add_columns(
  "phone_id",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 32 },
  "number",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "full_name",
  {
    data_type => "varchar",
    default_value => \"null",
    is_nullable => 1,
    size => 64,
  },
);
__PACKAGE__->set_primary_key("number");
__PACKAGE__->has_many(
  "messages",
  "RA::SmsArc::DB::Result::Message",
  { "foreign.number" => "self.number" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->belongs_to(
  "phone",
  "RA::SmsArc::DB::Result::Phone",
  { id => "phone_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07037 @ 2014-01-10 12:37:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QK4pvvwzLOBgK2ogDfmSog


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
