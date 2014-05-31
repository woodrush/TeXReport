#TeXReport

Features

- Integrity with Sublime Text to simply compile TeX reports/articles
- Insert figures simply
- Make TeX tables simply from CSV
- Make graphs simply with Octave (Octave installation required)
- Simple BibTeX integrity (now in development)
- Automatically replaces Japanese punctuations "、。" to commas and periods "，．"

How to use

- Copy the entire directory per report/article, and edit report.tex

#インストール説明(Mac OS Xの場合)

## TeX導入
MacTeXをダウンロードし、TeXの色々なソフトをインストール
http://www.tug.org/mactex/

## ビルドテスト
ターミナルを開く

TeXReportのフォルダへcdし、　make　コマンドを実行
（やり方：「cd 」（スペースも忘れずに）と打ち、ターミナルの画面上にTeXReportのフォルダをドラッグ＆ドロップし、Enterキーを押す）

！ここでエラーが出たら：
「LaTeXで「File `dvipdfm.def' not found.」というエラーがでるときの対処法」
http://d.hatena.ne.jp/Yusk/20131016/1381902811
を、　scripts/settings.tex　で行う

## Sublime Textの設定
Sublime Textの設定を行う。
以下を行うと、ターミナルを一切開かなくてもPDF作製が可能となる。Sublimeで編集中に　Command + B　を実行するだけでpdf出力→プレビューが可能となる

Sublime Textをインストール（超便利！）
http://www.sublimetext.com/

「Sublime Text 2 と環境変数」
http://cockscomb.info/environmental_variable_for_sublime_text_2/
で、

    {
        "build_env":
        {
            "PATH": "/usr/local/bin:/usr/bin:/bin:/usr/texbin/"
        }
    }

のように設定する。
これを行うことで、/bin内のcd、rmコマンドや、/usr/texbin内のdvipdfmxコマンドなどがSublime Textから呼び出せるようになる

Sublime Textで
Tools -> Build System -> Make
を選択しておく

TeXReportのreport.texを開き、適当に編集し、　Command + B　キーを押し、コンパイルされるか試す。



以上で設定は終わりです。

# レポートの作り方

- レポートごとに、TeXReportフォルダを全てコピーして、作業を開始する。TeXReportフォルダの名前は適宜変えてもよい。
- report.texを編集し、ターミナルでmakeコマンドを実行またはSublime Textからビルドするとpdfが出力される。
- report.texと同じディレクトリ内に他の.texファイルを作り、\input{./~~.tex}で呼び出せるので、ファイル分割が可能。
  例えばここでは、図表の挿入だけfigures.texに分割している。
  章毎にTeXソースを作るなど、様々な分割が可能。
- scripts/settings.texからパッケージなどの設定が編集可能
- report.texを消す → report2.texの名前をreport.texに変える → 新しいreport.texを開き、適当に編集し、ビルド
  を行うと、章立てのレポート風の文書サンプルが現れます。
- 困ったときは、ターミナルでTeXReportのディレクトリに移動し、「make clean」を実行して下さい。


テーブル、図の作り方（report2.tex参照）

- テーブル：TableGenディレクトリ内にCSVファイルを入れておくことで、\inputtableというTeXコマンドで表を出力可能。
- 図：Figures内に画像を入れておくことで、\inputfigというTeXコマンドで図を出力可能。

## 設定
- Makefile中のREPLACEPUNCを0に設定する事で、「、。」→「，．」の自動置換が無効になります。0以外の値に設定することで有効化されます。

# 参考文献：

- トリビアなmakefile入門	基本的な知識すべて	http://www.jsk.t.u-tokyo.ac.jp/~k-okada/makefile/
- TeX Wiki Make		.PHONYの使い方	http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?Make
- プログラム問答 別のディレクトリのソース ファイルとメイクファイル	表記法	http://ja.softuses.com/156386
- cockscomb.info Sublime Text 2 と環境変数 http://cockscomb.info/environmental_variable_for_sublime_text_2/
- MacでLaTeX – TeXShopとMacTeX2011編　http://blog.cyclogy.com/2012/02/04/texshop_mactex2011/