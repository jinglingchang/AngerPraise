class DictJobEducation < ActiveRecord::Base

  self.table_name = 'dict_51job_education'

  establish_connection :database_dict
end
