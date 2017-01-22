require 'rails_helper'

feature 'Add feedback', %{
  In order to inform development team about problem
  As a Customer
  I want to have an ability to leave a feedback
} do

  scenario 'Customer leave feedback', js: true do
    visit root_path
    click_on 'Leave feedback'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Text', with: 'Dolore illum animi et neque accusantium.'
    click_on 'Submit'

    expect(page).to have_content 'test@test.com'
    expect(page).to have_content 'Dolore illum animi et neque accusantium.'
    expect(current_path).to eq root_path
  end
end
