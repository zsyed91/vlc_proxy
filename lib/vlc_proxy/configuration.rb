require 'logger'

module VlcProxy
  class Configuration
    attr_writer :logger, :verbose

    def initialize
      @logger = Logger.new(STDOUT)
      @verbose = false
    end

    def logger
      @logger.level = verbose? ? Logger::INFO : Logger::WARN

      @logger
    end

    def verbose?
      @verbose
    end
  end
end
