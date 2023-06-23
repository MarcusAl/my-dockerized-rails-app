class CounterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Counter.first.increment!(:hit_count)
  end
end
