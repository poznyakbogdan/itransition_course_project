ThinkingSphinx::Index.define :instruction, :with => :real_time do
  indexes name, :sortable => true
  indexes steps.title, :as => :step_title
  indexes steps.description, :as => :step_description
  indexes user.name, :as => :user_name
  indexes category.name, :as => :category_name
  indexes comments.content, :as => :comment_content
  # indexes comments.user, :as => :comment_user
end