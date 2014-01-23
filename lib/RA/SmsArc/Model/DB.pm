package RA::SmsArc::Model::DB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

use Path::Class qw(file);
use Catalyst::Utils;

my $db = file(Catalyst::Utils::home('RA::SmsArc'),'smsarc.db');

__PACKAGE__->config(
    schema_class => 'RA::SmsArc::DB',
    
    connect_info => {
        dsn => 'dbi:SQLite:dbname=' . $db,
        user => '',
        password => '',
        sqlite_unicode => q{1},
        on_connect_call => q{use_foreign_keys},
        quote_names => q{1},
    }
);

# Auto-deploy:
before 'setup' => sub {
  my $self = shift;
  return if (-f $db);
  $self->schema_class->connect($self->connect_info->{dsn})->deploy;
};

1;
