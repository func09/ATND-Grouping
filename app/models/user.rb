class User
  include Mongoid::Document
  embedded_in :grouping
  field :user_id, :type => Integer
  field :nickname, :type => String
  field :twitter_id, :type => String
  field :twitter_img, :type => String
  field :status, :type => Integer
end
