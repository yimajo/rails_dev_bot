# == Schema Information
#
# Table name: articles
#
#  id                  :integer          not null, primary key
#  url                 :text             not null
#  title               :string           not null
#  author_name         :string           not null
#  kind                :integer
#  qiita_id            :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  twitter_screen_name :string
#

require 'test_helper'
require './lib/batch/article_gateway'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def test_article
    Batch::ArticleGateway.pull_articles
  end

  def test_tweet_message
    article = Article.all.first

    assert_not_nil(article)
    tweet_message = article.tweet_message

    if tweet_message
      assert_not_nil(tweet_message)
      p "tweet_message: #{tweet_message}"
    end
  end

  def test_qiita_article

    client = Qiita::Client.new()
    qiita = client.get('/api/v2/tags/rails/items', per_page: 3)

    if qiita.status == 200
      assert true
    else
      assert false
    end

    item = qiita.body[0]

    qiita.body.each do |qiita_hash|

      article = Article.create_from!(qiita_hash: qiita_hash)

      if article.nil?
        asesrt false, 'Article create faild'
      else
        assert true
      end

    end
  end
end
