# frozen_string_literal: true

require_relative 'gig/version'

require_relative 'gig/api_files_downloader'
require_relative 'gig/cli'
require_relative 'gig/github_api_client/search'
require_relative 'gig/repositories/avatars_parser'
require_relative 'gig/repositories/remote_avatar_file'

module Fuga
  module Gig
    class Error < StandardError; end
    # Your code goes here...
  end
end
