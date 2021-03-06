require "rails_helper"

RSpec.feature "Showing an article" do 
  
  before do
    @john = User.create(email: "john@example.com", password: "password")
    @fred = User.create(email: "fred@example.com", password: "password")
    @article = Article.create(title: "The first Article", body: "Lorem ipsum dolor sit amet, consectetur.", user: @john) 
  end
  
  scenario "to non-signed in user hide the edit and delete buttons" do
    
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    
    expect(page).not_to have_link("Edit")
    expect(page).not_to have_link("Delete")
  end
  
  scenario "to non-owner hide the edit and delete buttons" do
    
    login_as(@fred)
    
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    
    expect(page).not_to have_link("Edit")
    expect(page).not_to have_link("Delete")
  end
  
  scenario "to signed-in owner show the edit and delete buttons" do
    
    login_as(@john)
    
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    
    expect(page).to have_link("Edit")
    expect(page).to have_link("Delete")
  end
end