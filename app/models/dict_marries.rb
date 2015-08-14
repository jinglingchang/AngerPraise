class DictMarries < ActiveRecord::Base

  self.table_name = 'dict_marries'

  establish_connection :database_dict

end
