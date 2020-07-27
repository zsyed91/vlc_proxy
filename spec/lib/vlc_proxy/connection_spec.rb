require 'ostruct'

RSpec.describe VlcProxy::Connection do
  let(:connection) { VlcProxy::Connection.new(hostname, password, port) }
  let(:hostname) { 'localhost' }
  let(:port) { 8080 }
  let(:password) { '1122' }
  let(:good_response) { OpenStruct.new(code: '200') }
  let(:unauthorized_response) { OpenStruct.new(code: '401') }
  let(:http) { double('http') }

  before do
    allow(Net::HTTP).to receive(:start).and_yield(http)
    allow(http).to receive(:request).and_return(good_response)
  end

  describe '#connected?' do
    it 'returns true if VLC is running' do
      expect(connection.connected?).to be(true)
    end

    it 'returns false if credentials incorrect' do
      allow(http).to receive(:request).and_return(unauthorized_response)
      expect(connection.connected?).to be(false)
    end

    it 'returns false if service unreachable' do
      allow(http).to receive(:request).and_raise(Errno::ECONNREFUSED)
      expect(connection.connected?).to be(false)
    end

    it 'returns false if request is unauthorized' do
      allow(http).to receive(:request).and_return(unauthorized_response)
      expect(connection.connected?).to be(false)
    end

    it 'returns false for non-expected http codes' do
      response = OpenStruct.new(code: 500)
      allow(http).to receive(:request).and_return(response)
      expect(connection.connected?).to be(false)
    end
  end

  describe '#execute' do
    it 'connects to the right endpoint' do
      expect(Net::HTTP).to(
        receive(:start).with(hostname, port).and_yield(http)
      )

      connection.execute('status')
    end

    it 'returns the http response' do
      expect(connection.execute('status')).to eq(good_response)
    end

    it 'uses basic auth' do
      expect(http).to receive(:request) do |request|
        expect(request.to_hash['authorization'][0]).to match(/^Basic/)
        request
      end

      connection.execute('status')
    end

    it 'executes basic http requests' do
      expect(http).to receive(:request) do |request|
        expect(request.uri.path).to eq('/requests/status.xml')
        request
      end

      connection.execute('status')
    end

    it 'passes commands to the request' do
      expect(http).to receive(:request) do |request|
        expect(request.uri.query).to eq('command=pl_pause')
        request
      end

      connection.execute('status', 'pl_pause')
    end

    it 'passes commands with parameters to the request' do
      expect(http).to receive(:request) do |request|
        expect(request.uri.query).to(
          eq('command=pl_pause&fullscreen=true&time=5')
        )
        request
      end

      connection.execute('status', 'pl_pause', fullscreen: true, time: 5)
    end
  end
end
