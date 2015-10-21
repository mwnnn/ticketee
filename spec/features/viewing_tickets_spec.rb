require 'spec_helper'

feature "Viewing tickets" do
  before do
    textmate_2 = FactoryGirl.create(:project, name: "TextMate 2")

    FactoryGirl.create(:ticket, 
                        project: textmate_2,
                        title: "shiny",
                        description: "gradients! starburst!")

    internet_explorer = FactoryGirl.create(:project, name: "Internet Explorer")

    FactoryGirl.create(:ticket,
                        project: internet_explorer,
                        title: "compliance",
                        description: "isn't a joke")

    visit '/'
  end

  scenario "Viewing tickets for a given project" do
    click_link "TextMate 2"

    expect(page).to have_content("shiny")
    expect(page).to_not have_content("gradients! starburst!")

    click_link "shiny"
    within("#ticket h2") do
      expect(page).to have_content("shiny")
    end

    expect(page).to have_content("gradients! starburst!")
  end
end