# frozen_string_literal: true
RSpec.describe Melora::Traits do
  context 'My valid character sheet' do
    subject { Melora::Traits.new('./spec/fixtures/melora_traits.yaml') }

    it 'should have 2d6 quickness' do
      expect(subject['quickness']).to eq('2d6')
    end
  end

  context 'An invalid character sheet' do
    subject { Melora::Traits.new('/dev/null') }

    it 'should raise an exception if you query a trait' do
      expect { subject['quickness'] }.to raise_error TypeError
    end
  end
end
