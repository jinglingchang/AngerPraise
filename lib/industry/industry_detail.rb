module IndustryDetail

  attr_accessor :industry_detail_id

  attr_accessor :industry_main_id

  attr_accessor :industry_broad_name

  def getIndustryDetail(main_industry_id)

    if main_industry_id.to_i > 0

      industry_detail_result = Array.new

      result = HirelibIndustryInfo.where('industry_id = ' + main_industry_id.to_s + ' and industry_type = 0')

      if result != nil

        key = 0

        result.each do |v|

          industry_detail_module = IndustryModule.new

          industry_detail_module.industry_detail_id = v['industry_info_id']

          industry_detail_module.industry_main_id = v['industry_id']

          industry_detail_module.industry_broad_name = v['industry_broad_name']

          industry_detail_result << industry_detail_module

        end

      end

      self.industry_detail = industry_detail_result

    end

  end

end