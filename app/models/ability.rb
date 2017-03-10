class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    # can :read, :all
      user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
      else
        can :read, :all
        can :create, Instruction
        can :create, Comment

        can :update, Instruction do |instruction|
          instruction.user == user
        end
    
        can :destroy, Instruction do |instruction|
          instruction.user == user
        end
    
        can :update, Comment do |comment|
          comment.user == user
        end
    
        can :destroy, Comment do |comment|
          comment.user == user
        end
    
      end    
  end
end
