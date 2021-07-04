# frozen_string_literal: true

require 'fuga/gig/logger'
require_relative 'helpers/log_helper'

RSpec.configure do |config|
  config.before(:each, :logger) do
    # suppress write to STDOUT and give ability to verify logger output
    Fuga::Gig::Logger.instance.instance_variable_set(
      :@log_device, StringIO.new
    )

    # reset logger to use the new output
    Fuga::Gig::Logger.instance.instance_variable_set(
      :@logger, nil
    )
  end

  config.include LogHelper
end
