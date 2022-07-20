class User < ApplicationRecord
  validates :email, :name, :password, presence: true
end
