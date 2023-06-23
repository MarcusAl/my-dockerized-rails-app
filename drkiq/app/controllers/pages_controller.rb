class PagesController < ApplicationController
  def home
    CounterJob.perform_now
    @counter = Counter.first
  end
end
