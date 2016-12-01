class User < ApplicationRecord
  has_one :teacher
  has_one :student
  has_one :parent
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_hash, presence: true

  def teacher?
    self.teacher != nil
  end

  def student?
    self.student != nil
  end

  def parent?
    self.parent != nil
  end

  def password
    @_password ||= BCrypt::Password.new(password_hash)
  end

  def password=(unhashed_password)
    @_password = BCrypt::Password.create(unhashed_password)
    self.password_hash = @_password
  end
end
