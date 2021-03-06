require 'rails_helper'

RSpec.describe Payment::BankSlip do
  let!(:plan) { create(:plan) }
  let!(:attributes) { ActionController::Parameters.new(user: user) }
  let!(:user) { create(:user) }

  subject { described_class.new(plan, attributes) }

  describe '#payment_method' do
    it { expect(subject.send(:payment_method)).to eq(:bank_slip) }
  end

  describe '#due_date' do
    it 'returns a hash with due_date of today' do
      expect(Date).to receive(:today).and_return(Date.new(2015, 10, 30))
      expected = { due_date: '30/10/2015' }
      expect(subject.send(:due_date)).to eq(expected)
    end
  end

  describe '#charge_param' do
    it 'returns a hash with method: bank_slip' do
      expect(subject.send(:charge_param)).to eq({ method: 'bank_slip' })
    end
  end
end
