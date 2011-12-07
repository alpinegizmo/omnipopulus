module Omnipopulus
  class AuthController < ApplicationController

    unloadable

    def new
      if current_user?
        flash[:notice] = 'You are already signed in. Please sign out if you want to sign in as a different user.'
        redirect_to(root_path)
      end
    end
    
    def add
      if current_user?
        render :new
      else
        redirect_to(root_path)
      end
    end

    def callback
      account_classes = { 
        'twitter' => Omnipopulus::TwitterAccount,
        'facebook' => Omnipopulus::FacebookAccount,
        'linked_in' => Omnipopulus::LinkedInAccount,
        'github' => Omnipopulus::GithubAccount,
        'angellist' => Omnipopulus::AngelListAccount 
      }

      auth_hash = request.env['omniauth.auth']
      account_class = account_classes[auth_hash['provider']]
      account = account_class.find_from_auth_hash(auth_hash) || account_class.create_from_auth_hash(auth_hash)
      account.save_data(auth_hash)

      if current_user
        account.user ||= self.current_user # don't overwrite user account that is linked to login account
        account.save
        self.current_user = account.user   # log into associated account
      else
        begin
          self.current_user = account.find_or_create_user(session)
        rescue InvitationMissing => e
          flash[:notice] = e.message
          redirect_to root_path and return
        end
      end

      flash[:notice] = 'You have logged in successfully.'
#      redirect_back_or_default(root_path)
      redirect_to root_path
    end

    def failure
      flash[:error] = "We had trouble signing you in. Did you make sure to grant access? Please select a service below and try again."
      render :action => 'new'
    end

    def destroy
      logout!
      redirect_to(root_path)
    end
  end
end
