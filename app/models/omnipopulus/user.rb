module Omnipopulus
  class User < ActiveRecord::Base
    self.abstract_class = true
    
    has_many :login_accounts, :class_name => 'Omnipopulus::LoginAccount', :dependent => :destroy
    delegate :login, :name, :picture_url, :account_url, :access_token, :access_token_secret, :to => :login_account

    def to_param
      if !self.login.include?('profile.php?')
        "#{self.id}-#{self.login.gsub('.', '-')}"
      else
        self.id.to_s
      end
    end
    
    def login_account
      login_accounts.first
    end

    def method_missing(method_name, *args, &block)
      if (account_type = method_name.to_s.match(/from_([^?]*)\?/))
        account_class = account_type[1].to_s.classify + 'Account'
        class_eval <<-DEF, __FILE__, __LINE__
          def #{method_name}
            login_accounts.any? { |login_account| login_account.kind_of?(Omnipopulus::#{account_class}) }
          rescue NameError
            false
          end
        DEF
        send(method_name)
      else
        super
      end
    end

    # def from_twitter?
    #   login_account.kind_of? TwitterAccount
    # end
    # 
    # def from_facebook?
    #   login_account.kind_of? FacebookAccount
    # end
    # 
    # def from_linked_in?
    #   login_account.kind_of? LinkedInAccount
    # end
    # 
    # def from_github?
    #   login_account.kind_of? GithubAccount
    # end
    # 
    # def from_angel_list?
    #   login_account.kind_of? AngelListAccount
    # end

    def remember
      update_attributes(:remember_token => ::BCrypt::Password.create("#{Time.now}-#{self.login_account.type}-#{self.login}")) unless new_record?
    end

    def forget
      update_attributes(:remember_token => nil) unless new_record?
    end
  end
end
