# frozen_string_literal: true

require 'fuga/gig'

describe Fuga::Gig::Repositories::AvatarsParser do
  describe '.parse' do
    subject { described_class.parse(data) }

    let(:data) { JSON.load_file('spec/fixtures/repositories.json', symbolize_names: true) }
    let(:urls) do
      %w[
        https://avatars.githubusercontent.com/u/4223?v=4
        https://avatars.githubusercontent.com/u/3220138?v=4
        https://avatars.githubusercontent.com/u/1086321?v=4
        https://avatars.githubusercontent.com/u/59584037?v=4
        https://avatars.githubusercontent.com/u/293207?v=4
        https://avatars.githubusercontent.com/u/56702?v=4
        https://avatars.githubusercontent.com/u/814570?v=4
        https://avatars.githubusercontent.com/u/5637951?v=4
        https://avatars.githubusercontent.com/u/59584037?v=4
        https://avatars.githubusercontent.com/u/6183?v=4
        https://avatars.githubusercontent.com/u/6412038?v=4
        https://avatars.githubusercontent.com/u/75613?v=4
        https://avatars.githubusercontent.com/u/10871348?v=4
        https://avatars.githubusercontent.com/u/38986600?v=4
        https://avatars.githubusercontent.com/u/14028?v=4
        https://avatars.githubusercontent.com/u/6183?v=4
        https://avatars.githubusercontent.com/u/2231765?v=4
        https://avatars.githubusercontent.com/u/67860375?v=4
        https://avatars.githubusercontent.com/u/24639960?v=4
        https://avatars.githubusercontent.com/u/339098?v=4
        https://avatars.githubusercontent.com/u/11045486?v=4
        https://avatars.githubusercontent.com/u/491?v=4
        https://avatars.githubusercontent.com/u/6183?v=4
        https://avatars.githubusercontent.com/u/100721?v=4
        https://avatars.githubusercontent.com/u/6183?v=4
        https://avatars.githubusercontent.com/u/15225?v=4
        https://avatars.githubusercontent.com/u/32438445?v=4
        https://avatars.githubusercontent.com/u/6764390?v=4
        https://avatars.githubusercontent.com/u/1067733?v=4
        https://avatars.githubusercontent.com/u/11925359?v=4
      ]
    end

    it { is_expected.to eq urls }
  end
end
