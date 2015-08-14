class DictHirelibCompensation < ActiveRecord::Base

  self.table_name = 'dict_hirelib_compensation'

  establish_connection :database_dict


end
