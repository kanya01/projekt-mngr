# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :taggings
  has_many :tasks, through: :taggings, source: :taggable, source_type: 'Task'
  has_many :projects, through: :taggings, source: :taggable, source_type: 'Project'
  has_many :wiki_pages, through: :taggings, source: :taggable, source_type: 'WikiPage'
end
