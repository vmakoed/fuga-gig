# frozen_string_literal: true

require 'fuga/gig'

describe Fuga::Gig::CLI do
  describe '.run' do
    before do
      allow(Fuga::Gig::APIFilesDownloader).to(
        receive(:run)
          .with(query_parameters: %w[topic:ruby topic:rails])
      )
    end

    it 'executes download command' do
      described_class.run(ARGV.push('topic:ruby', 'topic:rails'))

      expect(Fuga::Gig::APIFilesDownloader).to(
        have_received(:run)
          .with(query_parameters: %w[topic:ruby topic:rails])
      )
    end
  end
end
