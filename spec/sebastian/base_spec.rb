require 'spec_helper'
require 'support/dummy_classes'

RSpec.describe Sebastian::Base do
  describe '.perform' do
    context 'when implemented' do
      subject { DummyExecuteBase.perform(foo: 'bar') }

      it { is_expected.to be_an Sebastian::Result }
    end

    context 'when not implemented' do
      subject { DummyBase.perform(foo: 'bar') }

      it { expect { subject }.to raise_error Sebastian::NotImplementedError }
    end
  end

  describe '#perform' do
    subject { klass.new(foo: 'bar').perform }

    context 'when execute not implemented' do
      let(:klass) { DummyBase }

      it { expect { subject }.to raise_error Sebastian::NotImplementedError }
    end

    context 'when execute implemented' do
      let(:klass) { DummyExecuteBase }

      it { is_expected.to be_an Sebastian::Result }
    end

    context 'when there are errors' do
      let(:klass) { DummyErrorBase }

      it { expect(subject.errors).not_to be_empty }
    end

    context 'when there is a result' do
      let(:klass) { DummyExecuteBase }

      it { expect(subject.value).to eq 123 }
    end
  end

  describe '#perform!' do
    subject { klass.new(foo: 'bar').perform! }

    context 'when there are errors' do
      let(:klass) { DummyErrorBase }

      it { expect { subject }.to raise_error Sebastian::InvalidResultError }
    end

    context 'when there is a result' do
      let(:klass) { DummyExecuteBase }

      it { expect(subject).to eq 123 }
    end
  end

  describe '#initialize' do
    subject { klass.perform }

    context 'when called on class' do
      let(:klass) { DummyBase }

      it { expect { subject }.to raise_error Sebastian::NotImplementedError }
    end

    context 'when called on instance' do
      let(:klass) { DummyBase.new }

      it { expect { subject }.to raise_error Sebastian::NotImplementedError }
    end
  end
end
