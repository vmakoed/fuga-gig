# frozen_string_literal: true

require_relative './unsuccessful_response'

module Fuga
  module Gig
    module GithubAPIClient
      module HTTP
        # A wrapper around Net::HTTP::Response providing unsuccessful response handling
        class RateExceededResponse < UnsuccessfulResponse
          def body
            Logger.warn(
              'Github public API rate limit is exceeded. '\
              "Rate limit resets at: #{reset_time}"
            )

            super
          end

          def reset_time
            self['X-RateLimit-Reset']
              .then(&:to_i)
              .then { |unix_time| Time.at(unix_time) }
          end
        end
      end
    end
  end
end
