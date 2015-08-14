module Intension

  def collect_intension(review_section, resume_id)

    if resume_id != nil

      update = Hash.new

      resume_section_children = review_section.css('div')[0].children

      user_resume = Resumes.where('id = '+resume_id.to_s).take

      resume_section_children.length.times do |number|

        name = resume_section_children[number].text.to_s.gsub(/\s+/, '').squish.to_s

        if name.empty?

        else

          if name.gsub!('到岗时间：', '')

            update['work_time'] = name

          end


          if name.gsub!('工作性质：', '')

            update['nature_work'] = name

          end


          if name.gsub!('希望行业：', '')

            update['hope_industry'] = name

          end

          if name.gsub!('目标地点：', '')

            update['target_site'] = name

          end

          if name.gsub!('期望薪水：', '')

            update['hope_pay'] = name

          end

          if name.gsub!('目标职能：', '')

            update['objective_functions'] = name

          end

        end

      end

      if update.length.to_i > 0

        if user_resume != nil

          user_resume.update(update)

        end

      end

    end


  end

end