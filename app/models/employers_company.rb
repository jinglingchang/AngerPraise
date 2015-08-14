class EmployersCompany < ActiveRecord::Base

  self.table_name = 'employers_company'

  establish_connection :database_employers
end
