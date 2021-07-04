# frozen_string_literal: true

require 'pry'
module Fuga
  module Gig
    module Repositories
      # Responsible for parsing response data received from API
      class AvatarsParser
        attr_reader :response

        def self.parse(...)
          new(...).parse
        end

        def initialize(response)
          @response = response
        end

        def parse
          response
            .fetch(:items, [])
            .map { |item| item.dig(:owner, :avatar_url) }
        end
      end
    end
  end
end
