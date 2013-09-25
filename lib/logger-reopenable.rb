require 'logger'
require 'logger/reopenable'

class Logger
  include Reopenable
  class LogDevice
    include ::Logger::Reopenable::LogDevice
  end
end
