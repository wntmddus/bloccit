class AddTopicIdToSponsoredPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :sponsored_posts, :topic_id, :integer
    
  end
end
