require "application_system_test_case"

class SellersTest < ApplicationSystemTestCase
  setup do
    @seller = sellers(:one)
  end

  test "visiting the index" do
    visit sellers_url
    assert_selector "h1", text: "Sellers"
  end

  test "should create seller" do
    visit sellers_url
    click_on "New seller"

    fill_in "Company name", with: @seller.company_name
    fill_in "Contact email", with: @seller.contact_email
    fill_in "Contact phone", with: @seller.contact_phone
    fill_in "Contact website", with: @seller.contact_website
    fill_in "Logo", with: @seller.logo
    click_on "Create Seller"

    assert_text "Seller was successfully created"
    click_on "Back"
  end

  test "should update Seller" do
    visit seller_url(@seller)
    click_on "Edit this seller", match: :first

    fill_in "Company name", with: @seller.company_name
    fill_in "Contact email", with: @seller.contact_email
    fill_in "Contact phone", with: @seller.contact_phone
    fill_in "Contact website", with: @seller.contact_website
    fill_in "Logo", with: @seller.logo
    click_on "Update Seller"

    assert_text "Seller was successfully updated"
    click_on "Back"
  end

  test "should destroy Seller" do
    visit seller_url(@seller)
    click_on "Destroy this seller", match: :first

    assert_text "Seller was successfully destroyed"
  end
end
