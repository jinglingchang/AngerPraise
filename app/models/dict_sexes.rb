class DictSexes < ActiveRecord::Base

  self.table_name = 'dict_sexes'

  establish_connection :database_dict


end
