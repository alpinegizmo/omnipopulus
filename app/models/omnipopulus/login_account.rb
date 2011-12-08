module Omnipopulus
  class LoginAccount < ActiveRecord::Base
    belongs_to :user, :class_name => '::User'
    serialize :auth_hash

    def self.find_from_auth_hash(auth_hash)
      find_by_remote_account_id(auth_hash['uid'].to_s)
    end

    def self.create_from_auth_hash(auth_hash)
      create do |account|
        account.assign_account_info(auth_hash)
        account.auth_hash = auth_hash if self.attribute_names.include?('auth_hash')
      end
    end

    def save_data(auth_hash)
      self.assign_account_info(auth_hash)
      self.auth_hash = auth_hash if self.class.attribute_names.include?('auth_hash')
      self.save
    end

    def find_or_create_user(session)
      return self.user if self.user

      user = ::User.respond_to?(:create_from_session) ? ::User.create_from_session(session) : ::User.create
      self.user_id = user.id
      self.save
      self.user
    end
  end
end
