require 'father_module'

require 'company/info'

require 'company/collect'

require 'company/position'

class CompanyModule < FatherModule

  include Info

  include Collect

  include Position

end