require 'rails_helper'

feature 'Attach photo', %{
  In order to populate public meme collection
  As a guest
  I want to load my picture to the sites gallery
} do

  scenario 'Guest load a photo' do
    visit photos_path
    attach_file 'Image', "#{Rails.root}/spec/fixtures/minion.png"
    click_on 'Submit'

    within 'li.col-xs-3' do
      expect(page).to have_xpath "//a[@href='#{Photo.last.image.remote_url}']/img"
    end
    expect(current_path).to eq photos_path
  end
end
