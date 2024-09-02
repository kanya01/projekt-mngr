# frozen_string_literal: true

module Taggable
  extend ActiveSupport::Concern

  included do
    acts_as_taggable_on :tags
    after_save :sync_tags
  end

  def sync_tags
    ActsAsTaggableOn::Tag.find_or_create_all_with_like_by_name(tag_list).each do |tag|
      Tag.find_or_create_by(name: tag.name)
      # Add any additional logic here, e.g., updating custom fields on your Tag model
    end
  end
end
