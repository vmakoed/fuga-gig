# frozen_string_literal: true

require 'fuga/gig'

describe Fuga::Gig::Logger do
  describe '.error' do
    it 'outputs error to stdout' do
      expect { described_class.error('message') }
        .to(
          output(a_string_including('message')).to_stdout
        )
    end
  end
end
