# frozen_string_literal: true

require 'webmock/rspec'
require 'fuga/gig'

describe Fuga::Gig::Repositories::RemoteAvatarFile do
  let(:remote_file) do
    described_class.new(
      url: 'https://avatars.githubusercontent.com/u/3220138?v=4',
      local_directory: './topic:ruby-topic:rails'
    )
  end

  before do
    stub_request(:get, 'https://avatars.githubusercontent.com/u/3220138?v=4')
      .to_return(body: 'image', headers: { 'Content-Type' => 'image/png' })
  end

  describe '#persist' do
    subject(:persist_file) { remote_file.persist }

    let(:file_object) { instance_spy File, write: 5, close: nil }

    before do
      allow(File).to(
        receive(:open)
          .with('./topic:ruby-topic:rails/3220138.png', 'w')
          .and_return(file_object)
      )

      persist_file
    end

    it 'writes to file object' do
      expect(file_object).to have_received(:write).with('image')
    end

    it 'closes file object' do
      expect(file_object).to have_received(:close)
    end
  end

  describe '#persisted?' do
    subject { remote_file.persisted? }

    before do
      allow(Dir).to(
        receive(:entries)
          .with('./topic:ruby-topic:rails')
          .and_return(local_entries)
      )
    end

    context 'when file exists in local storage' do
      let(:local_entries) { %w[3220138.png] }

      it { is_expected.to be_truthy }
    end

    context 'when file does not exist in local storage' do
      let(:local_entries) { %w[32201389.png] }

      it { is_expected.to be_falsey }
    end
  end
end
