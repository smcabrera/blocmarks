require 'spec_helper'
require 'rails_helper'

feature 'user adds a bookmark' do
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    @user = create(:user)
    @topic = create(:topic)
  end

  describe 'User' do
    before do
      login_as(@user, :scope => :user)
    end

    it 'views index of existing bookmarks for a topic' do
      bookmark = create(:bookmark, :user => @user, :topic => @topic)

      visit topic_bookmarks_path @topic

      expect(page).to have_content("Test Bookmark")
    end

    it 'shows details on existing bookmark' do
      bookmark = create(:bookmark, :user => @user, :topic => @topic)

      visit topic_bookmark_path(@topic, bookmark)

      expect(page).to have_content("Test Bookmark")
    end

    it 'creates a new bookmark' do
      visit new_topic_bookmark_path(@topic)
      fill_in "bookmark[url]", :with => 'www.test.com/bookmark'
      fill_in "bookmark[name]", :with => 'Test Bookmark'
      click_button 'Save'

      expect(Bookmark.count).to eq(1)
    end

    it 'updates an existing bookmark' do
      bookmark = create(:bookmark, :user => @user, :topic => @topic)

      visit edit_topic_bookmark_path(@topic, bookmark)

      fill_in "bookmark[url]", :with => 'www.test.com/updated-bookmark'
      fill_in "bookmark[name]", :with => 'Updated Test Bookmark'
      click_button "Save"

      expect(Bookmark.first.name).to eq("Updated Test Bookmark")
    end

    it 'deletes an existing bookmark' do
      bookmark = create(:bookmark, :user => @user, :topic => @topic)

      visit topic_bookmarks_path(@topic)
      click_link "Destroy"

      expect(Bookmark.count).to eq(0)
    end
  end
end
