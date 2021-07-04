# frozen_string_literal: true

require 'vcr_setup'
require 'fuga/gig'

describe Fuga::Gig::GithubAPIClient::Search do
  describe '.repositories' do
    let(:data) { JSON.load_file('spec/fixtures/repositories.json', symbolize_names: true) }

    it 'downloads repositories data' do
      VCR.use_cassette('github_api_client/search') do
        expect(
          described_class.repositories('topic:ruby topic:rails')
        ).to match data
      end
    end
  end
end
