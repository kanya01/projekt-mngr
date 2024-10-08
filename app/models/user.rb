# frozen_string_literal: true

class User < ApplicationRecord
  include Taggable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :projects
  has_many :tasks
  has_many :wiki_pages
  # has_many :tasks, through: :projects

  def admin?
    admin
  end
end
