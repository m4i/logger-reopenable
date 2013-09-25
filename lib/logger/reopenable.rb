require 'logger/reopenable/version'

class Logger
  module Reopenable
    def reopen
      @logdev.reopen if @logdev
    end

    module LogDevice
      def reopen
        return unless @filename
        @mutex.synchronize do
          @dev.close
          @dev = open_logfile(@filename)
          @dev.sync = true
        end
      rescue Exception
        warn "log reopening failed. #$!"
      end
    end
  end
end
