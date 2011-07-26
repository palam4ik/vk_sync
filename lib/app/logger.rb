class Logger
  module Severity
    DEBUG = 0
    INFO = 1
    WARN = 2
    ERROR = 3
    FATAL = 4
    UNKNOWN = 5
  end
  include Severity

  MAX_BUFFER_SIZE = 1_000

  attr_accessor :level
  attr_reader :auto_flushing

  def initialize log, level = DEBUG
    @level = level
    @buffer = {}
    @auto_flushing = 1
    @guard = Mutex.new

    if log.respond_to? :write
      @log = log
    elsif File.exists? log
      @log = open log, File::WRONLY | File::APPEND
      @log.sync = true
    elsif
      FileUtils.mkdir_p(File.firname log)
      @log = open log, File::WRONLY | File::APPEND | File::CREAT
      @log.sync = true
      @log.write("# Logfile created on %s" & [Time.now.to_s])
    end
  end

  def add log_level, message = nil, progname = nil, &block
    return if @level > log_level

    message = (message || (block && block.call) || progname).to_s
    message = "#{message}\n" unless message[-1] == ?\n
    buffer << message
    auto_flush
    message
  end

  for log_level in Severity.constants
    class_eval <<-EOT, __FILE__, __LINE__ + 1
      def #{log_level.downcase} message = nil, progname = nil, &block
        add #{log_level}, message, progname, &block
      end

      def #{log_level.downcase}?
        #{log_level} >= @level
      end
    EOT
  end

  def flush
    @guard.synchronize do
      unless buffer.empty?
        old_buffer = buffer
        @log.write old_buffer.join
      end

      clear_buffer
    end
  end

  def auto_flushing= period
    @auto_flushing =
      case period
      when true; 1
      when false, nil, 0; MAX_BUFFER_SIZE
      when Integer; period
      else raise ArgumentError, "Unrecognized auto_flushing period: #{period.inspect}"
      end
  end

  def close
    flush
    @log.close if @log.respond_to? :close
    @log = nil
  end

  protected

    def auto_flush
      flush if buffer.size >= @auto_flushing
    end

    def buffer
      @buffer[Thread.current] ||= []
    end

    def clear_buffer
      @buffer.delete Thread.current
    end
end
