module Capistrano
  module Asg
    module Retryable
      def with_retry(max: fetch(:asg_retry_max, 20), delay: fetch(:asg_retry_delay, 20))
        tries ||= 0
        tries += 1
        yield
      rescue => e
        puts "Rescued #{e.message}"
        if tries < max
          puts "Retrying in #{delay} seconds..."
          sleep delay
          retry
        end
      end
    end
  end
end
