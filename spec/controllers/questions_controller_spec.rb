require 'rails_helper'

Rspec.describe QuestionsController, type: :controller do
  let(:my_question) do
    Question.create(
      id: 1,
      title: RandomData.random_sentence,
      body: RandomData.random_paragraph,
      resolved: false
    )
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns my_question to @question" do
      get :index
      expect(assigns(:question)).to eq([my_question])
    end
  end
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

 # #2
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

 # #3
    it "instantiates @post" do
      get :new
      expect(assigns(:post)).not_to be_nil
    end
  end
  describe "POST create" do
# #4
    it "increases the number of Question by 1" do
      expect{post :create, {post: {title: "Title", body: "body", resolved: false}}}.to change(Question,:count).by(1)
    end

# #5
    it "assigns the new post to @question" do
      post :create, {question: my_question.attributes}
      expect(assigns(:question)).to eq Question.last
    end

# #6
    it "redirects to the new question" do
      post :create, {question: my_question.attributes}
      expect(response).to redirect_to Question.last
    end
  end
end
