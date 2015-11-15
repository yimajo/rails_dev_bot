require 'clockwork'

require File.expand_path('../../config/boot', __FILE__)
require File.expand_path('../../config/environment', __FILE__)

module Clockwork

  handler do |job|
    Batch::ArticleGateway.pull_articles
    p "#{job}: pull_articles"
  end

  every(1.minute, 'minute')
end
