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
  
  has_many :groups
  
end
