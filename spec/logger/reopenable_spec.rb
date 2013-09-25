require 'spec_helper'
require 'logger-reopenable'

require 'stringio'
require 'tempfile'

def temppath
  path = nil
  Tempfile.open(File.basename(__FILE__)) do |file|
    path = file.path
    file.close!
  end
  path
end

describe 'Logger::Reopenable' do
  let(:path) { temppath }
  after { File.delete(path) }

  let(:logger) { Logger.new(path) }

  describe 'A logfile created by logger-reopenable' do
    let(:path) { temppath }

    before do
      logger.info 'foo'
      File.delete(path)
      logger.info 'bar'
      logger.reopen
      logger.info 'baz'
    end

    subject { File.read(path) }

    it { expect(subject).not_to be_include('foo') }
    it { expect(subject).not_to be_include('bar') }
    it { expect(subject).to     be_include('baz') }
  end

  context 'when an error occured while reopening' do
    let(:stderr) { StringIO.new }
    before { $stderr = stderr }
    after  { $stderr = STDERR }

    before do
      logger.info 'foo'
      File.chmod(0444, path)
    end
    it { expect { logger.reopen }.not_to raise_error }

    describe '$stderr' do
      before do
        logger.reopen
      end
      subject { stderr.rewind; stderr.read }
      it { expect(subject).to be_include('log reopening failed') }
    end
  end
end
