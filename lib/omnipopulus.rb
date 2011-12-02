module Omnipopulus
  require 'omnipopulus/service_config'

  # Twitter & Facebook app configs
  mattr_accessor :service_configs
  @@service_configs = {}

  def self.setup
    yield self
  end

  # # config.twitter APP_KEY, APP_SECRET, :scope => ['foo', 'bar']
  def self.method_missing(method_name, *args, &block)
    if ::OmniAuth::Strategies.const_defined?(method_name.to_s.classify)
      args << {} unless args.last.is_a?(Hash)
      @@service_configs[method_name.to_sym] = Omnipopulus::ServiceConfig.new(*args)
    else
      super
    end
  end

  # def self.twitter(app_key, app_secret, options = {})
  #   @@service_configs[:twitter] = Omnipopulus::ServiceConfig.new(app_key, app_secret, options)
  # end
  # 
  # def self.facebook(app_key, app_secret, options = {})
  #   @@service_configs[:facebook] = Omnipopulus::ServiceConfig.new(app_key, app_secret, options)
  # end
  # 
  # def self.linked_in(app_key, app_secret, options ={})
  #   @@service_configs[:linked_in] = Omnipopulus::ServiceConfig.new(app_key, app_secret, options)
  # end
  # 
  # def self.github(app_key, app_secret, options ={})
  #   @@service_configs[:github] = Omnipopulus::ServiceConfig.new(app_key, app_secret, options)
  # end
  # 
  # def self.angel_list(app_key, app_secret, options ={})
  #   @@service_configs[:angel_list] = Omnipopulus::ServiceConfig.new(app_key, app_secret, options)
  # end

  require 'omnipopulus/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
end

require 'extensions/action_controller/base'
