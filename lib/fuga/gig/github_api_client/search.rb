# frozen_string_literal: true

require 'net/http'
require 'json'

require_relative 'http/response'

module Fuga
  module Gig
    module GithubAPIClient
      # Interface for Github Search API Client (https://docs.github.com/en/rest/reference/search)
      class Search
        API_URL = 'https://api.github.com/search'
        HEADERS = {
          Accept: 'application/json'
        }.freeze

        attr_reader :query

        def self.repositories(query)
          new(query).repositories
        end

        def initialize(query)
          @query = query
        end

        def repositories
          parse_uri("#{API_URL}/repositories", { q: query })
            .then(&method(:get))
        end

        private

        def parse_uri(url, params)
          URI.parse(url).tap do |url_object|
            url_object.query = URI.encode_www_form(params)
          end
        end

        def get(url)
          Net::HTTP
            .get_response(url, HEADERS)
            .then { |response| GithubAPIClient::HTTP::Response.for(response) }
            .body
        rescue SocketError => e
          Logger.error('Could not connect to Github API. Please check your internet connection.')
          raise(e)
        end
      end
    end
  end
end
