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

        def store
          file = File.open("#{local_directory}/#{filename}", 'w')
          file.write(response.body)
          file.close
        end

        private

        def filename
          @filename ||= "#{basename}.#{extension}"
        end

        def response
          @response ||= Net::HTTP.get_response(uri)
        end

        def basename
          uri.path.split('/').last
        end

        def extension
          response['content-type'].split('/').last
        end
      end
    end
  end
end
