require "httparty"


class Kele
    include HTTParty
    def initialize(email, password)
        response = self.class.post(base_api_endpoint("sessions"), body: { "email": email, "password": password })
        @auth_token = response["auth_token"]
        raise InvalidStudentCodeError.new() if response.code == 401
        
    end


    private
    
    def base_api_endpoint(end_point)
        "https://www.bloc.io/api/v1/#{end_point}"
    end
end