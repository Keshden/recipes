class Recipe < ApplicationRecord
  belongs_to :chef
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 1000 }
  validates :chef_id, presence: true
  default_scope -> { order(updated_at: :desc)}
  has_many :comments, dependent: :destroy

end
