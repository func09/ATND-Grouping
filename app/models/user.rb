class User
  include Mongoid::Document
  field :user_id, :type => Integer
  field :nickname, :type => String
  field :twitter_id, :type => String
  field :status, :type => Integer
end
