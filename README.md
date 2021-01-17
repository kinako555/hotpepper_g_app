# README
練習用に作ったホットペッパーグルメの外部APIを使用した検索サイト

## Ver
### OS
Ubuntu18.04

### App
Ruby '2.6.3'
Rails 5
devise
devise_token_auth
etc...

### Cli
Vue Cli 4
javascript
bootstrap 4
etc...

### DB
MySQL 5

## 機能
ユーザー登録(App環境内)
ユーザー認証
店舗検索(外部API)
お気に入り登録

## 環境構築
rails, MySQL, Vueの導入は省略
### DB構築
```bash
$ rails db:create
$ rails db:migrate
```

### APIキー設定
ホットペッパー外部API公式サイトより、ユーザ登録しキーを付与してもらう
credentials.yml.encを削除し
受け取ったキーをcredentials.ymlに入力する
EDITOR="vim" rails credentials:edit
```yml
hotpepper:
    key: 受け取ったキー
```

### サーバー起動

```bash
# bundle install, npm installを済ませた後
# app
$ rails s
# cli
$ npm run serve
```

## 課題
お気に入りテーブル(ユーザとの関連テーブル)がユーザが削除された際に、削除ユーザに紐づくレコードが削除されない



