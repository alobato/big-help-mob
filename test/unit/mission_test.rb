require 'test_helper'

class MissionTest < ActiveSupport::TestCase
  
  should_belong_to :organisation
  should_have_one  :address
  
  should_validate_presence_of :name
  
end

# == Schema Info
#
# Table name: missions
#
#  id              :integer(4)      not null, primary key
#  organisation_id :integer(4)
#  user_id         :integer(4)
#  description     :text            not null, default("")
#  name            :string(255)     not null
#  created_at      :datetime
#  occurs_at       :datetime        not null
#  updated_at      :datetime