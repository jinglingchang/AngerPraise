class EmployersUser < ActiveRecord::Base

  self.table_name = 'employers_user'

  establish_connection :database_employers

end
