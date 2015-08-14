module Collect

  def resume_collect(html, user_id)

    doc = Nokogiri::HTML.parse(html)

    resume_review = doc.css('.contaner>div>.jlprev')

    resume_review_section = resume_review.css('section')

    if resume_review.length.to_i > 0

      if resume_review_section.length.to_i > 0

        resume_review_section_length = resume_review_section.length

        resume_module = ResumeModule.new

        resume_review_section_length.times do |i|

          #获取当前SECTION是哪个分类

          type_name = resume_review_section[i].css('p')

          if type_name != nil

            if type_name.length.to_i == 1

              type_name_string = type_name.text

            else

              type_name_string = type_name[0].text

            end

            case type_name_string

              when '个人信息'

                resume_module.info_collect(resume_review_section[i], user_id)

              when '自我评价'

                update = Hash.new

                update['self_evaluation'] = resume_review_section[i].css('div').text

                app_resume = Resumes.where('id = '+ resume_module.resume_id.to_s).take

                app_resume.update(update)

              when '求职意向'

                resume_module.collect_intension(resume_review_section[i], resume_module.resume_id)

              when '工作经验'

                resume_module.collect_workExperience(resume_review_section[i], resume_module.resume_id)

              when '项目经验'

                resume_module.collect_projectexperience(resume_review_section[i], resume_module.resume_id)

              when '教育经历'

                resume_module.collect_education(resume_review_section[i], resume_module.resume_id)

              when '培训经历'

                resume_module.collect_train(resume_review_section[i], resume_module.resume_id)

              when '语言能力'

                resume_module.collect_language(resume_review_section[i], resume_module.resume_id)

              when 'IT能力'

                resume_module.collect_skill(resume_review_section[i], resume_module.resume_id)

            end

          end


        end

        self.res = 1.to_s


      end

    else

      self.setErrorCode(40000)

    end

  end


end