class DictWorkPlaces < ActiveRecord::Base

  self.table_name = 'dict_work_places'

  establish_connection :database_dict

end
