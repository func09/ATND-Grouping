ATND GROUPING
=============

ATNDイベント参加者をランダムにグループ別けするツールです。

例えばこんなときに便利
-----------

- いくつかのテーブルが用意されている会場での席決め。
- グループで行うハンズオンセミナーなどのグループ分け。
- 顔見知り同士が固まらない、一人ぼっちの人ができないなど、参加者への配慮。

使い方
---

1. 「URL」にATNDで立てたイベントのURLを貼りつけ。
2. 「GROUPS」でグループ数を選択。
3. シャッフルボタンをクリック。
4. 表示されたグループ分けでよかったら「確定」をクリック。やり直す場合は「やり直す」をクリック。
5. 「確定」をクリックして表示されたページの最下部にあるTweetボタンからそのページをTweetして参加者に告知。

ローカルでの立ち上げ方
-----------

### ターミナル1

    $ git clone git@github.com:func09/ATND-Grouping.git
    $ cd ATND-Grouping
    $ bundle%
    
### ターミナル2

ターミナル1は開いたまま、もう一つターミナルを立ち上げ、そこでmongoDBを立ち上げる。

    $ cd ATND-Grouping
    $ mongod

### ターミナル1

ターミナル1に戻り、railsサーバを立ち上げる。

    $ rails s

ライセンス
-----

Copyright (c) 2011 @func09 (https://twitter.com/func09).

MIT License (http://www.opensource.org/licenses/mit-license.php)