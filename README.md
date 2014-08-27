#TeXReport
TeX書類を簡単に作るためのshellscript・Makefileです。

###主な機能

- Sublime Textで「Command + B」するだけでPDFが作成可能（あるいは、他のエディタからmakeするだけ）
- 図を簡単に挿入可能（PNG、JPEGなどを指定のフォルダに入れておくだけ）
- 句読点「、。」を自動的に全角カンマ・ピリオド「，．」に置換
- 表をCSVファイルから作成・参照可能（エクセル・Numbersから表をコピーしテキストエディタに貼り付けだけで表が作れます）
- Octaveをインストールしている場合、mファイルが生成するグラフを直接貼り付け可能

###使い方

- レポートごとにフォルダ全体をコピー
- report.tex を編集
- makeする (Sublime Textなら、Command + Bを押すだけ)

<!------
###Features

- Insert figures simply
- Create tables simply from CSV files
- Create graphs simply with Octave (Octave installation required)
- Automatically replaces Japanese punctuations "、。" to commas and periods "，．"
- Integrity with Sublime Text to simply compile TeX reports/articles

###Usage
Only 3 simple steps are required:

- Copy the entire directory per report/article
- Edit report.tex
- Press Command + B on Sublime Text (Or use Make)
-->
----
##インストール説明(Mac OS Xの場合)

### TeXのインストール
(既にTeXをインストールしている場合は、次のステップへ)

http://www.tug.org/mactex/ からMacTeXをダウンロードし、TeXに必要なソフトをインストールする。


### Makeのインストール
(既にMakeをインストールしている場合は、次のステップへ)

Apple Accountを取得し、Xcodeをインストールする。（参考：http://www.cse.kyoto-su.ac.jp/~oomoto/lecture/program/tips/Xcode_install/ の、「App StoreによるXcodeのダウンロード」まで。）

インストール後、「Xcode Developer Tools」をインストールする。ここにMakeが入っている。
（参考：http://qiita.com/3yatsu/items/47470091277d46f3fde2）
<!--### ビルドテスト
ターミナルを開く。

TeXReportのフォルダへcdし、　make　コマンドを実行
（やり方：「cd 」（スペースも忘れずに）と打ち、ターミナルの画面上にTeXReportのフォルダをドラッグ＆ドロップし、Enterキーを押す）
-->
### Sublime Textの設定
<!--Sublime Textの設定を行う。
以下を行うと、ターミナルを一切開かなくてもPDF作製が可能となる。Sublimeで編集中に　Command + B　を実行するだけでpdf出力→プレビューが可能となる-->

Sublime Textをインストールする：http://www.sublimetext.com/

Sublime Textの上部メニューから

- Sublime Text 2 -> Preferences -> Settings - User

を選択する。ファイルが現れるので、内容を全て

    {
        "build_env":
        {
            "PATH": "/usr/local/bin:/usr/bin:/bin:/usr/texbin/"
        }
    }

に変更し、保存する。保存後、Sublime Textを終了し、再び開く。

<!--（これは、/bin内のcd、rmコマンドや、/usr/texbin内のdvipdfmxコマンドなどをSublime Textから呼び出すために必要。）
-->
Sublime Textの上部メニューから

Tools -> Build System -> Make

を選択する。

TeXReportのreport.texを開き、適当に編集し、　Command + B　キーを押し、コンパイルされるか試す。

###エラーが出た場合
- File \`dvipdfm.def not found. - 「LaTeXで「File \`dvipdfm.def' not found.」というエラーがでるときの対処法」
http://d.hatena.ne.jp/Yusk/20131016/1381902811
を、　Templates/header.tex　で行う

---
## レポートの作り方
###手順
3ステップでできます。

- レポートごとに、TeXReportフォルダを全てコピーする。TeXReportフォルダの名前は適宜変更してもよい。
- Sublime Textを使って、report.texにTeXを書いていく。
- Command + Bを押すことで、PDFファイルが出力される。

###図、表、グラフの挿入
TeXReportでは、JPG画像やPNG画像をそのままTeX文書に挿入できます。更に、表を簡単に作るマクロを含んでおり、スマートに表が作成できます。また、別途Octaveをインストールすることで、グラフを作るmファイルを記述し、出力されるグラフを直接TeX文書に挿入することができます。

用例など詳しくはreport.texを参照して下さい。

######図の挿入
./Figuresディレクトリ内に画像を入れておく。すると、

	\inputfig{ファイル名.拡張子}{キャプション文章}{倍率}
	\ref{fig:ファイル名.拡張子}

というTeXコマンドで呼び出し・参照が可能。ここで、「倍率」は「0.8」「1」などの数値を入力。

######表の挿入
./TableGenディレクトリ内にCSVファイルを入れておく。すると、

    \inputtable{ファイル名}{キャプション文章}
    \ref{table:ファイル名}

というTeXコマンドで呼び出し・参照が可能。ここで、テーブル名はCSVファイルのファイル名を入力。

######グラフの挿入
Octaveをインストールする。

Makefileのあるディレクトリに、

- GraphGen
- graphs
というディレクトリを作成する。

figure(1)に、所望の図を出力するOctaveスクリプトを作製する。

すると、

    \inputgraph{ファイル名}{キャプション}{0.8}
    \ref{graph:ファイル名}

というTeXコマンドで呼び出し・参照が可能。ここで、「ファイル名」はmファイルのファイル名、「倍率」は「0.8」「1」などの数値を入力。


###Tips
- Templates/header.texから、フォントサイズ、パッケージなどの設定が編集可能。
- Makefile中のREPLACEPUNCを0に設定する事で、「、。」→「，．」の自動置換が無効になります。0以外の値に設定することで有効化されます。
- 困ったときは、ターミナルでTeXReportのディレクトリに移動し、「make clean」を実行して下さい。

----
## 参考文献：

- トリビアなmakefile入門	基本的な知識すべて	http://www.jsk.t.u-tokyo.ac.jp/~k-okada/makefile/
- TeX Wiki Make		.PHONYの使い方	http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?Make
- プログラム問答 別のディレクトリのソース ファイルとメイクファイル	表記法	http://ja.softuses.com/156386
- cockscomb.info Sublime Text 2 と環境変数 http://cockscomb.info/environmental_variable_for_sublime_text_2/
- MacでLaTeX – TeXShopとMacTeX2011編　http://blog.cyclogy.com/2012/02/04/texshop_mactex2011/