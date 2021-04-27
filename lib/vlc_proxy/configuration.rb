require 'logger'

module VlcProxy
  class Configuration
    attr_writer :logger, :verbose

    def initialize
      @logger = Logger.new($stdout)
      @verbose = false
    end

    def logger
      @logger.level = verbose? ? Logger::DEBUG : Logger::INFO

      @logger
    end

    def verbose?
      @verbose
    end
  end
end
