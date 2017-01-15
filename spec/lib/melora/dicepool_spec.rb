# frozen_string_literal: true
RSpec.describe Melora::DicePool do
  context 'when passed invalid params' do
    subject { Melora::DicePool.new(sort: 'bob') }

    it 'should raise an error' do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context 'when passed valid params' do
    subject { Melora::DicePool.new(faces: 12) }

    it 'should not raise an error' do
      expect { subject }.to_not raise_error
    end
  end

  context 'when told to sort in ascending order' do
    subject do
      Melora::DicePool.new(number_of_dice: 100, sort: :asc, exploding: false)
    end

    it 'should be sorted in ascending order' do
      roll = subject.roll
      expect(roll).to eq(roll.sort)
    end
  end

  context 'when told to sort in descending order' do
    subject do
      Melora::DicePool.new(number_of_dice: 100, sort: :desc, exploding: false)
    end

    it 'should be sorted in reverse order' do
      roll = subject.roll
      expect(roll).to eq(roll.sort.reverse)
    end
  end
end
