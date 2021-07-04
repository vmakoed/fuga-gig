# frozen_string_literal: true

require 'delegate'

module Fuga
  module Gig
    module GithubAPIClient
      module HTTP
        # A wrapper around Net::HTTP::Response providing response handling
        class Response < SimpleDelegator
          def self.for(response)
            case response
            when Net::HTTPSuccess
              SuccessfulResponse
            when Net::HTTPClientError
              unsuccessful_response_for(response)
            else
              self.class
            end.new(response)
          end

          def self.unsuccessful_response_for(response)
            limit = response['X-RateLimit-Remaining']

            if limit.to_i < 1
              RateExceededResponse
            else
              UnsuccessfulResponse
            end
          end
        end
      end
    end
  end
end
