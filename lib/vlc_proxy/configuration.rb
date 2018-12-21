require 'logger'

module VlcProxy
  class Configuration
    attr_accessor :logger, :verbose

    def initialize
      @logger = Logger.new(STDOUT)
      @verbose = false
    end

    def logger
      @logger.level = Logger::INFO if verbose? && !@logger.info?
      @logger
    end

    def verbose?
      @verbose
    end
  end
end
