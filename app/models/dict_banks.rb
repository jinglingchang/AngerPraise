class DictBanks < ActiveRecord::Base

  self.table_name = 'dict_banks'

  establish_connection :database_dict
end
