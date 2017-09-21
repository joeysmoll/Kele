module Messaging
    
    def get_messages(*page)
        if page == []
            response = self.class.get(base_api_endpoint("/message_threads"), headers: { "authorization" => @auth_token })
        else
            response = self.class.get(base_api_endpoint("/message_threads?page=#{page[0]}"), headers: { "authorization" => @auth_token})
        end
        
        @messages = JSON.parse(response.body)
    end
    
    def create_message(sender_email, recipient_id, token, message_subject, message_body)
        message_data = {body: {sender: sender_email, recipient_id: recipient_id, token: token, subject: message_subject, stripped: message_body}, headers: { "authorization" => @auth_token }}    
        self.class.post(base_api_endpoint("messages"), message_data)
    end
    
    def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
        submission = {body: {checkpoint_id: checkpoint_id, assignment_branch: assignment_branch, assignment_commit_link: assignment_commit_link, comment: comment, enrollment_id: 28986}, headers: { "authorization" => @auth_token }}
        self.class.post(base_api_endpoint("checkpoint_submissions"), submission)
    end
    
end