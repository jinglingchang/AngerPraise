module Position

  attr_accessor :company_position_list

  def getPositionInfoByCompanyId(company_id)

    if company_id != nil

      company_module = CompanyModule.new

      company_module.getCompanyNameAndCompanyIdById(company_id)

      if company_module.company_id.to_i > 0

        position_module = PositionModule.new

        postion_result = position_module.getPositionInfoByCompanyId(company_module.company_id)

        self.company_position_list = postion_result

      end

    end

  end


end