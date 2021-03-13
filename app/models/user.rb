class User < ApplicationRecord
  # c1　tasksモデルに対して1対多の関係を作るために以下コード
  has_many :tasks, dependent: :destroy

# 　補足　【user.remember_tokenを使えるようにするための仮想属性用の追加カラム】
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  
  # 補足　下の「User.new_token」で作成したランダムなトークンを【ハッシュ化する】ためのメソッド
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 　補足　【ランダムなトークンを作成するため】のメソッド  
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 補足　重要　上のUser.digestとUser.new_tokenで作成した内容を、
  # 【永続セッションのためにハッシュ化したトークンを、データベースに記憶するため】のメソッド
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # 【cookiesに保存されているremember_tokenがデータベースにある
  # remember_digestと一致することを確認】するため（トークン認証）
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
end
