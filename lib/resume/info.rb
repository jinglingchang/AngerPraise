module Info

  attr_accessor :resume_id

  def info_collect(review_section, user_id)

    user_info_hash = Hash.new

    resume_section_children = review_section.css('div')[0].children

    user_info_hash['name'] = resume_section_children[1].text.to_s.gsub(/\s+/, '').squish.to_s

    user_info_hash['dict_workexperice_id'] = self.hirelib_workexperience_corresponding(resume_section_children[2].text.to_s.gsub(/\s+/, '').gsub('（', '').gsub('）', '').to_s)

    user_info_hash['user_id'] = user_id

    resume_section_children.length.times do |number|

      name = resume_section_children[number].text.to_s.gsub(/\s+/, '').squish.to_s

      if name.empty?

      else

        if name.gsub!('|', ',')

          sexAndbirthDay = name.split(',')

          if sexAndbirthDay.length.to_i > 0

            sex_string = sexAndbirthDay[0].to_s.gsub(/\s+/, '').squish.to_s

            sex_info = DictSexes.where('sex like "'+sex_string.to_s+'"').take

            user_info_hash['dict_sex_id'] =sex_info['id']

            #-----------------------------------------------------

            birthday = sexAndbirthDay[1].to_s.gsub(/\s+/, '').gsub('年', '-').gsub('月', '-').gsub('日', '').to_s

            age = self.countAgeByBirthDay(birthday)

            #age_info = DictAges.where('begin_age >= '+age.to_s+' and end_age <= '+age.to_s).take

            user_info_hash['dict_age_id'] =age

          end

        end

        if name.gsub!('居住地：', '')

          user_info_hash['live'] = name

        end

        if name.gsub!('地址：', '')

          user_info_hash['address'] = name

        end


        if name.gsub!('户口：', '')

          user_info_hash['permanent'] = name

        end


        if name.gsub!('手机号：', '')

          user_info_hash['phone'] = name

        end

        if name.gsub!('邮箱：', '')

          user_info_hash['email'] = name

        end

        if name.gsub!('求职状态：', '')

          user_info_hash['position_status'] = name

        end

        if name.gsub!('目前年薪：', '')

          user_info_hash['year_money'] = name

        end

        if name.gsub!('关键词：', '')

          keyword = resume_section_children[number+1].text.to_s.gsub(/\s+/, '').squish.to_s

          if keyword.empty?

          else

            user_info_hash['keyword'] = keyword

          end


        end

      end

    end

    if user_info_hash.length.to_i > 0

      user_info_hash['source'] = '51job'

      resume =  Resumes.create(user_info_hash)

      self.resume_id = resume.id

    end


  end


  def countAgeByBirthDay(birthday)

    current_year = Time.at(Time.now.to_i).strftime('%Y').to_i

    current_month = Time.at(Time.now.to_i).strftime('%m').to_i

    current_day = Time.at(Time.now.to_i).strftime('%d').to_i

    year = DateTime.parse(birthday).strftime('%Y').to_i

    month = DateTime.parse(birthday).strftime('%m')

    day = DateTime.parse(birthday).strftime('%d')

    month_ = current_month.to_i - month.to_i

    day_ = current_day.to_i - day.to_i

    if month_ < 0

      year+=1

    elsif month_ == 0 and day_ < 0

      year+=1

    end

    age = current_year.to_i - year.to_i

    age

  end

end