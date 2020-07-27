RSpec.describe VlcProxy::Client do
  let(:connection) { double('VlcProxy::Connection') }
  let(:client) { VlcProxy::Client.new(connection) }

  before do
    VlcProxy.configure
    allow(connection).to receive(:execute).and_return(true)
  end

  describe '.initalize' do
    it 'takes in a connection to VLC' do
      client = VlcProxy::Client.new(connection)
      expect(client.connection).to eq(connection)
    end
  end

  describe '#current_state' do
    it 'executes the status api call' do
      expect(connection).to receive(:execute).with('status', '', {})
      client.current_state
    end

    it 'captures exceptions' do
      allow(connection).to receive(:execute).and_raise('boom')
      expect { client.current_state }.to raise_error('boom')
    end
  end

  describe '#pause_playlist' do
    it 'executes the pl_plause api call' do
      expect(connection).to receive(:execute).with('status', 'pl_pause', {})
      client.pause_playlist
    end

    it 'captures exceptions' do
      expect(connection).to receive(:execute).and_raise('boom')
      expect { client.pause_playlist }.to raise_error('boom')
    end
  end

  describe '#start_playlist' do
    it 'executes the start_playlist api call' do
      expect(connection).to(
        receive(:execute).with('status', 'pl_play', {})
      )
      client.start_playlist
    end

    it 'captures exceptions' do
      expect(connection).to receive(:execute).and_raise('boom')
      expect { client.start_playlist }.to raise_error('boom')
    end
  end

  describe '#stop_playlist' do
    it 'executes the stop_playlist api call' do
      expect(connection).to(
        receive(:execute).with('status', 'pl_stop', {})
      )
      client.stop_playlist
    end

    it 'captures exceptions' do
      expect(connection).to receive(:execute).and_raise('boom')
      expect { client.stop_playlist }.to raise_error('boom')
    end
  end

  describe '#next_item' do
    it 'executes the next_item api call' do
      expect(connection).to(
        receive(:execute).with('status', 'pl_next', {})
      )
      client.next_item
    end

    it 'captures exceptions' do
      expect(connection).to receive(:execute).and_raise('boom')
      expect { client.next_item }.to raise_error('boom')
    end
  end

  describe '#previous_item' do
    it 'executes the previous_item api call' do
      expect(connection).to(
        receive(:execute).with('status', 'pl_previous', {})
      )
      client.previous_item
    end

    it 'captures exceptions' do
      expect(connection).to receive(:execute).and_raise('boom')
      expect { client.previous_item }.to raise_error('boom')
    end
  end

  describe '#toggle_repeat' do
    it 'executes the toggle_repeat api call' do
      expect(connection).to(
        receive(:execute).with('status', 'pl_repeat', {})
      )
      client.toggle_repeat
    end

    it 'captures exceptions' do
      expect(connection).to receive(:execute).and_raise('boom')
      expect { client.toggle_repeat }.to raise_error('boom')
    end
  end

  describe '#toggle_loop' do
    it 'executes the toggle_loop api call' do
      expect(connection).to(
        receive(:execute).with('status', 'pl_loop', {})
      )
      client.toggle_loop
    end

    it 'captures exceptions' do
      expect(connection).to receive(:execute).and_raise('boom')
      expect { client.toggle_loop }.to raise_error('boom')
    end
  end

  describe '#toggle_random' do
    it 'executes the toggle_random api call' do
      expect(connection).to(
        receive(:execute).with('status', 'pl_random', {})
      )
      client.toggle_random
    end

    it 'captures exceptions' do
      expect(connection).to receive(:execute).and_raise('boom')
      expect { client.toggle_random }.to raise_error('boom')
    end
  end

  describe '#toggle_fullscreen' do
    it 'executes the toggle_fullscreen api call' do
      expect(connection).to(
        receive(:execute).with('status', 'fullscreen', {})
      )
      client.toggle_fullscreen
    end

    it 'captures exceptions' do
      expect(connection).to receive(:execute).and_raise('boom')
      expect { client.toggle_fullscreen }.to raise_error('boom')
    end
  end

  describe '#increase_volume' do
    it 'increases the volume when passed positive values' do
      expect(connection).to(
        receive(:execute).with('status', 'volume', { val: '+5' })
      )
      client.increase_volume(5)
    end

    it 'increases the volume when passed negative values' do
      expect(connection).to(
        receive(:execute).with('status', 'volume', { val: '+52' })
      )
      client.increase_volume(-52)
    end

    it 'captures exceptions' do
      expect(connection).to receive(:execute).and_raise('boom')
      expect { client.increase_volume(4) }.to raise_error('boom')
    end
  end

  describe '#decrease_volume' do
    it 'decreases the volume when passed positive values' do
      expect(connection).to(
        receive(:execute).with('status', 'volume', { val: '-8' })
      )
      client.decrease_volume(8)
    end

    it 'decreases the volume when passed negative values' do
      expect(connection).to(
        receive(:execute).with('status', 'volume', { val: '-42' })
      )
      client.decrease_volume(-42)
    end

    it 'captures exceptions' do
      expect(connection).to receive(:execute).and_raise('boom')
      expect { client.decrease_volume(4) }.to raise_error('boom')
    end
  end

  describe '#skip_forward' do
    it 'skips forward when passed in positive seconds' do
      expect(connection).to(
        receive(:execute).with('status', 'seek', { val: '+8S' })
      )
      client.skip_forward(8)
    end

    it 'skips forward when passed in negative seconds' do
      expect(connection).to(
        receive(:execute).with('status', 'seek', { val: '+42S' })
      )
      client.skip_forward(-42)
    end

    it 'captures exceptions' do
      expect(connection).to receive(:execute).and_raise('boom')
      expect { client.skip_forward(4) }.to raise_error('boom')
    end
  end

  describe '#skip_backward' do
    it 'skips backwards when passed in positive seconds' do
      expect(connection).to(
        receive(:execute).with('status', 'seek', { val: '-8S' })
      )
      client.skip_backward(8)
    end

    it 'skips backwards when passed in negative seconds' do
      expect(connection).to(
        receive(:execute).with('status', 'seek', { val: '-42S' })
      )
      client.skip_backward(-42)
    end

    it 'captures exceptions' do
      expect(connection).to receive(:execute).and_raise('boom')
      expect { client.skip_backward(4) }.to raise_error('boom')
    end
  end
end
