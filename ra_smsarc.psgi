use strict;
use warnings;

use RA::SmsArc;

my $app = RA::SmsArc->apply_default_middlewares(RA::SmsArc->psgi_app);
$app;

