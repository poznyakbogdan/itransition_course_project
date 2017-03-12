class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    # can :read, :all
      user ||= User.new 
      if user.admin?
        can :manage, :all
      else
        can :read, :all

        can :text_search, Instruction

        can [:tag_name_list, :upvote, :downvote, :create], Instruction do |instruction|
          user.id
        end

        can :update, Instruction do |instruction|
          instruction.user == user
        end
    
        can :destroy, Instruction do |instruction|
          instruction.user == user
        end
    
        can :create, Comment do |comment|
            user.id
        end

        can [:update, :destroy], Comment do |comment|
          comment.user == user
        end
    
        # can :destroy, Comment do |comment|
        #   comment.user == user
        # end
    
      end    

  end
end
