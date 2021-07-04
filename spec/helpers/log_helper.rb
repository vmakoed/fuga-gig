# frozen_string_literal: true

module LogHelper
  def log_output
    Fuga::Gig::Logger.instance.log_device.string
  end
end
