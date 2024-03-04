require "test_helper"

class SessionsIntegrationTest < ActionDispatch::IntegrationTest
  test "register test" do
    user_data = {
      first_name:"John",
      last_name: "Doe",
      email: "johndoe@email.com",
      password: "pass123",
      password_confirmation: "pass123"
    }

    post '/signup', params: { user: user_data }
    assert_response :success

    if response.status == 200
      puts "Register Test: PASSED ✅"
    else
      puts "Login Test: FAILED ❌ (Internal Server Error)"
    end
  end

  test "register & login test" do
    user_register_data = {
      first_name: "John",
      last_name: "Doe",
      email: "johndoe@email.com",
      password: "pass123",
      password_confirmation: "pass123"
    }

    post '/signup', params: { user: user_register_data }

    user_login_data = {
      email: "johendoe@email.com",
      password: "pass123",
    }

    post '/login', params: { user: user_login_data }
    assert_response :success

    json_response = JSON.parse(response.body)

    if response.status == 200
      puts "Login Test: PASSED ✅"
    elsif response.status == 401
      puts "Login Test: FAILED ❌ (Unauthorized: Invalid email or password.)"
    elsif response.status == 500
      puts "Login Test: FAILED ❌ (Internal Server Error)"
    else
      puts "Login Test: FAILED ❌ (Unexpected response status: #{response.status})"
    end
  end

  # test "register, login, and create category test" do
  #   # Register
  #   user_data = {
  #     first_name: "Jai",
  #     last_name: "Madera",
  #     email: "jai13@email.com",
  #     password: "pass123",
  #     password_confirmation: "pass123"
  #   }

  #   post '/signup', params: { user: user_data }
  #   assert_response :success

  #   # Debugging: Output the user registration response body and user ID
  #   puts "Registration Response: #{response.body}"
  #   registered_user_id = JSON.parse(response.body)['data']['id']
  #   puts "Registered User ID: #{registered_user_id}"

  #   # Login
  #   user_login_data = {
  #     email: "jai13@email.com",
  #     password: "pass123",
  #   }

  #   post '/login', params: { user: user_login_data }

  #   # Debugging: Output the login response body
  #   puts "Login Response: #{response.body}"

  #   # Check if login was successful
  #   assert_response :success

  #   # Extract the authentication token from the response headers
  #   auth_token = response.headers['Authorization']

  #   # Print the extracted token for debugging
  #   puts "Authentication Token: #{auth_token}"

  #   # Check if auth_token is present
  #   assert_not_nil auth_token, "Authentication token is nil"

  #   # Create a category
  #   category_data = {
  #     "category_name": "Side Projects",
  #     "category_details": "List of my side 3"
  #   }

  #   # Include the extracted token in the request headers
  #   post "/api/v1/users/#{registered_user_id}/categories",
  #        params: { category: category_data },
  #        headers: { 'Authorization' => auth_token }

  #   # Debugging: Output the category creation response body
  #   puts "Category Creation Response: #{response.body}"

  #   # Check if category creation was successful
  #   assert_response :success

  #   json_response = JSON.parse(response.body)
  #   assert_equal 'Category created.', json_response['message']
  # end
end
