class DictJobCompensation < ActiveRecord::Base

  self.table_name = 'dict_51job_compensation'

  establish_connection :database_dict

end
