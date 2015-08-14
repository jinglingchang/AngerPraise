module Rank


  def rankList

    @rankHash = Hash.new

    @rankHash[0] = Array['职员', '专员', '工程师', '分析师', '秘书', '程序', '开发', 'UI', '设计']

    @rankHash[1] = Array['总监', '经理', '主管']

    @rankHash[2] = Array['副总裁', '总裁']

    @rankResult = Array.new

  end


  def rankArrayResult

    rankArray = Array['职员/专员/工程师/分析师', '助理职员/专员/工程师/分析师', '高级职员/专员/工程师/分析师', '主管',
                      '高级主管', '经理', '高级经理', '总监', '高级总监', '执行总监', '副总裁', '高级副总裁', '执行副总裁', '总裁']

    rankArray

  end


  #通过职位名称和职位ID来计算职级

  def getRankByResumeNameAndResumeId(position_name, resume_id)

    if position_name.to_s != '' and resume_id.to_i > 0

      #根据职位名称来获取职级

      position_rank_result = self.getRank(position_name)

      if position_rank_result.length.to_i > 0

        p position_rank_result

        p position_rank_result.reverse

        # position_rank_result.each do |rank_name|
        #
        #   if rank_name.to_s != ''
        #
        #     rank_array = Hash.new
        #
        #     position_rank_dal = HirelibPositionRank.new
        #
        #     result = position_rank_dal.getPositionRankIdByRankName rank_name
        #
        #     if result['hirelib_position_rank_id'].to_i > 0
        #
        #       rank_array['position_id'] = position_id
        #
        #       rank_array['hirelib_rank_id'] = result['hirelib_position_rank_id']
        #
        #       PositionRank.create(rank_array)
        #
        #     end
        #
        #   end
        #
        # end

      end


    end

  end


  def getRank(name)

    self.rankList

    positionRankArray = self.rankArrayResult

    position_name_array = name.split('/')

    position_name_array_length = position_name_array.length

    if position_name_array_length.to_i > 0

      position_name_array.each do |split_name|

        self.searchRank(0, split_name)

        self.searchRank(1, split_name)

        self.searchRank(2, split_name)

      end


    end

    rankResult = @rankResult.uniq

    rankResultFina = Array.new

    if rankResult.length.to_i > 0

      rankResult.each do |result_value|

        rankResultFina << positionRankArray[result_value]


      end

    end

    rankResultFina

  end


  def searchRank(key, name)

    if key.to_s != '' and name.to_s != ''

      if @rankHash[key].length.to_i > 0

        @rankHash[key].each do |value|

          if name.index(value) != nil

            case key

              when 0 then

                self.searchRankOneAdvancesAndAssistant(name)

              when 1 then

                self.searchRankTwoAdvances(name, value)


              when 2 then

                self.searchRankThreeAdvances(name, value)

            end

          end

        end

      end


    end

  end

  #搜索职位 （职员/专员/工程师/分析师） 是否带有高级和助理 2词

  def searchRankOneAdvancesAndAssistant(name)

    array = Array['高级', '助理']

    result = -1

    if name.to_s != ''

      if array.length.to_i > 0

        array.each do |values|

          if name.index(values) != nil

            if values.to_s == '高级'

              result = 2

            else

              result = 1

            end

            break

          else

            result = 0

          end

        end

      end


    end

    if result.to_i != -1

      @rankResult << result

    end


  end


  #搜索职位 （'总监', '经理', '主管'） 是否有高级主管 经理 总监
  def searchRankTwoAdvances(name, job_name)

    result = -1

    if name.to_s != '' and job_name.to_s != ''

      number = name.index('高级')

      case job_name

        #判断job_name 如是总监词语 则进行特别判断

        when '总监' then

          if number != nil

            result = 8

          elsif name.index('执行') != nil

            result  = 9

          else

            result = 7

          end

        when '经理' then

          if number != nil

            result = 6

          else

            result = 5

          end


        when '主管' then

          if number != nil

            result = 4

          else

            result = 3

          end


      end

      if result.to_i != -1

        @rankResult << result

      end


    end

  end

  #搜索职位中是否带有以下词语(副总裁', '总裁')

  def searchRankThreeAdvances(name, job_name)

    if name.to_s != '' and job_name != ''

      case job_name

        when '副总裁' then

          if name.index('高级') != nil

            @rankResult << 11


          elsif name.index('执行') != nil

            @rankResult << 12

          else

            @rankResult << 10

          end

        when '总裁' then

          #查询文字中是否有副字 如有副 则不归属到总裁类别

          if name.index('副'.to_s) == nil

            @rankResult << 13

          end


      end

    end

  end


end