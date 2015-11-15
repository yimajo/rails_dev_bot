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

class Article < ActiveRecord::Base

  enum kind: [:unknown, :qiita]

  def self.dummy
    print 'p Artcile class dummy method'
    logger.debug('debug Article class dummy method')
  end

  # すでにあれば何もせずnilを返す
  def self.create_from!(qiita_hash:)

    if Article.find_by(qiita_id: qiita_hash['qiita_id'])
      return nil
    end

    Article.create!(
      title: qiita_hash['title'],
      author_name: qiita_hash['user']['id'],
      twitter_screen_name: qiita_hash['user']['twitter_screen_name'],
      url: qiita_hash['url'],
      kind: 1,
      qiita_id: qiita_hash['id']
    )
  end

  def tweet_message
    user_name =  self.twitter_screen_name.present? ? "@#{self.twitter_screen_name}" : self.author_name

    "#{self.title} #{self.url} [by #{user_name}] #Railsアプリ開発"
  end
end
