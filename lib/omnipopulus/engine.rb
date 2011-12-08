require 'omnipopulus'

require 'rails'
require 'action_controller'

require 'omniauth/core'
require 'omniauth/oauth'
require 'bcrypt'

module Omnipopulus
  class Engine < Rails::Engine

    config.to_prepare do
      ApplicationController.helper(Omnipopulus::AuthHelper)
    end

    initializer 'omnipopulus.load_middleware', :after => :load_config_initializers do
      Omnipopulus.service_configs.each do |key, service_config|
        config.app_middleware.use ("::OmniAuth::Strategies::" + key.to_s.classify).constantize,
          service_config.app_key,
          service_config.app_secret,
          service_config.options
      end

      # if Omnipopulus.service_configs[:twitter]
      #   config.app_middleware.use ::OmniAuth::Strategies::Twitter,
      #     Omnipopulus.service_configs[:twitter].app_key,
      #     Omnipopulus.service_configs[:twitter].app_secret
      # end
      # 
      # if Omnipopulus.service_configs[:facebook]
      #   config.app_middleware.use ::OmniAuth::Strategies::Facebook,
      #     Omnipopulus.service_configs[:facebook].app_key,
      #     Omnipopulus.service_configs[:facebook].app_secret,
      #     Omnipopulus.service_configs[:facebook].options
      # end
      # 
      # if Omnipopulus.service_configs[:linked_in]
      #   config.app_middleware.use ::OmniAuth::Strategies::LinkedIn,
      #     Omnipopulus.service_configs[:linked_in].app_key,
      #     Omnipopulus.service_configs[:linked_in].app_secret
      # end
      # 
      # if Omnipopulus.service_configs[:github]
      #   config.app_middleware.use ::OmniAuth::Strategies::GitHub,
      #     Omnipopulus.service_configs[:github].app_key,
      #     Omnipopulus.service_configs[:github].app_secret
      # end
      # 
      # if Omnipopulus.service_configs[:angel_list]
      #   config.app_middleware.use ::OmniAuth::Strategies::AngelList,
      #     Omnipopulus.service_configs[:angel_list].app_key,
      #     Omnipopulus.service_configs[:angel_list].app_secret
      # end
    end

  end
end
