use strict;
use warnings;
use Test::More;


use Catalyst::Test 'RA::SmsArc';
use RA::SmsArc::Controller::Import;

ok( request('/import')->is_success, 'Request should succeed' );
done_testing();
