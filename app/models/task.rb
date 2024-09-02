class Task < ApplicationRecord
  belongs_to :project
   belongs_to :user
  scope :completed, -> { where(status: 'completed') }

  after_save :update_project_progress
  after_destroy :update_project_progress

  private

  def update_project_progress
    project.save
  end
end
