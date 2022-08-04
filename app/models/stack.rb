class Stack < ApplicationRecord
    belongs_to :user
    has_many :links

    validates :title, presence: true, uniqueness: { scope: :user }

    after_create_commit { broadcast_append_to "stacks" }
    after_destroy_commit { broadcast_remove_to "stacks", target: "stack_#{self.id}" }
end
