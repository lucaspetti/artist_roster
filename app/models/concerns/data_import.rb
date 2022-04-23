# frozen_string_literal: true

module DataImport
  extend ActiveSupport::Concern

  included do
    has_one_attached :file
    validate :valid_file?

    after_create_commit do |record|
      record_job.perform_later(record.id) if record.persisted?
    end
  end

  def record_job
    "#{self.class.name}Job".constantize
  end

  def file_format
    :csv
  end

  def valid_file?
    errors.add(:file, :blank) unless file.attached?
  end
end
