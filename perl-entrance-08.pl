use strict;
use warnings;
use utf8;

use Scalar::Util qw(looks_like_number);
use feature qw(switch);

# &sum(x, y);
#   x + y の結果を返す.
# 目的: 関数の宣言, 引数の受け取り方, 返り値の戻し方を復習しよう.
sub sum {
    my $first  = shift // 0;
    my $second = shift // 0;
    die "$first is not numeric" unless looks_like_number($first);
    die "$second is not numeric" unless looks_like_number($second);
    return $first + $second;
}

# &calc(x, y, operator);
#   x operator y の結果を返す.
#   operatorは, '+', '-', '*', '/', '%'を許容する.
#   存在しないoperatorが指定された場合, undefを返す.
# 目的: さまざまな演算子や, if/elsif/elseを使った条件分岐構文について復習しよう.
sub calc {
    my ($lhs, $rhs, $operator) = @_;
    return undef unless looks_like_number($lhs);
    return undef unless looks_like_number($rhs);
    return do {
        given ($operator) {
            when ('+') { $lhs + $rhs }
            when ('-') { $lhs - $rhs }
            when ('*') { $lhs * $rhs }
            when ('/') { $lhs / $rhs }
            when ('%') { $lhs % $rhs }
            default    { undef }
        }
    };
}


# &array_sum(@array);
#   @arrayに含まれる整数の合計を返す.
#   但し, 文字列や小数, 分数などの整数以外が含まれる場合は, undefを返す.
# 目的: 配列の扱い方, for文の使い方を復習しよう.
sub array_sum {
    sub is_int {
        my $value = shift;
        return 0 unless looks_like_number($value);
        return int($value) == $value;
    }
    return undef if grep { not is_int($_) } @_;
    my $sum = 0;
    $sum += $_ for @_;
    return $sum;
}

# &find_perl($str);
#   $strに'perl'という文字列が含まれるなら1を, そうでないなら0を返す.
#   'perl'だけでなく, 'perl is good language!'などでも1が返る.
# 目的: 正規表現を復習しよう.
sub find_perl {
    my $str = shift;
    return 0 unless $str;
    return $str =~ /perl/;
}

# &add_str($array_ref, $str);
#   $array_refが示す配列に含まれる文字列に対して, 後ろに文字列として$strを付け足し, その配列のリファレンスを返す.
# 目的: リファレンスの使い方と, 配列を便利に操作するmap/grepを復習しよう.
sub add_str {
    my ($array_ref, $str) = @_;
    $str //= '';
    return [ map { $_ . $str } @$array_ref ];
}

# &text2hash($file);
#   まず, $fileが示すファイルを開く.
#   次に, その中に含まれる文字列を1行ずつ確認し, '[アルファベット1]:[アルファベット2]'という行があれば,
#   ハッシュに[アルファベット1]をキー, [アルファベット2]を要素として格納する.
#   全ての処理が終われば, このハッシュのリファレンスを返す.
# 目的: ハッシュの使い方や, ファイルの入出力を復習しよう.
sub text2hash {
    my $file = shift;
    open my $fh, "<:utf8", $file
        or die "cannot open file $file: $!";
    return { map { /(\w+)\s*:\s*(\w+)/ ? ($1 => $2) : () } <$fh> };
}

1;
__END__
