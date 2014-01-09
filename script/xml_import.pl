#!/usr/bin/perl
#

$| =1;

use strict;
use RapidApp::Include qw(sugar perlutil);

use FindBin;
use lib "$FindBin::Bin/../lib";

use RA::SmsArc::Parser;

my ($phone_id, $xml) = @ARGV;


# Just for testing...

my $Obj = RA::SmsArc::Parser->new( file => $xml );

scream( $Obj );
