# frozen_string_literal: true

require 'webmock/rspec'
require 'fuga/gig'

describe Fuga::Gig::Repositories::RemoteAvatarFile do
  describe '#store' do
    subject(:remote_file) do
      described_class.new(
        url: 'https://avatars.githubusercontent.com/u/3220138?v=4',
        local_directory: './topic:ruby-topic:rails'
      )
    end

    let(:file_object) { instance_spy File, write: 5, close: nil }

    before do
      stub_request(:get, 'https://avatars.githubusercontent.com/u/3220138?v=4')
        .to_return(body: 'image', headers: { 'Content-Type' => 'image/png' })

      allow(File).to(
        receive(:open)
          .with('./topic:ruby-topic:rails/3220138.png', 'w')
          .and_return(file_object)
      )

      remote_file.store
    end

    it 'writes to file object' do
      expect(file_object).to have_received(:write).with('image')
    end

    it 'closes file object' do
      expect(file_object).to have_received(:close)
    end
  end
end
