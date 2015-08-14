class DictHirelibPositionRank < ActiveRecord::Base

  self.table_name = 'dict_hirelib_position_rank'

  establish_connection :database_dict

  #根据职级名称 获取ID
  def getPositionRankIdByRankName(name)

    if name.to_s != ''

      DictHirelibPositionRank.where('position_rank_name like "'+name+'"').select('hirelib_position_rank_id').take

    end

  end

end
