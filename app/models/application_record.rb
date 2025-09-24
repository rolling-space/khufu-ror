# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # This ensures UUIDs are generated before validation
  before_create :generate_uuid, if: -> { id.blank? }

  private

  def generate_uuid
    self.id = SecureRandom.uuid if id.blank?
  end

end
