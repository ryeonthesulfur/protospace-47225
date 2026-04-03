## ER図 テーブル設計

### usersテーブル

| カラム名            | 型     | オプション                      |
| ------------------ | ------ | ----------------------------- |
| email              | string | null: false, unique: true     |
| encrypted_password | string | null: false                   |
| name               | string | null: false                   |
| profile            | text   | null: false                   |
| occupation         | text   | null: false                   |
| position           | text   | null: false                   |

### Association

- has_many :prototypes
- has_many :comments


### prototypesテーブル

| カラム名     | 型         | オプション                          |
| ---------- | ---------- | ---------------------------------- |
| title      | string     | null: false                        |
| catch_copy | text       | null: false                        |
| concept    | text       | null: false                        |
| user       | references | null: false, foreign_key: true     |

※imageはActiveStorageで実装するため含まない

### Association

- has_many :comments
- has_one_attached :image
- belongs_to :user


### commentsテーブル

| カラム名   | 型          | オプション                          |
| --------- | ---------- | ---------------------------------- |
| content   | text       | null: false                        |
| prototype | references | null: false, foreign_key: true     |
| user      | references | null: false, foreign_key: true     |

### Association

- belongs_to :prototype
- belongs_to :user


### テーブル間の関連

- users 1対多 prototypes
- users 1対多 comments
- prototypes 1対多 comments




RailsでActiveStorageを使用して画像を1枚紐付ける場合、
モデルには通常の has_one ではなく has_one_attached :image と記述します。

なぜなら、Railsでは、has_one :image と書いてしまうと、Image という独立したモデル（テーブル）が別に存在し、
それと1対1で紐づくような誤解を生む可能性があります。
ですので、設計書（README）上も実装に合わせて has_one_attached :image に変更しておくのが最も正確で親切です。