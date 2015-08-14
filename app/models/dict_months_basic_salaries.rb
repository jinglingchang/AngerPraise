class DictMonthsBasicSalaries < ActiveRecord::Base

  self.table_name = 'dict_months_basic_salaries'

  establish_connection :database_dict


end
