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
end
