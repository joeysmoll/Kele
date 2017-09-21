module Checkpoint
    def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment, enrollment_id)
        submisson_data = {body: {checkpoint_id: checkpoint_id, assignment_branch: assignment_branch, assignment_commit_link: assignment_commit_link, comment: comment, enrollment_id: enrollment_id}, headers: { "authorization" => @auth_token }}
        self.class.post(base_api_endpoint("checkpoint_submissions"), submisson_data)
    end
end