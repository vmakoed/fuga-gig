# frozen_string_literal: true

require_relative './response'

module Fuga
  module Gig
    module GithubAPIClient
      module HTTP
        # A wrapper around Net::HTTP::Response providing successful response handling
        class SuccessfulResponse < Response
          def body
            JSON.parse(super, symbolize_names: true)
          end
        end
      end
    end
  end
end
