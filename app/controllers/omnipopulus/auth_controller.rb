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
      account = case request.env['omniauth.auth']['provider']
        when 'twitter' then
          Omnipopulus::TwitterAccount.find_or_create_from_auth_hash(request.env['omniauth.auth'])
        when 'facebook' then
          Omnipopulus::FacebookAccount.find_or_create_from_auth_hash(request.env['omniauth.auth'])
        when 'linked_in' then
          Omnipopulus::LinkedInAccount.find_or_create_from_auth_hash(request.env['omniauth.auth'])
        when 'github' then
          Omnipopulus::GithubAccount.find_or_create_from_auth_hash(request.env['omniauth.auth'])
        when 'angellist' then
          Omnipopulus::AngelListAccount.find_or_create_from_auth_hash(request.env['omniauth.auth'])
      end

      if current_user
        account.user ||= self.current_user # don't overwrite user account that is linked to login account
        account.save
        self.current_user = account.user   # log into associated account
      else
        self.current_user = account.find_or_create_user
      end

      flash[:notice] = 'You have logged in successfully.'
      redirect_back_or_default(root_path)
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
