require 'spec_helper'

RSpec.describe Sebastian::Result do
  let(:klass) { described_class.new(value: value, errors: errors) }
  let(:value) { nil }
  let(:errors) { [] }

  describe '#value' do
    subject { klass.value }

    context 'when errors' do
      let(:errors) { [123] }
      it { expect { subject }.to raise_error(Sebastian::ServiceReturnedErrorsError) }
    end

    context 'when ok' do
      let(:value) { 123 }
      it { is_expected.to eq 123 }
    end
  end

  describe '#ok?' do
    subject { klass.ok? }

    context 'when errors empty' do
      it { is_expected.to be true }
    end

    context 'when errors not empty' do
      let(:errors) { [123] }
      it { is_expected.to be false }
    end
  end

  describe '#to_s' do
    subject { klass.to_s }

    context 'when ok' do
      let(:value) { 123 }
      it { is_expected.to eq '#<Sebastian::Result value: 123>' }
    end
  end
end
