class DictIndustryInfo < ActiveRecord::Base

  self.table_name = 'dict_industry_info'

  establish_connection :database_dict


end
