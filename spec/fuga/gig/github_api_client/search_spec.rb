# frozen_string_literal: true

require 'fuga/gig'
require 'log_setup'
require 'vcr_setup'

describe Fuga::Gig::GithubAPIClient::Search do
  describe '.repositories' do
    subject(:repositories) { described_class.repositories('topic:ruby topic:rails') }

    let(:data) { JSON.load_file('spec/fixtures/repositories.json', symbolize_names: true) }

    it 'downloads repositories data' do
      VCR.use_cassette('github_api_client/search') do
        expect(repositories).to match data
      end
    end

    context 'when rate limit is exceeded', :logger do
      let(:error_message) do
        'Github public API rate limit is exceeded. Rate limit resets at: 2021-07-04 17:37:13 +0200'
      end

      it 'returns empty items' do
        VCR.use_cassette('github_api_client/search/errors/rate') do
          expect(repositories).to match(items: [])
        end
      end

      it 'outputs error message' do
        VCR.use_cassette('github_api_client/search/errors/rate') do
          expect { repositories }
            .to(change { log_output }.from('').to(a_string_including(error_message)))
        end
      end
    end
  end
end
