# hubot-response

Slack上からhubotの語彙を増やせるスクリプトを作りました。

--
<Slackでの会話例>
you: @hubot if i say お寿司 you say 食べたい
hubot: OK! お寿司 -> 食べたい !
you: @hubot あーーーお寿司が
hubot: @you 食べたい
you: @hubot shoe me list!
hubot: @you 可愛いは,作れる
応援して,がんばって！
お寿司,食べたい
you: @hubot thanks!
--

responseList.txtに、反応する単語とそれに対する応答がセットで書かれています。
例えば、
「可愛いは,作れる
応援して,がんばって！」などなど。
Slackからbotに向けて、以下のように言うと、このリストに応答セットを追加します。
"@hubot if i say お寿司 you say 食べたい"
というと、
hubotがファイルへ書き込みします。

もし、foreverを利用して起動を永続化していれば、
hubotは自分で再起動したあと、無事に追加したことを伝えます。
（使ったコマンド：forever start -w -c coffee node_modules/.bin/hubot  --adapter slack）
永続化していなければ、hubotを再起動しないとresponseList.txtは再読み込みされません。

英語でコードをあげてみましたが、自分が使っている日本語版では、
24 行目: robot.respond /リスト見せて/i,(msg)->
28 行目: robot.respond /「(.*)」って言ったら「(.*)」って言って/i,(msg) ->
として使っています。
 
・はまったこと１：ループ中に関数を書くとうまく動かない(49行目からのループ)
  理想：ループの添え字(j)が0,1,2...と増えてそれぞれ処理される
  起きたこと：ループ回数がN回のとき、j=Nの処理がN回動く
 　解決：do関数を使って添え字を引数で渡す
  参考：
http://hacknote.jp/archives/848/
http://qiita.com/yasumodev/items/675cda95ca1be39deb6e

・はまったこと２：hubotの、robot.hearに変数を入れたいが、そのまま書くと動かない(53行目)
 　解決：eval関数と#{...}を併用
  参考：
http://stackoverflow.com/questions/34098300/hubot-hear-variable
 
 
 
