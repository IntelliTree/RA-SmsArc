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
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
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
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("phone_id_number_unique", ["phone_id", "number"]);
__PACKAGE__->has_many(
  "messages",
  "RA::SmsArc::DB::Result::Message",
  { "foreign.contact_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->belongs_to(
  "phone",
  "RA::SmsArc::DB::Result::Phone",
  { id => "phone_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07037 @ 2014-01-23 16:01:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:QKxpqFHUSvYfYsI1g9/bUg

__PACKAGE__->load_components('+RA::SmsArc::DB::PhonePermsCmp');

__PACKAGE__->has_many(
  "sent_messages",
  "RA::SmsArc::DB::Result::Message",
  { "foreign.contact_id" => "self.id"  },
  { cascade_copy => 0, cascade_delete => 0,
    where => { type_id => 2 }
  },
);

__PACKAGE__->has_many(
  "recv_messages",
  "RA::SmsArc::DB::Result::Message",
  { "foreign.contact_id" => "self.id"  },
  { cascade_copy => 0, cascade_delete => 0,
    where => { type_id => 1 }
  },
);

__PACKAGE__->has_many(
  "othr_messages",
  "RA::SmsArc::DB::Result::Message",
  { "foreign.contact_id" => "self.id"  },
  { cascade_copy => 0, cascade_delete => 0,
    where => { -and => [
      { type_id => { '!=' => 1 } }, 
      { type_id => { '!=' => 2 } }
    ]}
  },
);


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
