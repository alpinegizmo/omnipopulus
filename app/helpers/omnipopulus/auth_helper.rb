module Omnipopulus
  module AuthHelper
    def auth_request_path(options = {})
      "/auth/#{options[:service]}"
    end

    def twitter_login_button
      content_tag(:a, content_tag(:span, 'Sign in with Twitter'), :class => 'omnipopulus-button twitter', :href => auth_request_path(:service => 'twitter'), :rel => 'external')
    end

    def facebook_login_button
      content_tag(:a, content_tag(:span, 'Sign in with Facebook'), :class => 'omnipopulus-button facebook', :href => auth_request_path(:service => 'facebook'), :rel => 'external')
    end

    def linkedin_login_button
      content_tag(:a, content_tag(:span, 'Sign in with LinkedIn'), :class => 'omnipopulus-button linkedin', :href => auth_request_path(:service => 'linked_in'), :rel => 'external')
    end

    def github_login_button
      content_tag(:a, content_tag(:span, 'Sign in with Github'), :class => 'omnipopulus-button github', :href => auth_request_path(:service => 'github'), :rel => 'external')
    end

    def angellist_login_button
      content_tag(:a, content_tag(:span, 'Sign in with AngelList'), :class => 'omnipopulus-button angellist', :href => auth_request_path(:service => 'angellist'), :rel => 'external')
    end

    def twitter_connect_button
      content_tag(:a, content_tag(:span, 'Connect to Twitter'), :class => 'omnipopulus-button twitter', :href => auth_request_path(:service => 'twitter'), :rel => 'external')
    end

    def facebook_connect_button
      content_tag(:a, content_tag(:span, 'Connect to Facebook'), :class => 'omnipopulus-button facebook', :href => auth_request_path(:service => 'facebook'), :rel => 'external')
    end

    def linkedin_connect_button
      content_tag(:a, content_tag(:span, 'Connect to LinkedIn'), :class => 'omnipopulus-button linkedin', :href => auth_request_path(:service => 'linked_in'), :rel => 'external')
    end

    def github_connect_button
      content_tag(:a, content_tag(:span, 'Connect to Github'), :class => 'omnipopulus-button github', :href => auth_request_path(:service => 'github'), :rel => 'external')
    end

    def angellist_connect_button
      content_tag(:a, content_tag(:span, 'Connect to AngelList'), :class => 'omnipopulus-button angellist', :href => auth_request_path(:service => 'angellist'), :rel => 'external')
    end
  end
end
