class DictIndustryFunctions < ActiveRecord::Base

  self.table_name = 'dict_industry_functions'

  establish_connection :database_dict


end
