class DictHirelibWorkExperience < ActiveRecord::Base


  self.table_name = 'dict_hirelib_work_experience'

  establish_connection :database_dict

end
