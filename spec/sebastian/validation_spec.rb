require 'spec_helper'
require 'support/dummy_classes'

RSpec.describe Sebastian::Validation do
  describe '#perform' do
    subject { klass.new(foo: value).perform }

    let(:value) { 'foo' }

    context 'when execute not implemented' do
      let(:klass) { DummyBase }
      it { expect { subject }.to raise_error Sebastian::NotImplementedError }
    end

    context 'when there are errors' do
      let(:klass) { DummyValidation }
      let(:value) { nil }
      it { expect(subject.errors).not_to be_empty }
    end

    context 'when there is a result' do
      let(:klass) { DummyValidation }

      it { expect(subject.value).to eq true }
    end
  end
end
