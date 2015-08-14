require 'nokogiri'

require 'father_module'

require 'resume/collect'

require 'resume/info'

require 'resume/intension'

require 'resume/work_experience'

require 'resume/project_experience'

require 'resume/education'

require 'resume/train'

require 'resume/language'

require 'resume/skill'

require 'resume/create'

require 'resume/rank'

require 'resume/match'

require 'resume/quality'

require 'resume/competitiveness'

require 'resume/synthesize_grade'

require 'resume/perject'

class ResumeModule < FatherModule

  include Info

  include Collect

  include Intension

  include WorkExperience

  include ProjectExperience

  include Education

  include Train

  include Language

  include Skill

  include Create

  include Rank

  include Quality

  include Match

  include Competitiveness

  include Perfect

  include SynthesizeGrade

end