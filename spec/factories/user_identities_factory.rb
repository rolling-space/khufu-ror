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
FactoryBot.define do
  factory :user_identity do
    user { nil }
    uid { "MyString" }
    provider { "MyString" }
    info { "MyText" }
    token { "MyString" }
    refresh_token { "MyString" }
    first_name { "MyString" }
    last_name { "MyString" }
  end
end
