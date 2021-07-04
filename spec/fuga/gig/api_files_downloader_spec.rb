# frozen_string_literal: true

require 'fuga/gig'

describe Fuga::Gig::APIFilesDownloader do
  describe '.run' do
    let(:search_client) { class_double Fuga::Gig::GithubAPIClient::Search }
    let(:parser) { class_double Fuga::Gig::Repositories::AvatarsParser }
    let(:remote_file_wrapper) { class_double Fuga::Gig::Repositories::RemoteAvatarFile }

    let(:repositories) { instance_double JSON }
    let(:remote_file) { instance_spy Fuga::Gig::Repositories::RemoteAvatarFile }

    before do
      allow(search_client).to(
        receive(:repositories)
          .with(%w[topic:ruby topic:rails])
          .and_return(repositories)
      )

      allow(parser).to(
        receive(:parse)
          .with(repositories)
          .and_return(%w[url])
      )

      allow(remote_file_wrapper).to(
        receive(:new)
          .with(url: 'url', local_directory: './topic:ruby-topic:rails')
          .and_return(remote_file)
      )

      allow(remote_file).to receive(:store)

      described_class.run(
        query_parameters: %w[topic:ruby topic:rails],
        search_client: search_client,
        parser: parser,
        remote_file_wrapper: remote_file_wrapper
      )
    end

    it 'stores the remote file' do
      expect(remote_file).to have_received(:store)
    end
  end
end
