use strict;
use warnings;

# &sum(x, y);
#   x + y の結果を返す.
# 目的: 関数の宣言, 引数の受け取り方, 返り値の戻し方を復習しよう.
sub sum {

}

# &calc(x, y, operator);
#   x operator y の結果を返す.
#   operatorは, '+', '-', '*', '/', '%'を許容する.
#   存在しないoperatorが指定された場合, undefを返す.
# 目的: さまざまな演算子や, if/elsif/elseを使った条件分岐構文について復習しよう.
sub calc {

}


# &array_sum(@array);
#   @arrayに含まれる整数の合計を返す.
#   但し, 文字列や小数, 分数などの整数以外が含まれる場合は, undefを返す.
# 目的: 配列の扱い方, for文の使い方を復習しよう.
sub array_sum {

}

# &find_perl($str);
#   $strに'perl'という文字列が含まれるなら1を, そうでないなら0を返す.
#   'perl'だけでなく, 'perl is good language!'などでも1が返る.
# 目的: 正規表現を復習しよう.
sub find_perl {

}

# &add_str($array_ref, $str);
#   $array_refが示す配列に含まれる文字列に対して, 後ろに文字列として$strを付け足し, その配列のリファレンスを返す.
# 目的: リファレンスの使い方と, 配列を便利に操作するmap/grepを復習しよう.
sub add_str {

}

# &text2hash($file);
#   まず, $fileが示すファイルを開く.
#   次に, その中に含まれる文字列を1行ずつ確認し, '[アルファベット1]:[アルファベット2]'という行があれば,
#   ハッシュに[アルファベット1]をキー, [アルファベット2]を要素として格納する.
#   全ての処理が終われば, このハッシュのリファレンスを返す.
# 目的: ハッシュの使い方や, ファイルの入出力を復習しよう.
sub text2hash {

}

1;
__END__
