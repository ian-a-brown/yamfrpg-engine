# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Yamfrpg::Engine::LoginSession, :model do
  describe 'validations' do
    subject(:login_session) { build(:login_session) }

    it do
      user = login_session.user
      is_expected.to belong_to(:user)
      login_session.user = user

      is_expected.to validate_uniqueness_of(:uuid)
      is_expected.to validate_uniqueness_of(:token).scoped_to(:uuid)
    end
  end
end
