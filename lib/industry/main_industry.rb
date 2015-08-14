module MainIndustry

  attr_accessor :main_industry_id

  attr_accessor :main_industry_name

  attr_accessor :industry_detail


  def getMainIndustry

    industry_dal = HirelibIndustry.new

    array = Array.new

    result = industry_dal.getAllIndustry

    if result != nil

      key = 0

      result.each do |v|

        industry_module = IndustryModule.new

        industry_module.main_industry_id = v['hirelib_industry_id']

        industry_module.main_industry_name = v['hirelib_industry_name']

        industry_module.getIndustryDetail(v['hirelib_industry_id'])

        array << industry_module

      end

      array

    end

  end

end