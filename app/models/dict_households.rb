class DictHouseholds < ActiveRecord::Base

  self.table_name = 'dict_households'

  establish_connection :database_dict

end
