class EmployersAccount < ActiveRecord::Base

  self.table_name = 'employers_account'

  establish_connection :database_employers

end
