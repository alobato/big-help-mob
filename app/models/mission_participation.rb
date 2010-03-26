class MissionParticipation < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :mission
  belongs_to :role
  belongs_to :pickup
  
  validates_presence_of :user, :mission, :pickup
  validates_associated  :answers
  
  attr_accessible :mission_id, :user_attributes, :pickup_id, :answers
  
  after_validation :autoset_awaiting_approval, :on => :update
  
  accepts_nested_attributes_for :user
  
  scope :with_role, includes(:role).where('role_id IS NOT NULL')
  scope :for_user, lambda { |u| includes(:user).where(:user_id => u.id) }

  state_machine :initial => :created do
    state :created
    state :filled_in
    state :approved
    state :completed
    state :cancelled
    
    event :await_approval do
      transition :created => :awaiting_approval
    end
    
    event :approve do
      transition [:created, :awaiting_approval] => :approved
    end
    
    event :cancel do
      transition any => :cancelled
    end
    event :complete do
      transition :approved => :completed
    end
  end
  
  def role_name
    ActiveSupport::StringInquirer.new(self.role.try(:name).to_s)
  end
  
  def role_name=(value)
    self.role = Role::PUBLIC_ROLES.include?(value) ? Role[value] : nil
  end
  
  def update_with_conditional_save(attributes, perform_save = true)
    self.attributes = attributes
    perform_save && save
  end
  
  def alternate_role
    Role::PUBLIC_ROLES[((Role::PUBLIC_ROLES.index(role_name) || 0) + 1) % Role::PUBLIC_ROLES.length]
  end
  
  def answers
    @answers ||= AnswerProxy.new(self)
  end
  
  def answers=(value)
    answers.attributes = value
  end
  
  def autoset_awaiting_approval
    await_approval(false) if created?
  end
  
  def state_events_for_select
    state_events.map do |se|
      name = ::I18n.t(:"#{self.class.model_name.underscore}.#{se}", :default => se.to_s.humanize, :scope => :"ui.state_events")
      [name, se]
    end
  end
  
end

# == Schema Info
#
# Table name: mission_participations
#
#  id         :integer(4)      not null, primary key
#  mission_id :integer(4)
#  pickup_id  :integer(4)
#  role_id    :integer(4)
#  user_id    :integer(4)
#  state      :string(255)
#  created_at :datetime
#  updated_at :datetime