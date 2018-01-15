class Recipe < ApplicationRecord
  belongs_to :chef
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 1000 }
  validates :chef_id, presence: true

end
