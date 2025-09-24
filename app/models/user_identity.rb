# frozen_string_literal: true

# == Schema Information
#
# Table name: user_identities
#
#  id            :uuid             not null, primary key
#  first_name    :string
#  info          :text
#  last_name     :string
#  meta_info     :jsonb
#  provider      :string
#  refresh_token :string
#  token         :string
#  uid           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :uuid             not null
#
# Indexes
#
#  index_user_identities_on_provider_and_uid  (provider,uid) UNIQUE
#  index_user_identities_on_refresh_token     (refresh_token) UNIQUE
#  index_user_identities_on_token             (token) UNIQUE
#  index_user_identities_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserIdentity < ApplicationRecord
  belongs_to :user

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }

  serialize :info, coder: JSON

  def self.find_for_oauth(auth)
    find_by(provider: auth.provider, uid: auth.uid.to_s)
  end

  def self.create_for_oauth(user, auth)
    create!(
      user: user,
      provider: auth.provider,
      uid: auth.uid.to_s,
      info: auth.info.to_h
    )
  end
end
