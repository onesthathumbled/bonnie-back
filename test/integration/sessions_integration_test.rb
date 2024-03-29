require "test_helper"

class SessionsIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    @user = {
      first_name:"John",
      last_name: "Doe",
      email: "johndoe@email.com",
      password: "pass123",
      password_confirmation: "pass123"
    }

    @category = {
      "category_name": "Work",
      "category_details": "All about work"
    }

    @task = {
      task_name: "Make a Stock Trading App",
      task_details: "Details of stock trading app.",
      priority: "high",
    }
  end

  # Register Test
  test "register test" do
    post '/signup', params: { user: @user}
    assert_response :success

    if response.status == 200
      puts "Register Test: PASSED ✅"
    else
      puts "Login Test: FAILED ❌ (Internal Server Error)"
    end
  end

  # Login Test
  test "register & login test" do
    post '/signup', params: { user: @user }
    post '/login', params: { user: @user }
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

  # Create Category Test
  test "create category test" do
    post '/signup', params: { user: @user }
    assert_response :success
    post '/login', params: { user: @user }
    assert_response :success

    json_response = JSON.parse(response.body)
    user_id = json_response['data']['id'].to_s
    auth_token = response.headers['Authorization']

    post "/api/v1/categories",
         params: { category: @category },
         headers: { 'Authorization' => auth_token }
    assert_response :success

    if response.status == 200
      puts "Create Category Test: PASSED ✅"
    else
      puts "Create Category Test: FAILED ❌ (Internal Server Error)"
    end
  end

  # Delete Category Test
  test "delete category test" do
    post '/signup', params: { user: @user }
    assert_response :success
    post '/login', params: { user: @user }
    assert_response :success

    json_response = JSON.parse(response.body)
    user_id = json_response['data']['id'].to_s
    auth_token = response.headers['Authorization']

    post "/api/v1/categories",
         params: { category: @category },
         headers: { 'Authorization' => auth_token }
    assert_response :success

    category_response = JSON.parse(response.body)
    category_id = category_response['id'].to_s

    delete "/api/v1/categories/#{category_id}",
         headers: { 'Authorization' => auth_token }
    assert_response :success

    if response.status == 204
      puts "Delete Category Test: PASSED ✅"
    else
      puts "Delete Category Test: FAILED ❌ (Internal Server Error)"
    end
  end

  # Create Task Test
  test "create task test" do
    post '/signup', params: { user: @user }
    assert_response :success
    post '/login', params: { user: @user }
    assert_response :success

    json_response = JSON.parse(response.body)
    user_id = json_response['data']['id'].to_s
    auth_token = response.headers['Authorization']

    post "/api/v1/categories",
         params: { category: @category },
         headers: { 'Authorization' => auth_token }
    assert_response :success

    category_response = JSON.parse(response.body)
    category_id = category_response['id'].to_s
   
    

    post "/api/v1/categories/#{category_id}/tasks",
         params: { task: @task },
         headers: { 'Authorization' => auth_token }
    assert_response :success

    if response.status == 200
      puts "Create Task Test: PASSED ✅"
    else
      puts "Create Task Test: FAILED ❌ (Internal Server Error)"
    end
  end

  # Delete Task Test
  test "delete task test" do
    post '/signup', params: { user: @user }
    assert_response :success
    post '/login', params: { user: @user }
    assert_response :success

    json_response = JSON.parse(response.body)
    user_id = json_response['data']['id'].to_s
    auth_token = response.headers['Authorization']

    post "/api/v1/categories",
         params: { category: @category },
         headers: { 'Authorization' => auth_token }
    assert_response :success

    category_response = JSON.parse(response.body)
    category_id = category_response['id'].to_s

    post "/api/v1/categories/#{category_id}/tasks",
         params: { task: @task },
         headers: { 'Authorization' => auth_token }
    assert_response :success

    task_response = JSON.parse(response.body)
    task_id = task_response['id'].to_s

    delete "/api/v1/categories/#{category_id}/tasks/#{task_id}",
         headers: { 'Authorization' => auth_token }
    assert_response :success
  
    if response.status == 204
      puts "Delete Task Test: PASSED ✅"
    else
      puts "Delete Task Test: FAILED ❌ (Internal Server Error)"
    end
  end
end
