require 'vlc_proxy/version'
require 'vlc_proxy/configuration'
require 'vlc_proxy/exceptions'
require 'vlc_proxy/connection'
require 'vlc_proxy/client'

module VlcProxy
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= VlcProxy::Configuration.new
    yield config if block_given?
  end
end
