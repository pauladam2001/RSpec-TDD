require 'rails_helper'

RSpec.describe Post, type: :model do
  current_user = User.first_or_create(email: 'paul@example.com', password: '123456', password_confirmation: '123456')

  it 'has a title' do
    post = Post.new(title: '', body: 'Valid', user: current_user, views: 0)
    expect(post).to_not be_valid

    post.title = 'Title'
    expect(post).to be_valid
  end

  it 'has a body' do
    post = Post.new(title: 'Title', body: '', user: current_user, views: 0)
    expect(post).to_not be_valid

    post.body = 'Body'
    expect(post).to be_valid
  end

  it 'has a title at least 2 characters long' do
    post = Post.new(title: '', body: 'Body', user: current_user, views: 0)
    expect(post).to_not be_valid

    post.title = '12'
    expect(post).to be_valid
  end

  it 'has a body between 5 and 100 characters' do
    post = Post.new(title: 'Title', body: '', user: current_user, views: 0)
    expect(post).to_not be_valid

    post.body = '12345'
    expect(post).to be_valid

    hundred_char_string = 'LGUsHkNFUNH2UFOyouT9RDelhsTyp1jtnaGYX86UsfK00ZioSLHtLPuO4hNLOYy6uyyBQYF019m9CQD6WiUHXUEPYRfw68u0PgKl'
    post.body = hundred_char_string
    expect(post).to be_valid

    post.body = hundred_char_string + '1'
    expect(post).to_not be_valid
  end

  it 'has numerical views' do

  end
end