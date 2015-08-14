require 'industry/industry_detail'

require 'industry/main_industry'

require 'father_module'

class IndustryModule < FatherModule

  include MainIndustry

  include IndustryDetail




end