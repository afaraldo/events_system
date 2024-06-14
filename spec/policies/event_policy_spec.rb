require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:event) { create(:event, user:) }


  permissions :index? do
    it 'allows access to admins' do
      expect(subject).to permit(admin)
    end

    it 'allows access to users' do
      expect(subject).to permit(user)
    end
  end

  permissions :show? do
    it 'allows access to an admin' do
      expect(subject).to permit(admin, event)
    end

    it 'allows access to the event owner' do
      expect(subject).to permit(user, event)
    end

    it 'denies access to other users' do
      other_user = User.create(email: 'other@example.com', password: 'password', role: :user)
      expect(subject).not_to permit(other_user, event)
    end
  end

  permissions :create? do
    it 'allows access to admins' do
      expect(subject).to permit(admin)
    end

    it 'allows access to users' do
      expect(subject).to permit(user)
    end
  end

  permissions :update? do
    it 'allows access to an admin' do
      expect(subject).to permit(admin, event)
    end

    it 'allows access to the event owner' do
      expect(subject).to permit(user, event)
    end

    it 'denies access to other users' do
      other_user = User.create(email: 'other@example.com', password: 'password', role: :user)
      expect(subject).not_to permit(other_user, event)
    end
  end

  permissions :destroy? do
    it 'allows access to an admin' do
      expect(subject).to permit(admin, event)
    end

    it 'allows access to the event owner' do
      expect(subject).to permit(user, event)
    end

    it 'denies access to other users' do
      other_user = User.create(email: 'other@example.com', password: 'password', role: :user)
      expect(subject).not_to permit(other_user, event)
    end
  end

  describe '.scope' do
    let(:scope) { Pundit.policy_scope!(user, Event) }

    it 'includes events created by the user' do
      expect(scope).to include(event)
    end

    it 'includes all events for admin' do
      expect(Pundit.policy_scope!(admin, Event)).to include(event)
    end
  end
end
