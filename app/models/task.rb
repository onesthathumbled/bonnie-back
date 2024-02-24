class Task < ApplicationRecord
    acts_as_paranoid

    belongs_to :category

    validates :task_name, presence: true
    validates :task_details, presence: true

    enum priority: [:low, :medium, :high]
    validates :priority, inclusion: { in: priorities.keys }

    enum completion_status: [:backlog, :in_progress, :completed]
    validates :completion_status, inclusion: { in: completion_statuses.keys }
end
