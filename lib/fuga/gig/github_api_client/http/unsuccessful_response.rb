# frozen_string_literal: true

require_relative './response'

module Fuga
  module Gig
    module GithubAPIClient
      module HTTP
        # A wrapper around Net::HTTP::Response providing unsuccessful response handling
        class UnsuccessfulResponse < Response
          RESPONSE_PLACEHOLDER = { items: [] }.freeze

          def body
            RESPONSE_PLACEHOLDER
          end

          def error_message
            body['message']
          end
        end
      end
    end
  end
end
