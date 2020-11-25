class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites
  has_many :book_comments, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #フォロワー取得
  has_many :following_user, through: :follower, source: :followed # 自分"が"フォローしている人を取得
  has_many :follower_user, through: :followed, source: :follower # 自分"を"フォローしている人を取得

  # ユーザーをフォローする
def follow(user_id)
  follower.create(followed_id: user_id)
end

# ユーザーのフォローを外す
def unfollow(user_id)
  follower.find_by(followed_id: user_id).destroy
end

# フォローしていればtrueを返す
def following?(user)
  following_user.include?(user)
end

# 住所入力関連

#都道府県コードから都道府県名に自動で変換
include JpPrefecture
jp_prefecture :prefecture_code

#~.prefecture_nameで都道府県名を参照出来る様にする。
#例) @user.prefecture_nameで該当ユーザーの住所(都道府県)を表示出来る。

def prefecture_name
  JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
end

def prefecture_name=(prefecture_name)
  self.prefecture_code = JpPrefecture::Prefecture.find(code: prefecture_code).code
end

  attachment :profile_image

  validates :name, presence: true, length: {minimum: 2, maximum: 20}
  validates :introduction, length: {maximum: 50}

end
