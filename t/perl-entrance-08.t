use Test::More;
use Test::Exception;
use utf8;

my $builder = Test::More->builder;
binmode $builder->output,         ":utf8";
binmode $builder->failure_output, ":utf8";
binmode $builder->todo_output,    ":utf8";

require_ok( 'perl-entrance-08.pl' );

# &sum関数のテスト
subtest "sum関数は2引数の和を求める" => sub {
    cmp_ok( sum(1, 1),  '==',  1 + 1);
    cmp_ok( sum(1.5, 2.5), '==', 4);
    subtest "引数が足りなければ0が渡されたと考える" => sub {
        cmp_ok( sum(3), '==', 3);
        cmp_ok( sum(), '==', 0);
    };
    subtest "数値以外が渡されると例外を投げる" => sub {
        dies_ok { sum(10, "two") };
    };
};

# &calc関数のテスト
subtest "第三引数に指定された演算子に従って計算する" => sub {
    cmp_ok(calc(11, 2, '+'), '==', 13);
    cmp_ok(calc(11, 2, '-'), '==', 9);
    cmp_ok(calc(11, 2, '*'), '==', 22);
    cmp_ok(calc(11, 2, '/'), '==', 5.5);
    cmp_ok(calc(11, 2, '%'), '==', 1);
    subtest "第三引数に指定された演算子が不正であれば undef を返す" => sub {
        is(calc(11, 2, '^'), undef);
    };
    subtest "第一、第二引数が数値でなければ undef を返す" => sub {
        is(calc(11, "two", '+'), undef);
    };
};

# &array_sum関数のテスト
subtest "引数の合計を計算する" => sub {
    cmp_ok(array_sum(), '==', 0);

    my @one_to_ten = qw/1 2 3 4 5 6 7 8 9 10/;
    cmp_ok(array_sum(@one_to_ten), '==', 55);

    my @one_to_ten_with_minus5 = qw/1 2 3 4 -5 6 7 8 9 10/;
    cmp_ok(array_sum(@one_to_ten_with_minus5), '==', 45);

    subtest "引数に文字列や小数が含まれている場合は undef を返す" => sub {
        my @array_with_string = qw/1 2 3 4 five 6 7 8 9 10/;
        is(array_sum(@array_with_string), undef);

        my @array_with_fraction = qw/1 2 3 4 5.5 6 7 8 9 10/;
        is(array_sum(@array_with_fraction), undef);
    };
};

# &find_perl関数のテスト
subtest "'perl' 文字列が含まれるかどうかを検査する" => sub {
    ok(not find_perl());
    ok(find_perl('perl is very good language!'));
    ok(not find_perl('pearl is the birthstone of June.'));
    subtest "大文字／小文字は区別される" => sub {
        ok(not find_perl('Perl is very good language!'));
    };
};

# &add_strのテスト
subtest "配列の末尾に指定された文字列を付与する" => sub {
    is_deeply(add_str([qw/ac u nop/ ], '-op'), [qw/ac-op u-op nop-op/]);
    subtest "元の配列は変更されない" => sub {
        my @original_array = qw/ac u nop/;
        add_str(\@original_array, '-op');
        is_deeply(\@original_array, [qw/ac u nop/]);
    };
    subtest "第二引数がない場合は内容が同じ配列が複製される" => sub {
        my @original_array = qw/ac u nop/;
        my $copied_array_ref = add_str(\@original_array);
        is_deeply($copied_array_ref, \@original_array);
        isnt($copied_array_ref, \@original_array);
    };
};

# txt2hashのテスト
subtest "与えられたファイルに格納された : 区切りのリストをハッシュにする" => sub {
    my $file_data = <<DATA;
apple:iphone
samsung:galaxy
sony:xperia
fujitsu:arrows
DATA
    my $result_ref = {
        apple   => 'iphone',
        samsung => 'galaxy',
        sony    => 'xperia',
        fujitsu => 'arrows',
    };

    is_deeply(text2hash(\$file_data), $result_ref);

    subtest "行の前後の空白は無視される" => sub {
        my $file_data = <<DATA;
  apple:iphone
DATA
        is_deeply(text2hash(\$file_data), { apple => 'iphone' });
    };

    subtest "':' のない行は無視される" => sub {
        my $file_data = <<DATA;
apple:iphone
sony -> experia
DATA
        is_deeply(text2hash(\$file_data), { apple => 'iphone' });
    };
    subtest "':' の前後の空白も無視される" => sub {
        my $file_data = <<DATA;
  apple : iphone
DATA
        is_deeply(text2hash(\$file_data), { apple => 'iphone' });
    };
    subtest "指定されたファイルが存在しない場合は例外が投げられる" => sub {
        dies_ok { text2hash("not_existing_file.txt") };
    };
};

done_testing;

