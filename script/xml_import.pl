#!/usr/bin/perl
#

$| =1;

use strict;
use RapidApp::Include qw(sugar perlutil);

use FindBin;
use lib "$FindBin::Bin/../lib";

use RA::SmsArc;

my ($phone_id, $xml) = @ARGV;

# Just for testing...
#my $Obj = RA::SmsArc::Parser->new( file => $xml );
#scream( $Obj );

RA::SmsArc->model('DB::Message')->import($phone_id, $xml);
