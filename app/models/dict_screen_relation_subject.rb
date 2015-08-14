class DictScreenRelationSubject < ActiveRecord::Base

  self.table_name = 'dict_screen_relation_subject'

  establish_connection :database_dict


end
