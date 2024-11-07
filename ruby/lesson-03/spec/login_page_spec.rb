# frozen_string_literal: true

require 'selenium-webdriver'
require 'capybara/rspec'
require_relative 'spec_helper'

RSpec.describe 'Login Tests' do
  include Capybara::DSL

  before(:each) do
    visit @url
  end

  context "Login with password" do
    usernames = ['standard_user', 'locked_out_user', 'problem_user', 'performance_glitch_user', 'error_user', 'visual_user'] 
    password = 'secret_sauce'

    usernames.each do |username|
      context "when logging in as #{username}" do
        before(:each) do
          find('#user-name').set(username)
          find('#password').set(password)
          find('input[data-test="login-button"]').click
        end

        it 'logs in successfully' do
          account_header = find('.app_logo', text: 'Swag Labs')
          expect(account_header.text).to eql 'Swag Labs'
        end

        it 'can add 4 items to the cart' do
          add_to_cart_buttons = all('button.btn_primary.btn_inventory')
          button_count = 0
          add_to_cart_buttons.each do |button|
            button.click
            button_count += 1
            break if button_count == 4
          end

          cart = find('span[data-test="shopping-cart-badge"]', visible: true)
          expect(cart.text).to eql "4"
        end

        it 'can add one item to the cart and remove it' do
          all('button.btn_primary.btn_inventory')[0].click
          cart = find('span[data-test="shopping-cart-badge"]', visible: true)
          expect(cart.text).to eql "1"
          
          all('button.btn_secondary.btn_inventory')[0].click
          expect(page).to have_no_selector('span[data-test="shopping-cart-badge"]', visible: true)
        end

        it 'has proper first item name and img in both list and item pages' do
          list_item_name = all('div[data-test="inventory-item-name"]', visible: true)[0].text
          list_item_img_src = all('img.inventory_item_img', visible: true)[0]['src']

          all('a[id^="item_"][href="#"]', visible: true)[0].click
          
          single_item_name = find('div[data-test="inventory-item-name"]', visible: true)
          expect(single_item_name.text).to eql list_item_name
          
          single_item_img = find('.inventory_details_img', visible: true)
          expect(single_item_img['src']).to eql list_item_img_src
        end
      end
    end
  end
end