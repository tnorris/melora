# frozen_string_literal: true
RSpec.describe Melora::DicePool do
  context 'when told to explod dice with 1 face' do
    subject { Melora::DicePool.new(faces: 1, exploding: true) }

    it 'should raise an error' do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context 'when told to roll fewer than 1 dice' do
    subject { Melora::DicePool.new(number_of_dice: 0) }

    it 'should raise a TypeError' do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context 'when told to roll more than 100 dice' do
    subject { Melora::DicePool.new(number_of_dice: 101) }

    it 'should raise a TypeError' do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context 'when told to roll dice with more than 10000 faces' do
    subject { Melora::DicePool.new(faces: 10_001) }

    it 'should raise a TypeError' do
      expect { subject }.to raise_error(TypeError)
    end
  end

  context 'when passed nonsense sort params' do
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
