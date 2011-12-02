module Omnipopulus
  class AngelListAccount < LoginAccount
    def assign_account_info(auth_hash)
      self.login               = auth_hash['uid']
      self.remote_account_id   = auth_hash['uid']
      self.picture_url         = auth_hash['user_info']['image']
      self.name                = auth_hash['user_info']['name']
      self.access_token        = auth_hash['credentials']['token']
      self.access_token_secret = auth_hash['credentials']['secret']
      self.account_url         = auth_hash['user_info']['urls']['AngelList'] if self.class.column_names.include?('account_url')
    end
  
    def account_url
      self.attributes['account_url'] || "http://angel.co/"
    end
  end
end

