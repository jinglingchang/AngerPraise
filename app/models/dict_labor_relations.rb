class DictLaborRelations < ActiveRecord::Base

  self.table_name = 'dict_labor_relations'

  establish_connection :database_dict

end
