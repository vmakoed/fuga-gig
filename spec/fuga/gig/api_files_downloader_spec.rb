# frozen_string_literal: true

require 'fuga/gig'

describe Fuga::Gig::APIFilesDownloader do
  describe '.run' do
    let(:search_client) { class_double Fuga::Gig::GithubAPIClient::Search }
    let(:parser) { class_double Fuga::Gig::Repositories::AvatarsParser }
    let(:remote_file_wrapper) { class_double Fuga::Gig::Repositories::RemoteAvatarFile }

    let(:repositories) { instance_double JSON }
    let(:remote_file) { instance_spy Fuga::Gig::Repositories::RemoteAvatarFile, persisted?: persisted }

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

      described_class.run(
        query_parameters: %w[topic:ruby topic:rails],
        search_client: search_client,
        parser: parser,
        remote_file_wrapper: remote_file_wrapper
      )
    end

    context 'when file does not exist in local storage' do
      let(:persisted) { false }

      it 'stores the remote file' do
        expect(remote_file).to have_received(:persist)
      end
    end

    context 'when file exists in local storage' do
      let(:persisted) { true }

      it 'stores the remote file' do
        expect(remote_file).not_to have_received(:persist)
      end
    end
  end
end
