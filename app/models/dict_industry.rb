class DictIndustry < ActiveRecord::Base

  self.table_name = 'dict_industry'

  establish_connection :database_dict


end
