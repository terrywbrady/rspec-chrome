require 'colorize'
require 'capybara/dsl'
require 'capybara/rspec'
require 'byebug'

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
  config.include Capybara::DSL
end

def create_web_session
  Capybara.app_host = 'https://github.com'
  Capybara.run_server = false # don't start Rack

  if ENV['CHROME_URL']
    Capybara.register_driver :selenium_chrome_headless do |app|
      args = [
        '--no-default-browser-check',
        '--start-maximized',
        '--headless',
        '--disable-dev-shm-usage',
        '--whitelisted-ips'
      ]
      caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {
        "args" => args,
        "prefs" => {
          'download.default_directory' => '/tmp',
          'download.directory_upgrade' => true,
          'download.prompt_for_download' => false
        }
      })

      Capybara::Selenium::Driver.new(
        app,
        browser: :remote,
        desired_capabilities: caps,
        url: ENV['CHROME_URL']
      )
    end
  end
  @session = Capybara::Session.new(:selenium_chrome_headless)
  #@session = Capybara::Session.new(:selenium_chrome)
end
