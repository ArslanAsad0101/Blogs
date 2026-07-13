class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_create :set_default_role

  enum :role, {
    admin: 0,
    author: 1,
    reader: 2
  }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable, :confirmable, :lockable

  private

  def set_default_role
    self.role ||= :reader
  end
end