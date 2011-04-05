require 'rspec'
require 'moomoo'
require 'vcr'

VCR.config do |c|
    c.cassette_library_dir = 'spec/vcr_cassettes'
    c.stub_with :webmock
    c.default_cassette_options = {:record => :new_episodes}
end

def live_test?
  !ENV['OPENSRS_REAL'].nil?
end

Rspec.configure do |c|
  c.extend VCR::RSpec::Macros
  c.before(:each) do 
    if live_test?
      @opensrs_host = ENV['OPENSRS_TEST_URL']
      @opensrs_key = ENV['OPENSRS_TEST_KEY']
      @opensrs_user = ENV['OPENSRS_TEST_USER']
      @opensrs_pass = ENV['OPENSRS_TEST_PASS']
    else
      @opensrs_host = 'horizon.opensrs.net'
      @opensrs_key = '123key'
      @opensrs_user = 'opensrs_user'
      @opensrs_pass = 'password'
    end
  end
end
