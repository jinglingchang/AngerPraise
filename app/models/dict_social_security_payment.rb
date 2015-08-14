class DictSocialSecurityPayment < ActiveRecord::Base

  self.table_name = 'dict_social_security_payment'

  establish_connection :database_dict


end
