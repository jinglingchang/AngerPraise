module Skill

  def collect_skill(review_section,resume_id)

    if resume_id != nil

      project_hash = Hash.new

      resume_section_children = review_section.css('div')

      resume_section_children.length.times do |number|

        projectSkill_children = resume_section_children[number].children

        projectSkill_length = projectSkill_children.length

        projectSkill_length.times do |i|

          string = projectSkill_children[i].text.to_s.gsub(/\s+/, '').squish

          if string.empty?

          else

            string_split = string.split('|')

            project_hash['skill_name'] = string_split[0]

            project_hash['skill_level'] = string_split[1]

            project_hash['skill_time'] = string_split[2]

            if project_hash.length.to_i > 0

              project_hash['resume_id'] = resume_id

              ResumeSkill.create(project_hash)

            end


          end

        end


      end



    end



  end

end