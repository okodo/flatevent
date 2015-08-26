class Comment < ActiveRecord::Base

  belongs_to :event
  belongs_to :user

  validates :body, presence: true

  default_scope { order("comments.created_at DESC") }

  def as_json(options = {})
    super(options.merge(include: :user))
  end
end
