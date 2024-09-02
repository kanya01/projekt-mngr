# frozen_string_literal: true

require 'acts-as-taggable-on'
class Task < ApplicationRecord
  # include Taggable
  belongs_to :project
  belongs_to :user
  has_rich_text :description
  scope :completed, -> { where(status: 'completed') }
  acts_as_taggable_on :tags

  after_save :update_project_progress
  after_destroy :update_project_progress

  private

  def update_project_progress
    project.save
  end
end
