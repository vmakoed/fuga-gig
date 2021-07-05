# frozen_string_literal: true

module Fuga
  module Gig
    module Repositories
      # Represents remote file and provides interface to store the file locally
      class RemoteAvatarFile
        attr_reader :uri, :local_directory

        def initialize(url:, local_directory:)
          @uri = URI(url)
          @local_directory = local_directory
        end

        def persist
          @file = File.open("#{local_directory}/#{basename}.#{extension}", 'w')
          @file.write(response.body)
          true
        rescue StandardError => e
          Logger.warn("Failed to store a remote file locally. Error: #{e.message}")
          false
        ensure
          @file&.close
        end

        def persisted?
          Dir
            .entries(local_directory)
            .any? { |file| file.match(/#{basename}\./) }
        end

        private

        def response
          @response ||= Net::HTTP.get_response(uri)
        end

        def basename
          @basename ||= uri.path.split('/').last
        end

        def extension
          response['content-type'].split('/').last
        end
      end
    end
  end
end
