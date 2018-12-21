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
  end

  describe '#execute' do
    it 'executes the http request' do
      expect(connection.execute('status')).to eq(good_response)
    end
  end
end
