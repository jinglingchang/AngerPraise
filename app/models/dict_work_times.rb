class DictWorkTimes < ActiveRecord::Base

  self.table_name = 'dict_work_times'

  establish_connection :database_dict


end
