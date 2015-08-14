module Train

  def collect_train(review_section, resume_id)

    if resume_id != nil

      project_hash = Hash.new

      resume_section_children = review_section.css('div')

      resume_section_children.length.times do |number|

        projectTrain_children = resume_section_children[number].children

        projectTrain_length = projectTrain_children.length

        #---------------抓取项目经验的时间------------------------------

        work_year = projectTrain_children[0].text.chop.to_s.split('―')

        project_hash['begin_work'] = work_year[0]

        project_hash['end_work'] = work_year[1]

        project_hash['train_school'] = projectTrain_children[1].text

        project_hash['train_course'] = projectTrain_children[3].text

        projectTrain_length.times do |v|

          name = projectTrain_children[v].text.to_s.gsub(/\s+/, '').squish.chop

          if name.gsub!('详细描述', '')

            project_hash['train_detail'] = projectTrain_children[v+1].text

          end

        end

        if project_hash.length.to_i > 0

          project_hash['resume_id'] = resume_id

          ResumeTrain.create(project_hash)

        end

      end


    end

  end

end