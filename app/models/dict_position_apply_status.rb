class DictPositionApplyStatus < ActiveRecord::Base

  self.table_name = 'dict_position_apply_status'

  establish_connection :database_dict
end
