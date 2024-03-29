require 'rails_helper'
include PostsHelper

RSpec.describe PostsHelper, type: :helper do
  it 'assigns a user to a post' do
    # AAA - Arrange, Act, Assert
    # Arrange
    creator = User.first_or_create(email: 'paul@example.com', password: '123456', password_confirmation: '123456')
    @post = Post.new(title: 'MyString', body: 'MyText', views: 1)
    # Act
    returned_post = assign_post_creator(@post, creator)
    # Assert
    expect(returned_post.user).to be(creator)
  end
end