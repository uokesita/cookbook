require 'rubygems'
require 'capybara'
require 'capybara/dsl'

Capybara.current_driver = :selenium
Capybara.app_host = 'http://www.fpl.com'
Capybara.run_server = false

class FPL
  include Capybara
  def pay
    visit('https://app.fpl.com/eca/EcaController')
    fill_in "userid", :with => ""
    fill_in "password", :with => ""
    click_button "Log In"
    click_link("Pay Bill")
    choose("totalDueAmount")
    fill_in "requested_by", :with => ""
    click_link("Accept Terms & Conditions")
    click_link("OK")
  end
end

class Paypal
  include Capybara

  def initialize
    login
  end

  def login
    visit("http://www.paypal.com")
    fill_in "login_email", :with => ""
    fill_in "login_password", :with => ""
    click_button "Log In"
  end

  def pay_bellatrix
    pay("bella61@hotmail.com", 300)
  end

  def pay_ivan
    pay("acostarubio@gmail.com", 300)
  end

  def pay_osledy
    pay("j0celyn_@hotmail.com", 200)
  end

  def pay_hugo
    pay("hugorincongmx@gmail.com", 200)
  end

  def pay(email, amount)
    visit("http://www.paypal.com")
    click_link("Send Money")
    fill_in "email", :with => email
    fill_in "amount", :with => amount
    choose("PurchaseServices")
    click_button("Continue")
    click_button("Send Money")
  end
end

@runner = FPL.new
@runner.pay

#@runner = Paypal.new
#@runner.pay_bellatrix
#@runner.pay_hugo
#@runner.pay_osledy
#@runner.pay_ivan
