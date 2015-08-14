class InterviewEvaluation < ActiveRecord::Base

  self.table_name = 'interview_evaluation'

  establish_connection :database_anger

end
