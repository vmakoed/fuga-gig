# frozen_string_literal: true

require_relative 'gig/version'

require_relative 'gig/github_api_client/search'
require_relative 'gig/repositories/avatars_parser'

module Fuga
  module Gig
    class Error < StandardError; end
    # Your code goes here...
  end
end
