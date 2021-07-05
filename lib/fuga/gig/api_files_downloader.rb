# frozen_string_literal: true

module Fuga
  module Gig
    # Responsible for performing files download based on data received from API
    class APIFilesDownloader
      TAG_SEPARATOR = '-'

      attr_reader :query_parameters, :search_client, :parser, :remote_file_wrapper

      def self.run(...)
        new(...).run
      end

      def initialize(
        query_parameters: [],
        search_client: GithubAPIClient::Search,
        parser: Repositories::AvatarsParser,
        remote_file_wrapper: Repositories::RemoteAvatarFile
      )
        @query_parameters = query_parameters
        @search_client = search_client
        @parser = parser
        @remote_file_wrapper = remote_file_wrapper
      end

      def run
        create_directory
        download
      rescue StandardError => e
        Logger.error(e.message)
      end

      private

      def create_directory
        FileUtils.mkdir_p(directory) unless File.directory?(directory)
      end

      def download
        search_client
          .repositories(query_parameters)
          .then { |response| parser.parse(response) }
          .then { |file_urls| file_urls.map(&method(:url_to_remote_file)) }
          .then { |remote_files| remote_files.reject(&:persisted?) }
          .then { |remote_files| remote_files.each(&:persist) }
      end

      def url_to_remote_file(url)
        remote_file_wrapper.new(url: url, local_directory: directory)
      end

      def directory
        @directory ||= "./#{query_parameters.join(TAG_SEPARATOR)}"
      end
    end
  end
end
