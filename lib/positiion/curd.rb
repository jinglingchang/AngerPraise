module Curd

  def searchPositionById(id)

    if id.to_i > 0

      position_result = PositionsAll.where('id = '+id.to_s).take

      if position_result != nil

        return  position_result['id'].to_i

      else


        self.setErrorCode(20000)

        return 0

      end

    end

  end


end