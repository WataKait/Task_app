# デプロイ
## 本環境バージョン情報
- Ruby : 2.6.6
- Ruby on Rails : 6.1.3.2
- heroku : 7.54.0

## 方法
0. ### 前提条件
   - [Git インストール](https://git-scm.com/book/ja/v2/%E4%BD%BF%E3%81%84%E5%A7%8B%E3%82%81%E3%82%8B-Git%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
   - [Heroku CLI インストール](https://devcenter.heroku.com/ja/articles/heroku-cli#download-and-install)
   - [Heroku アカウント登録](https://jp.heroku.com/)
1. ### 準備
   ```shell
   % heroku login
   ```
   email, password などを入力してログイン

   <br>

   ```shell
   % git remote -v
   ```
   この時点で、
   ```shell
   heroku https://git.heroku.com/***.git (fetch)
   heroku https://git.heroku.com/***.git (push)
   ```
   のように表示されたら、

   ```shell
   % git remote rm heroku
   ```
   を実行
   
   <br>

   ```shell
   % heroku create
   (中略)

   https://hogehoge.herokuapp.com/ | https://git.heroku.com/hogehoge.git
   (後略)

   % git remote -v
   heroku https://git.heroku.com/hogehoge.git (fetch)
   heroku https://git.heroku.com/hogehoge.git (push)
   (後略)
   ```
2. ### デプロイ
   ```shell
   % git push heroku master
   ```
   を実行した際、

   ```shell
   remote:  !     The Ruby version you are trying to install does not exist on this stack.
   remote:  !     
   remote:  !     You are trying to install ruby-2.6.3 on heroku-20.
   remote:  !     
   remote:  !     Ruby ruby-2.6.3 is present on the following stacks:
   ```
   のように表示された場合は、ruby のバージョンを上げる <br>
   (上記のバージョンは ruby 2.6.3)
   
   <br>

   無事に push (デプロイ) ができたら、
   ```shell
   % heroku run rake db:migrate
   ```
   を実行

3. ### 確認
   2 のデプロイで実行した `git push heroku master` のメッセージにある、
   ```shell
   remote:        https://hogehoge.herokuapp.com/ deployed to Heroku
   ```
   のリンクへアクセス
   
   <br>

   もしくは、
   ```shell
   % heroku open
   ```
   を実行
