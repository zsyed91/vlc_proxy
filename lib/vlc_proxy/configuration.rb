require 'logger'

module VlcProxy
  class Configuration
    attr_accessor :logger, :verbose

    def initialize
      @logger = Logger.new(STDOUT)
      @verbose = false
    end

    def logger
      if verbose? && !@logger.info?
        @logger.level = Logger::INFO
      else
        @logger.level = Logger::WARN
      end
      @logger
    end

    def verbose?
      @verbose
    end
  end
end
