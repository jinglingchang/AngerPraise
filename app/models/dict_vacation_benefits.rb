class DictVacationBenefits < ActiveRecord::Base

  self.table_name = 'dict_vacation_benefits'

  establish_connection :database_dict


end
