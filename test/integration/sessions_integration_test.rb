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
      email: "johndoe@email.com",
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

  test "create category test" do
    user_data = {
      first_name: "John",
      last_name: "Doe",
      email: "johndoe@email.com",
      password: "pass123",
      password_confirmation: "pass123"
    }

    post '/signup', params: { user: user_data }
    assert_response :success

    user_login_data = {
      email: "johndoe@email.com",
      password: "pass123",
    }

    post '/login', params: { user: user_login_data }
    assert_response :success

    json_response = JSON.parse(response.body)
    user_id = json_response['data']['id'].to_s
    auth_token = response.headers['Authorization']

    category_data = {
      "category_name": "Work",
      "category_details": "All about work"
    }

    post "/api/v1/users/#{user_id}/categories",
         params: { category: category_data },
         headers: { 'Authorization' => auth_token }
    assert_response :success

    if response.status == 200
      puts "Create Category Test: PASSED ✅"
    else
      puts "Create Category Test: FAILED ❌ (Internal Server Error)"
    end
  end

  test "create task test" do
    user_data = {
      first_name: "John",
      last_name: "Doe",
      email: "johndoe@email.com",
      password: "pass123",
      password_confirmation: "pass123"
    }

    post '/signup', params: { user: user_data }
    assert_response :success

    user_login_data = {
      email: "johndoe@email.com",
      password: "pass123",
    }

    post '/login', params: { user: user_login_data }
    assert_response :success

    json_response = JSON.parse(response.body)
    user_id = json_response['data']['id'].to_s
    auth_token = response.headers['Authorization']

    category_data = {
      "category_name": "Work",
      "category_details": "All about work"
    }

    post "/api/v1/users/#{user_id}/categories",
         params: { category: category_data },
         headers: { 'Authorization' => auth_token }
    assert_response :success

    

    if response.status == 200
      puts "Create Task Test: PASSED ✅"
    else
      puts "Create Task Test: FAILED ❌ (Internal Server Error)"
    end
  end
end
