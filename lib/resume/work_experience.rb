module WorkExperience


  #收集工作经验

  def collect_workExperience(review_section, resume_id)

    if resume_id != nil

      resume_section_children = review_section.css('div')

      if resume_section_children.length.to_i > 0

        resume_section_children.length.times do |divNumber|

          user_work_experience_hash = Hash.new

          resume_section_children_result = resume_section_children[divNumber].children

          #---------------------------------------------

          work_year = resume_section_children_result[0].text.chop.to_s.split('―')

          user_work_experience_hash['begin_time'] = work_year[0]

          user_work_experience_hash['end_time'] = work_year[1]

          #--------------------------------------------

          user_work_experience_hash['company'] = resume_section_children_result[1].text.to_s

          #--------------------------------------------------

          result = resume_section_children_result[2].text.gsub(/\s+/, '').squish.to_s.split('|')

          user_work_experience_hash['company_industry'] = result[1]

          user_work_experience_hash['company_scale'] = result[2]

          user_work_experience_hash['department'] = resume_section_children_result[4].text

          user_work_experience_hash['position'] = resume_section_children_result[6].text

          user_work_experience_hash['responsible'] = resume_section_children_result[9].text


          if user_work_experience_hash.length.to_i > 0

            user_work_experience_hash['resume_id'] = resume_id

            ResumeWorkexperience.create(user_work_experience_hash)

          end

        end

      end

    end


  end


  def hirelib_workexperience_corresponding(work_experience_name)

    if work_experience_name.to_s.empty?

    else

      work_exerience = DictJobWorkExperience.where('51job_work_experience_name like "'+work_experience_name.to_s+'"').take

      if work_exerience != nil

        work_exerience['hirelib_work_experience_id']

      end

    end

  end

end