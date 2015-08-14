class DictResumeLanguages < ActiveRecord::Base

  self.table_name = 'dict_resume_languages'

  establish_connection :database_dict

end
