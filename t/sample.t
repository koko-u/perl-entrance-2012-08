use Test::More;

require_ok( 'sample.pl' );

is( &pow(2, 3) , 8, '&pow(2, 3) is 8');

done_testing;

