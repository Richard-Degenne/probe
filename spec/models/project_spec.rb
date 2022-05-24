# frozen_string_literal: true

describe Project, type: :model do
  subject(:project) { build(:project, name:) }

  let(:name) { 'name' }

  describe '#valid?' do
    subject(:valid?) { project.valid? }

    it { is_expected.to be true }

    context 'without a name' do
      let(:name) { nil }

      it { is_expected.to be false }
    end
  end
end
