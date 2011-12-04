class Group
  include Mongoid::Document
  include Mongoid::Timestamps
  field :position, :type => Integer
  belongs_to :grouping
  has_many :users
end
