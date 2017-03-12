ThinkingSphinx::Index.define :instruction, :with => :active_record do
  indexes name, :sortable => true
  indexes steps.title, :as => :step_title
  indexes steps.description, :as => :step_description
end