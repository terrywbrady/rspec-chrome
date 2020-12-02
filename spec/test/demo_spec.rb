require 'spec_helper.rb'
require 'webdrivers/chromedriver'

sleep 1

RSpec.describe 'basic_tests', type: :feature do
  before(:each) do
    @session = create_web_session
  end

  it 'Load page' do
    @session.visit '/docker/compose/releases/tag/1.27.0'
    @session.find_link('Source code (zip)')
    @session.click_link('Source code (zip)')
    sleep 3
    f = File.join('compose-1.27.0.zip')
    expect(File.exists?(f)).to be true
    File.delete(f)
  end

end
