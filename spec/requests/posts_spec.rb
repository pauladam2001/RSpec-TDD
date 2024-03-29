require 'rails_helper'

RSpec.describe "/posts", type: :request do
  current_user = User.first_or_create(email: 'paul@example.com', password: '123456', password_confirmation: '123456')

  let(:valid_attributes) do 
    {
      'id' => '1',
      'title' => 'Test',
      'body' => '12345'
    }
  end

  let(:invalid_attributes) do 
    {
      'id' => 'a',
      'title' => '1',
      'body' => '1234'
    }
  end

  describe "GET /index" do
    it "renders a successful response" do
      post = Post.new(valid_attributes)
      post.user = current_user
      post.save

      get posts_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      post = Post.new(valid_attributes)
      post.user = current_user
      post.save

      get post_url(post)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_post_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      post = Post.new(valid_attributes)
      post.user = current_user
      post.save

      get edit_post_url(post)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context 'with valid paramters' do
      it 'creates a new Post' do
        expect do
          post posts_url, params: { post: valid_attributes }
        end.to change(Post, :count).by(1)
      end

      it 'redirects to the created post' do
        post posts_url, params: { post: valid_attributes }
        expect(response).to redirect_to(post_url(Post.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Post' do
        expect do
          post posts_url, params: { post: invalid_attributes }
        end.to change(Post, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post posts_url, params: { post: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do 
        {
          'id' => '1',
          'title' => 'Test',
          'body' => '12345'
        }
      end

      it 'updates the requested post' do
        post = Post.create! valid_attributes
        patch post_url(post), params: { post: new_attributes }
        post.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the post' do
        post = Post.create! valid_attributes
        patch post_url(post), params: { post: new_attributes }
        post.reload
        expect(response).to redirect_to(post_url(post))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        post = Post.create! valid_attributes
        patch post_url(post), params: { post: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested post' do
      post = Post.create! valid_attributes
      expect do
        delete post_url(post)
      end.to change(Post, :count).by(-1)
    end

    it 'redirects to the posts list' do
      post = Post.create! valid_attributes
      delete post_url(post)
      expect(response).to redirect_to(posts_url)
    end
  end
end