class LogStash::Filters::Sequence < LogStash::Filters::Base
  config_name "sequence"
  plugin_status "beta"

  config :max, :validate => :number, :default => 10000000

  public
  def register
    @count = ENV["counter_seed"].to_i
  end # def register

  public
  def filter(event)
    return unless filter?(event)
    # Nothing to do
    event["sequence"] = @count
    @count += ENV["counter_increment"].to_i
    # Means that we can sequences up to @max events in the same millis from @timestamp
    @count = 1 if @count == @max 
    filter_matched(event)
  end # def filter
end
