# frozen_string_literal: true

module Fuga
  module Gig
    # Responsible of handling all the command line interface logic.
    class CLI
      def self.run(args = ARGV)
        APIFilesDownloader.run(query_parameters: args)
      end
    end
  end
end
