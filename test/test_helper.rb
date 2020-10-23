ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def is_login?
    !session[:user_id].nil?
  end

  def login
    # ユーザーを1名作成して、ログイン状態にする
    params = {
      user: {
        email: "testtest@gmail.com",
        password: "testtest"
      }
    }

    post users_url, params: params
  end
end
