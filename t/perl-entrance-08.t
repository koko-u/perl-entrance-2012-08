use Test::More;

require_ok( 'perl-entrance-08.pl' );

# &sum関数のテスト
ok( &sum(1, 1) == 1 + 1, '&sum(1, 1) = 2');

# &calc関数のテスト
ok( &calc(11, 2, '+') == 11 + 2, q{&calc(11, 2, \'+\') = 13}  );
ok( &calc(11, 2, '-') == 11 - 2, q{&calc(11, 2, '-') = 9}     );
ok( &calc(11, 2, '*') == 11 * 2, q{&calc(11, 2, '*') = 22}    );
ok( &calc(11, 2, '/') == 11 / 2, q{&calc(11, 2, '/') = 5}     );
ok( &calc(11, 2, '%') == 11 % 2, q{&calc(11, 2, '%') = 1}     );
ok( &calc(11, 2, '^') == undef,  q{&calc(10, 2, '^') = undef} );

# &array_sum関数のテスト
my @ok_array1 = qw/1 2 3 4 5 6 7 8 9 10/;
my @ok_array2 = qw/1 2 3 4 -5 6 7 8 9 10/;
my @ng_array1 = qw/1 2 3 4 five 6 7 8 9 10/;
my @ng_array2 = qw/1 2 3 4 5.5 6 7 8 9 10/;

ok( &array_sum(@ok_array1) == 55,    q{&array_sum($ok_array1)  = 55});
ok( &array_sum(@ok_array2) == 45,    q{&array_sum($ok_array2)  = 45});
ok( &array_sum(@ng_array1) == undef, q{&array_sum($ng_array1) = undef});
ok( &array_sum(@ng_array2) == undef, q{&array_sum($ng_array2) = undef});

# &find_perl関数のテスト
ok( &find_perl('perl is very good language!') == 1,      q{&find_perl = 1});
ok( &find_perl('pearl is the birthstone of June.') == 0, q{&find_perl = 0});

# &add_strのテスト
my $array_ref = [ qw /perl ruby python/ ];
my $result_ref = ['perl is good!', 'ruby is good!', 'python is good!'];

is_deeply( &add_str($array_ref, ' is good!'), $result_ref, q{&add_str($array_ref, 'is good!') = $result_ref});

# txt2hashのテスト
my $result_ref = {
	apple   => 'iphone',
	samsung => 'galaxy',
	sony    => 'xperia',
	fujitsu => 'arrows',
};

is_deeply( &text2hash('data.txt'), $result_ref, q{&text2hash('data.txt') = $result_ref});

done_testing;

