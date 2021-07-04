# frozen_string_literal: true

require 'delegate'
require 'logger'
require 'singleton'

module Fuga
  module Gig
    # Logging to stdout
    class Logger
      include Singleton

      def self.method_missing(symbol, *args)
        instance
          .logger
          .public_send(symbol, *args)
      end

      def self.respond_to_missing?(name, include_private = false)
        instance
          .logger
          .respond_to?(name) || super
      end

      def logger
        @logger ||= ::Logger.new($stdout)
      end
    end
  end
end
