class DictArea < ActiveRecord::Base

  self.table_name = 'dict_area'

  establish_connection :database_dict
end
