class DictBusinessTrips < ActiveRecord::Base

  self.table_name = 'dict_business_trips'

  establish_connection :database_dict

end
