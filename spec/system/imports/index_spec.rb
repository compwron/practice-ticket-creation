require "rails_helper"

RSpec.describe "imports/index", type: :system do
  let(:volunteer) { build(:volunteer) }

  context "as a volunteer" do
    before { sign_in volunteer }

    it "redirects the user with an error message" do
      visit imports_path

      expect(page).to have_selector(".alert", text: "Sorry, you are not authorized to perform this action.")
    end
  end
end
