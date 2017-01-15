class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  validates :name, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 15 }, presence: true
  before_save :set_public

  private
  def set_public
    self.public = true if self.public == nil
  end
end
