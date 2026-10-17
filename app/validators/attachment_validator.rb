class AttachmentValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.attached?
      record.errors.add(attribute, :blank)
      return
    end

    blob = value.blob
    if options[:content_types] && !options[:content_types].include?(blob.content_type)
      record.errors.add(attribute, "must be one of: #{options[:content_types].join(', ')}")
    end
    if options[:max_size] && blob.byte_size > options[:max_size]
      record.errors.add(attribute, "must be smaller than #{ActiveSupport::NumberHelper.number_to_human_size(options[:max_size])}")
    end
  end
end
