require 'active_record'

module Batch
  class ArticleGateway
    def self.pull_articles

      Rails.logger.debug('pull_articles start')

      qiita = Qiita::Client.new().get('/api/v2/tags/rails/items', per_page: 7)

      if qiita.status == 200
        qiita.body.each do |qiita_hash|
          if Article.find_by(qiita_id: qiita_hash['id']).nil?
            article = Article.create_from!(qiita_hash: qiita_hash)
            Rails.logger.debug("create: #{article}")
            if article.present?
              message = article.tweet_message
              Rails.logger.debug("message: #{message}")

              # Twitter投稿のRate Limitがよくわからないのでテキトウに
              ArticleTweetJob.set(wait: 60.second).perform_later(message)
            else
              Rails.logger.error('article not create')
            end
          else
            Rails.logger.debug('find article')
          end
        end
      else
        Rails.logger.debug('pull_articles not 200')
      end
    end
  end
end
