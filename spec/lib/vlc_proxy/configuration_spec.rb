RSpec.describe VlcProxy::Configuration do
  let(:configuration) { described_class.new }
  let(:logger) { Logger.new(STDOUT) }

  context 'with defaults' do
    it 'has a logger' do
      expect(configuration.logger).to be_a(Logger)
    end

    it 'disables verbose mode' do
      expect(configuration.verbose?).to be(false)
    end

    it 'defaults logger at the warning level' do
      expect(configuration.logger.level).to eq(Logger::WARN)
    end
  end

  describe '#logger' do
    before do
      configuration.logger = logger
    end

    it 'returns the logger' do
      expect(configuration.logger).to eq(logger)
    end
  end

  describe '#verbose?' do
    it 'returns true when set to verbose mode' do
      configuration.verbose = true

      expect(configuration.verbose?).to be(true)
    end

    it 'returns false when verbose mode disabled' do
      configuration.verbose = false

      expect(configuration.verbose?).to be(false)
    end
  end
end
