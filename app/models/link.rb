class Link < ApplicationRecord
  belongs_to :stack

  validates :displayname, presence: true, uniqueness: { scope: :stack }
  
  after_create_commit { broadcast_append_to "links", target: "stack_#{self.stack.id}_links" }
  after_destroy_commit { broadcast_remove_to "links", target: "stack_#{self.stack.id}_links"}
end
