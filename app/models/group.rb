class Group
  include Mongoid::Document
  field :position, :type => Integer
  embedded_in :grouping
  embeds_many :users
end
