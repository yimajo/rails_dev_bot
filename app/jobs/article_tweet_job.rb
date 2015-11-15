class ArticleTweetJob < ActiveJob::Base
  queue_as :default

  def perform(message)

    Rails.logger.info("tweet: #{message}")

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV.fetch('TWITER_CONSUMER_KEY')
      config.consumer_secret     = ENV.fetch('TWITTER_CONSUMER_SECRET')
      config.access_token        = ENV.fetch('TWITER_TOKEN')
      config.access_token_secret = ENV.fetch('TWITTER_SECRET')
    end

    client.update(message)
  end
end
