class PositionsAll < ActiveRecord::Base

  establish_connection :database_project

  self.table_name = 'positions_all'

end