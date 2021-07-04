# frozen_string_literal: true

require 'fuga/gig'
require 'log_setup'

describe Fuga::Gig::Logger do
  describe '.error', :logger do
    it 'outputs error' do
      expect { described_class.error('message') }
        .to(change { log_output }.from('').to(a_string_including('message')))
    end
  end
end
