require 'rails_helper'
require 'random_data'

RSpec.describe SponsoredPostsController, type: :controller do
  let(:my_topic) { create(:topic) }
  let(:my_sponsored_post) { SponsoredPost.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_price, topic: my_topic) }

   describe "GET show" do
     it "returns http success" do
       get :show, {id: my_sponsored_post.id, topic_id: my_topic.id}
       expect(response).to have_http_status(:success)
     end

     it "renders the #show view" do
       get :show, {id: my_sponsored_post.id, topic_id: my_topic.id}
       expect(response).to render_template :show
     end

     it "assigns my_sponsored_post to @sponsored_post" do
       get :show, {id: my_sponsored_post.id, topic_id: my_topic.id}
       expect(assigns(:sponsored_post)).to eq(my_sponsored_post)
     end
   end
   describe "GET new" do
     it "returns http success" do
       get :new, {topic_id: my_topic.id}
       expect(response).to have_http_status(:success)
     end

     it "renders the #new view" do
       get :new, {topic_id: my_topic.id}
       expect(response).to render_template :new
     end

     it "initializes @topic" do
       get :new, {topic_id: my_topic.id}
       expect(assigns(:sponsored_post)).not_to be_nil
     end
   end
   describe "POST create" do
     it "increases the number of sponsored_posts by 1" do
       expect{ post :create, {topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_price}}}.to change(SponsoredPost,:count).by(1)
     end

     it "assigns SponsoredPost.last to @sponsored_post" do
       post :create, {topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_price}}
       expect(assigns(:sponsored_post)).to eq SponsoredPost.last
     end

     it "redirects to the new sponsored_post" do
       post :create, {topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_price}}
       expect(response).to redirect_to SponsoredPost.last
     end
   end
   describe "GET edit" do
     it "returns http success" do
       get :edit, {topic_id: my_topic.id, id: my_sponsored_post.id}
       expect(response).to have_http_status(:success)
     end

     it "renders the #edit view" do
       get :edit, {topic_id: my_topic.id, id: my_sponsored_post.id}
       expect(response).to render_template :edit
     end

     it "assigns sponsored_post to be updated to @sponsored_post" do
       get :edit, {topic_id: my_topic.id, id: my_sponsored_post.id}
       sponsored_post_instance = assigns(:sponsored_post)

       expect(sponsored_post_instance.id).to eq my_sponsored_post.id
       expect(sponsored_post_instance.name).to eq my_sponsored_post.name
       expect(sponsored_post_instance.body).to eq my_sponsored_post.body
       expect(sponsored_post_instance.price).to eq my_sponsored_post.price
     end
   end
   describe "PUT update" do
     it "updates sponsored_post with expected attributes" do
       new_name = RandomData.random_sentence
       new_body = RandomData.random_paragraph
       new_price = RandomData.random_price

       put :update, topic_id: my_topic.id, id: my_sponsored_post.id, sponsored_post: { title: new_name, body: new_body, price: new_price }

       updated_sponsored_post = assigns(:sponsored_post)
       expect(updated_sponsored_post.id).to eq my_topic.id
       expect(updated_sponsored_post.name).to eq new_name
       expect(updated_sponsored_post.body).to eq new_body
       expect(updated_sponsored_post.price).to eq new_price
     end

     it "redirects to the updated sponsored_post" do
       new_name = RandomData.random_sentence
       new_body = RandomData.random_paragraph
       new_price = RandomData.random_price

       put :update, topic_id: my_topic.id, id: my_sponsored_post.id, sponsored_post: { title: new_name, body: new_body, price: new_price }
       expect(response).to redirect_to my_sponsored_post
     end
   end
   describe "DELETE destroy" do
     it "deletes the sponsored_post" do
       delete :destroy, {topic_id: my_topic.id, id: my_sponsored_post.id}
       count = SponsoredPost.where({id: my_sponsored_post.id}).size
       expect(count).to eq 0
     end

     it "redirects to sponsored_posts index" do
       delete :destroy, {topic_id: my_topic.id, id: my_sponsored_post.id}
       expect(response).to redirect_to sponsored_posts_path
     end
   end
end
