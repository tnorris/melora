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
