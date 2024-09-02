class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks
  has_rich_text :description

  validates :progress, numericality: { only_integer: true}, allow_nil: true
  validates :user, presence: true

  before_save :update_progress


  def calculate_progress
    def calculate_progress
      Rails.logger.debug { "Calculating progress for project #{id}" }
      return 0 if tasks.empty?
      
      completed_count = tasks.completed.count
      total_count = tasks.count
      
      Rails.logger.debug { "Project #{id}: #{completed_count} completed tasks out of #{total_count} total tasks" }
      
      progress = (completed_count.to_f / total_count * 100).round
      Rails.logger.debug { "Project #{id} progress is #{progress}%" }
      
      progress
    end
  end


  private

  def update_progress
    self.progress = calculate_progress
  end

end
