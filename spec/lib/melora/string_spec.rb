# frozen_string_literal: true

RSpec.describe 'Melora::String.parse_d_notation_string' do
  context 'when passed garbage' do
    subject { Melora::String.parse_d_notation_string 'asdf' }

    it 'should raise a TypeError' do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context 'when number of dice is omitted' do
    subject { Melora::String.parse_d_notation_string 'd6' }

    it 'should roll one die' do
      expect(subject).to include(number_of_dice: 1)
    end
  end

  context 'when number of faces is omitted' do
    subject { Melora::String.parse_d_notation_string '3d' }

    it 'should raise a TypeError' do
      expect { subject }.to raise_error(TypeError)
    end
  end
end

RSpec.describe 'Melora::String.old_timey_cowboyize' do
  subject { Melora::String.old_timey_cowboyize string }

  context 'when a word ends in ing' do
    let(:string) { 'i am testing this thing' }

    it "drops the g and adds an apostrophe: testin'" do
      is_expected.to eq("i am testin' this thin'")
    end
  end

  context 'when no word ends in ing' do
    let(:string) { 'howdy partner' }

    it 'leaves the words alone' do
      is_expected.to eq('howdy partner')
    end
  end
end
