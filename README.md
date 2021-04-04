# Sharing Portfolio

## サービス概要
「Sharing Portfolio」は、個人開発アプリケーションとして完全独学で制作した自作のWEBアプリケーションです。
自作したポートフォリオを共有することができます。 

<img width="1439" alt="sp-top" src="https://user-images.githubusercontent.com/72332802/113473475-af358600-94a4-11eb-9f7f-29aa7558e9bc.png">


## URL
https://www.sharing-portfolio.site/  

ログイン画面と新規登録画面にゲストログインボタンを設置しております。  
ゲストログインボタンより、メールアドレスとパスワードを入力せずにログインできます。



## 作成した背景
私がポートフォリオを作成しようと思っていた時、「どんなポートフォリオを作成しよう。」、「他の人たちはどんなポートフォリオを作っているのだろう。」と感じていました。
そんな中私は、<span style="color: red; ">作成したポートフォリオを共有できるサイト</span>があれば何かと便利なのではないかと考えました。  
ポートフォリオを共有できるサイトは、<span style="color: red; ">**閲覧者**</span>と<span style="color: red; ">**投稿者**</span>の両者にもメリットがあると思ったからです。  

まず**閲覧者**のメリットに関しては、私自身もそうであったかのように他の人が実際にどのようなポートフォリオを作っているのか気になる人にとって役立つと思ったからです。  

反対に**投稿者**のメリットに関してです。ポートフォリオは一体なんのために作成するものなのかを考えた時に、作成者は必ずこう思います。「多くのユーザーに使ってもらいたい」。ユーザーに使われなければそのサービスはなんの意味もありません。なので、投稿者は共有サイトに自分の作成したポートフォリオを投稿することで多くのユーザーに広められ、使ってもらえると思ったためです。

実際にどんなポートフォリオを自分が作ったら多くの人に使ってもらえるかを考えた時に、<span style="color: red; ">「これしかない。」</span>と思い、Sharing Portfolioを作ることを決意しました。


## こだわりポイント
1. CI/CD パイプラインの構築
2. 開発環境にDockerを使用
3. 見やすさ/使いやすさを重視した、シンプルなUIを実現
4. Rspecを使用してテストコード記載し、品質を担保
5. Rubocopを導入し、コードの品質を担保
6. 一部機能(いいね、コメント、フォロー)を非同期化し、利便性向上
7. 本番運用を意識した管理者機能の実装
8. 環境変数を使用し、機密情報を格納する
9. Twitter認証/GitHub認証を導入し、利便性向上
10. Githubでissueベース/セルフプルリクエストを使用し、チーム開発を意識


## 使用技術・環境
### フロントエンド
- HTML  
- SCSS  
- javascript  
- jquery  
- Bootstrap  

### バックエンド
- Ruby (2.6.6)  
- Ruby on Rails (6.0.3)  

### データベース
- MySQL2

### 開発環境
- Docker, Docker-compose

### 本番環境
- AWS
  - (VPC / EC2 / ELB / ACM / Route53 / S3)
- Nginx
- Unicorn
- Capistrano3
- CircleCI/CD

### テスト
- Rspec (計127項目）
- CirclCIにて自動テストを実行

### その他の技術
- GItHubの活用(pull request, issue等)
- Rubocopによるコード解析、修正
- TwitterAPI、GitHubAPIの活用

### インフラ構成
<img width="972" alt="Infrastructure-configuration" src="https://user-images.githubusercontent.com/72332802/113469623-f6fae400-9489-11eb-8570-c3e7419040da.png">


  
## 機能一覧
### ユーザー機能
- devise gemを使用
  - (新規登録機能 / 編集機能 / ログイン / ログアウト)
- ユーザー詳細表示
- アカウント削除
- ゲストログイン機能
- Twitter認証機能
- GitHub認証機能

### ポートフォリオ投稿機能
- 投稿一覧表示 / 投稿詳細表示 / 投稿編集機能 / 投稿削除機能
- 投稿プレビュー機能
- 画像プレビュー機能
- carrierwave gemを使用し、画像アップロード機能
- SNS共有機能
- ページネーション機能

### いいね機能
- 非同期で実装
- いいね / いいね取り消し / いいね一覧表示
- 投稿を人気順(いいねが多い順)に表示
- いいね数を表示

### ストック機能
- 非同期で実装
- ストック / ストック取り消し / ストック一覧表示
- ストック数を表示

### コメント機能
- 非同期で実装
- 投稿詳細画面にコメント投稿 / コメント削除 / コメント表示  
- コメント数表示

### フォロー機能
- 非同期で実装
- フォロー / フォロー解除 / フォロー・フォロワー一覧表示
- フォローしたユーザーの投稿を表示

### タグ機能
- acts-as-taggable-on gemを使用
- tag-itをを導入し、UIの見栄えを整える
- 投稿に複数タグを付与することが可能 (10個まで)
- タグ名は自由に入力可能
- 同じタグは入力不可
- タグ毎に投稿を表示

### 通知機能
- いいね、コメント、フォローされたら通知を受け取る
- 通知が未読の場合、通知マークの色を変更させる

### 問い合わせ機能
- googleフォームを利用

### 管理者機能
- ユーザー管理 
- 投稿管理
- コメント管理

### DM機能
- １体１のチャット機能を実装

### HTTPS通信の実装
- HTTPS通信の実装


## 使用した主なGem
- devise              (ユーザーログイン機能)
- dotenv-rails        (環境変数)
- carrierwave         (画像投稿)
- omniauth-twitter    (Twitter認証)
- omniauth-github     (GitHub認証)
- acts-as-taggable-on (タグ機能)
- jquery-ui-rails     (タグのUIを整える)
- rails-i18n          (日本語化)
- fog-aws             (S3の使用)
- rspec-rails         (テストコード)
- factory_bot_rails   (テストデータ作成)
- kaminari            (ページネーション)
- jquery-rails        (jqueryの使用)
- rubocop             (コード解析)
- capistrano          (capistranoの使用)
- unicorn             (本番環境にunicornを使用)

## ER図
<img width="1236" alt="ER図" src="https://user-images.githubusercontent.com/72332802/113408128-c499aa00-93e9-11eb-9ace-dd9d8117a51e.png">


## 今後実装したいこと
- SEO対策  
- Vue.jsを導入し、SPA化を実現して利便性向上 
- レスポンシブ対応  
- ECSを利用したインフラ構築  


## 作成者
板本 耕輔  
mail : kosuke.723723@gmail.com
