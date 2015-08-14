
require 'father_module'

require 'positiion/search'

require 'positiion/detail'


require 'positiion/curd'

require 'positiion/apply'

require 'positiion/competitiveness'

class PositionModule < FatherModule

  include Search

  include Info

  include Curd

  include Apply

  include Competitiveness

end