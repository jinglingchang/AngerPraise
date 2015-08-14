module ProjectExperience

  def collect_projectexperience(review_section, resume_id)

    if resume_id != nil

      project_hash = Hash.new

      resume_section_children = review_section.css('div')

      resume_section_children.length.times do |number|

        projectExperience_children = resume_section_children[number].children

        projectExperience_length = projectExperience_children.length

        #---------------抓取项目经验的时间------------------------------

        work_year = projectExperience_children[0].text.chop.to_s.split('―')

        project_hash['begin_time'] = work_year[0]

        project_hash['end_time'] = work_year[1]


        project_hash['project'] = projectExperience_children[1].text

        project_hash['project_introduce'] = projectExperience_children[4].text

        project_hash['responsible'] = projectExperience_children[7].text



        if project_hash.length.to_i > 0

          project_hash['resume_id'] = resume_id

          ResumeProject.create(project_hash)

        end

      end

    end


  end

end