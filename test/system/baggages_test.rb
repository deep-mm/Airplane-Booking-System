require "application_system_test_case"

class BaggagesTest < ApplicationSystemTestCase
  setup do
    @baggage = baggages(:one)
  end

  test "visiting the index" do
    visit baggages_url
    assert_selector "h1", text: "Baggages"
  end

  test "creating a Baggage" do
    visit baggages_url
    click_on "New Baggage"

    click_on "Create Baggage"

    assert_text "Baggage was successfully created"
    click_on "Back"
  end

  test "updating a Baggage" do
    visit baggages_url
    click_on "Edit", match: :first

    click_on "Update Baggage"

    assert_text "Baggage was successfully updated"
    click_on "Back"
  end

  test "destroying a Baggage" do
    visit baggages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Baggage was successfully destroyed"
  end
end
