module Collect

  def companyCollectByUserIdAndCompanyId(user_id, company_id)

    if user_id.to_i > 0 and company_id.to_i > 0

      user_module = UserModule.new

      user_module.userInfo(user_id)

      if user_module.user_id.to_i > 0

        company_module = CompanyModule.new

        company_module.getCompanyDetailById(company_id)

        if company_module.id.to_i > 0

          user_collect_dal = UserCollect.new

          user_collect_dal.createUserCompanyCollect(user_id,company_id)

          self.res = 1

        else

          self.setErrorCode(company_module.code)

        end

      else

        self.setErrorCode(user_module.code)

      end


    end

  end

end