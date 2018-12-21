require 'net/http'
require 'nokogiri'

module VlcProxy
  # When HTTP enabled on VLC, a LUA web server runs in background listening
  #   on the specific port on localhost by default. VLC requires setting a
  #   password for basic auth as well
  class Connection
    def initialize(hostname, password, port = 8080, scheme = 'http')
      @hostname = hostname
      @password = password
      @port = port
      @scheme = scheme
      @logger = VlcProxy.config.logger
    end

    # Test if the connection works with the connection parameters
    #  Returns true if VLC is running and returns a response on /status
    #  Returns false if there are any connection errors
    def connected?
      response = execute('status')
      parse_response(response)
    rescue VlcProxy::AccessDeniedError, Errno::ECONNREFUSED => e
      @logger.error(e.message)
      false
    end

    def execute(action, command = '', parameters = {})
      uri = build_uri(action, command, parameters)
      request = Net::HTTP::Get.new(uri)
      request.basic_auth('', @password)

      Net::HTTP.start(uri.hostname, uri.port) do |http|
        @logger.info('Starting HTTP request')
        http.request(request)
      end
    end

    private

    def http_success?(response)
      response.code == '200'
    end

    def http_unauthorized?(response)
      response.code == '401'
    end

    def parse_response(response)
      return true if http_success?(response)
      raise VlcProxy::AccessDeniedError if http_unauthorized?(response)
      false
    end

    def build_uri(action, command = '', parameters = {})
      base_url = "#{@scheme}://#{@hostname}:#{@port}/requests/#{action}.xml"
      base_url += "?command=#{command}" unless command.empty?
      unless parameters.empty?
        params = parameters.map { |key, value| "#{key}=#{value}" }.join('&')
        base_url += "&#{params}"
      end
      @logger.info("built uri: #{base_url}")
      URI(base_url)
    end
  end
end
