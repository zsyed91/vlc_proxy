require 'vlc_proxy/configuration'

module VlcProxy
  class Client
    attr_reader :connection

    def initialize(connection)
      @connection = connection
      @logger = VlcProxy.config.logger
    end

    def current_state
      request('status')
    end

    def pause_playlist
      request('status', 'pl_pause')
    end

    def start_playlist
      request('status', 'pl_play')
    end

    def stop_playlist
      request('status', 'pl_stop')
    end

    def next_item
      request('status', 'pl_next')
    end

    def previous_item
      request('status', 'pl_previous')
    end

    def toggle_repeat
      request('status', 'pl_repeat')
    end

    def toggle_loop
      request('status', 'pl_loop')
    end

    def toggle_random
      request('status', 'pl_random')
    end

    def toggle_fullscreen
      request('status', 'fullscreen')
    end

    def increase_volume(value)
      request('status', 'volume', val: "+#{value.abs}")
    end

    def decrease_volume(value)
      request('status', 'volume', val: "-#{value.abs}")
    end

    def skip_forward(seconds)
      request('status', 'seek', val: "+#{seconds.abs}S")
    end

    def skip_backward(seconds)
      request('status', 'seek', val: "-#{seconds.abs}S")
    end

    private

    def request(action, command = '', parameters = {})
      @connection.execute(action, command, parameters)
    rescue StandardError => e
      @logger.error(e.message)
      raise e
    end
  end
end
