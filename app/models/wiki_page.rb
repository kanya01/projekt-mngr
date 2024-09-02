# frozen_string_literal: true

class WikiPage < ApplicationRecord
  include Taggable
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  acts_as_taggable_on :tags
end
