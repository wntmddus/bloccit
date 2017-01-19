class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  after_create :create_favorite

  default_scope { order('rank DESC') }
  scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }

  scope :ordered_by_title, -> { order('title DESC') }
  scope :ordered_by_reverse_created_at, -> { order('created_at ASC') }
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true
  def up_votes
 # #9
    votes.where(value: 1).count
  end

  def down_votes
 # #10
    votes.where(value: -1).count
  end
  def update_rank
     age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
     new_rank = points + age_in_days
     update_attribute(:rank, new_rank)
  end

  def points
 # #11
    votes.sum(:value)
  end
  def create_vote
    user.votes.create(value: 1, post: self)
  end
  def create_favorite
    Favorite.create(post: self, user: self.user)
    FavoriteMailer.new_post(self, self.user).deliver_now
  end
end
