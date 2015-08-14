module Language

  def collect_language(review_section, resume_id)

    if resume_id != nil

      project_hash = Hash.new

      language_hash = Hash.new

      project_array = Array['英语等级', '日语等级', 'TOEFL', 'GRE', 'GMAT', 'TOEIC', 'IELTS']

      resume_section_children = review_section.css('div')

      resume_section_children.length.times do |number|

        projectExperience_children = resume_section_children[number].children

        projectExperience_length = projectExperience_children.length

        projectExperience_length.times do |v|

          name = projectExperience_children[v].text.to_s.gsub(/\s+/, '').squish

          check = 0

          if name.empty?

          else

            project_array.length.times do |array_number|

              string_index = name.index(project_array[array_number])

              if string_index != nil

                # if project_array[array_number] == '英语等级'
                #
                #   project_hash['english'] = name.gsub(project_array[array_number].to_s+'：', '')
                #
                # elsif project_array[array_number] == '日语等级'
                #
                #   project_hash['japan'] = name.gsub(project_array[array_number].to_s+'：', '')
                # else
                #
                #   project_hash[project_array[array_number]] = name.gsub(project_array[array_number].to_s+'：', '')
                #
                # end


                check = 1

              end

            end


            if check == 0

              yuyan = name.split('|')

              p name

              if yuyan != nil and yuyan.length.to_i > 0

                language_hash['language'] = yuyan[0].split('（')[0]

                language_hash['language_level'] = yuyan[0].split('（')[1].chop

                language_hash['listen']= yuyan[1].split('（')[0]

                language_hash['listen_level'] =yuyan[1].split('（')[1].chop

                language_hash['writes']= yuyan[2].split('（')[0]

                language_hash['write_level'] =yuyan[2].split('（')[1].chop

                if language_hash.length.to_i > 0

                  language_hash['resume_id'] = resume_id

                  ResumeLanguage.create(language_hash)

                end

              end


            end


          end

        end
      end

      if project_hash.length.to_i > 0

        project_hash['resume_id'] = resume_id

        ResumeLanguage.create(project_hash)

      end


    end


  end


end