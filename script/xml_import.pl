#!/usr/bin/perl
#

$| =1;

use strict;
use RapidApp::Include qw(sugar perlutil);

use FindBin;
use lib "$FindBin::Bin/../lib";

use RA::SmsArc;

my ($phone_id, $xml) = @ARGV;

print "\n\n Importing messages...";

my $count = RA::SmsArc->model('DB::Message')->import($phone_id, $xml);

print "added $count new messages.\n\n";
