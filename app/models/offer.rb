class Offer < ActiveRecord::Base
  validates :title, :picture, :description, :url, presence: true
end
