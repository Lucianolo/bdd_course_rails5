require "rails_helper"

RSpec.feature "Adding reviews to articles" do
  before do
    @john = User.create(email: "john@example.com", password: "password")
    @fred = User.create(email: "fred@example.com", password: "password")
    @article = Article.create(title: "The first Article", body: "Lorem ipsum dolor sit amet, consectetur.", user: @john) 
  end
  
  scenario "permits a signed in user to write a review" do
    login_as(@fred)
    visit '/'
    
    click_link @article.title
    fill_in "New Comment", with: "An amazing article"
    click_button "Add Comment"
    
    
    expect(page).to have_content("An amazing article")
    expect(current_path).to eq(article_comments_path(@article.id))
  end
end