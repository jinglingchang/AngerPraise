module Education

  def collect_education(review_section,resume_id)

    if resume_id != nil

      education_hash = Hash.new

      resume_section_children = review_section.css('div')

      resume_section_children.length.times do |number|

        projectEducation_children = resume_section_children[number].children

        projectExperience_length = projectEducation_children.length

        #---------------抓取教育的时间以及学校------------------------------

        work_year = projectEducation_children[0].text.chop.to_s.split('―')

        education_hash['begin_time'] = work_year[0]

        education_hash['end_time'] = work_year[1]

        education_hash['school'] = projectEducation_children[1].text

        #---------------抓取专业和学历－－－－－－－－－－－－－－－－－

        education_info = projectEducation_children[2].to_s.gsub(/\s+/, '').squish.split('|')

        education_hash['major'] = education_info[1]

        education_hash['education'] = education_info[2]

        education_hash['describes'] = projectEducation_children[5].text



        if education_hash.length.to_i > 0

          education_hash['resume_id'] = resume_id

          ResumeEducation.create(education_hash)

        end

      end


    end

  end

end