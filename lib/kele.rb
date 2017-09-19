require "httparty"
require 'json'

class Kele
    include HTTParty
    def initialize(email, password)
        response = self.class.post(base_api_endpoint("sessions"), body: { "email": email, "password": password })
        @auth_token = response["auth_token"]
        raise InvalidStudentCodeError.new() if response.code == 401
    end
    
    def get_me
        response = self.class.get(base_api_endpoint("users/me"), headers: { "authorization" => @auth_token})
        @user_data = JSON.parse(response.body)
    end
    
    def get_mentor_availability(mentor_id)
        availability_uri = "/mentors/#{mentor_id}/student_availability"
        response = self.class.get(base_api_endpoint(availability_uri), headers: { "authorization" => @auth_token})
        json_body = response.body
        JSON.parse(json_body)
    end

    private
    def base_api_endpoint(end_point)
        "https://www.bloc.io/api/v1/#{end_point}"
    end
end