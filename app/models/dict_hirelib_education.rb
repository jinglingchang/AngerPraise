class DictHirelibEducation < ActiveRecord::Base

  self.table_name = 'dict_hirelib_education'

  establish_connection :database_dict

end
