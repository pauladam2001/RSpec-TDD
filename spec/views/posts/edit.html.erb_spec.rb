require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
  current_user = User.first_or_create(email: 'paul@example.com', password: '123456', password_confirmation: '123456')

  before(:each) do
    @post = assign(:post, Post.create!(
      title: 'Title',
      body: 'Body',
      user: current_user,
      views: 1
    ))
  end

  it 'renders the edit post form' do
    render

    assert_select 'form[action=?][method=?]', post_path(@post), 'post' do
      assert_select 'input[name=?]', 'post[title]'

      assert_select 'textarea[name=?]', 'post[body]'
    end
  end
end