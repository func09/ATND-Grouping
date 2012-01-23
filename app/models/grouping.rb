# -*- coding: utf-8 -*-
class Grouping
  include Mongoid::Document
  
  field :event_id, :type => Integer         # event_id  イベントID  757
  field :title, :type => String             # title タイトル  Tokyo Cloud Developers Meetup #02
  field :catch, :type => String             # catch キャッチ  今回のテーマは Google App Engine。
  field :description, :type => String       # description 概要  クラウド・コンピューティングを扱うディベロッパ・エンジニアのカジュアルなイベント Tokyo Cloud の第２回目を開催します。
  field :event_url, :type => String         # event_url ATNDのURL  http://atnd.org/events/757
  field :started_at, :type => DateTime      # started_at  イベント開催日時  2009-06-10T19:00:00+09:00
  field :ended_at, :type => DateTime        # ended_at  イベント終了日時  2009-06-10T21:00:00+09:00
  field :url, :type => String               # url 参考URL http://groups.google.com/group/tokyocloud
  field :limit, :type => Integer            # limit 定員  80
  field :address, :type => String           # address 開催場所  東京都中央区銀座7-2-6
  field :place, :type => String             # place 開催会場  Recruit Annex 1　（リクルートアネックス1）　B1F
  field :lat, :type => Integer              # lat 開催会場の緯度 35.6708529
  field :lon, :type => Integer              # lon 開催会場の経度 139.7605287
  field :accepted, :type => Integer         # accepted  参加者 80
  field :waiting, :type => Integer          # waiting 補欠者 15
  field :updated_at, :type => DateTime      # updated_at  更新日時  2009-06-04T11:56:20Z
  field :owner_id, :type => Integer         # owner_id  主催者のID  132
  field :owner_nickname, :type => String    # owner_nickname  主催者のニックネーム  kawanet
  field :owner_twitter_id, :type => Integer # owner_twitter_id  主催者のtwitter ID  kawanet
  field :owner_id, :type => Integer         # owner_id  主催者のID  132
  
  field :groupings_count, :type => Integer
  
  embeds_many :groups
  embeds_many :users
  
  after_initialize :set_event_id
  
  def pull_atnd_event
    pull_atnd_event_detail(self.event_id)
    pull_atnd_event_users(self.event_id)
  rescue => e
    self.errors.add(:event_id, '不正なイベントIDです')
  end
  
  # usersをシャッフルしてgroupsを返す
  def shuffle
    count = self.groupings_count
    groups = []
    users = self.users.dup.shuffle
    people_count = (users.size / count)
    
    count.times do
      group = Group.new
      people_count.times do
        group.users << users.pop
      end
      groups << group
    end
    
    # 余った人の処理
    # FIXME 今は余った人を適当なグループに突っ込むだけ
    unless users.empty?
      users.each do |user|
        group = groups.sample
        group.users << user
      end
    end
    
    self.groups = groups
  end
  
  private
    
    def set_event_id
      if self.event_url.present? && self.event_id.blank? && self.event_url.match(%r{http://atnd.org/events/([0-9]+)})
        self.event_id = $1.to_i
      end
    end
  
    def pull_atnd_event_users(event_id)
      res = HTTParty.get("http://api.atnd.org/events/users/?event_id=#{event_id}&format=json")
      if res.code == 200
        parsed_response = res.parsed_response.with_indifferent_access
        event = parsed_response[:events].first
        users = event[:users]
        self.users = []
        users.each do |user|
          if user[:status] == 1
            u = User.new(user)
            self.users << u
          end
        end
      end
    end
    
    def pull_atnd_event_detail(event_id)
      res = HTTParty.get("http://api.atnd.org/events/?event_id=#{event_id}&format=json")
      if res.code == 200
        parsed_response = res.parsed_response.with_indifferent_access
        event = parsed_response[:events].first
        self.attributes = event
      end
    end
  
end
