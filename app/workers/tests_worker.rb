class TestsWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  def perform(assignment_id)
    assignment = Assignment.find(assignment_id)
    puts "[INFO]: Starting TESTS worker for assignment #{assignment_id}."
    list_of_submissions = assignment.submissions.where(submitted: true)
    job_ids = ""
    puts "[INFO]: Found #{list_of_submissions.length} submissions."
    list_of_submissions.each do |submission|
      curr = JunitWorker.perform_async(assignment_id, submission.id)
      if job_ids == ""
        job_ids = "#{curr}"
      else
        job_ids = "#{job_ids},#{curr}"
      end
    end
    store all_jobs: job_ids
  end

end
