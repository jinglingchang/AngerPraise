class DictAges < ActiveRecord::Base

  self.table_name = 'dict_ages'

  establish_connection :database_dict

end
