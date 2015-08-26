class Event < ActiveRecord::Base
  ## Model extensions
  extend Enumerize

  has_many :comments, dependent: :destroy
  belongs_to :user

  ## Enumerize attributes
  enumerize :recurs_on, in: %i(n_a day week month year), scope: true, predicates: { prefix: true }

  ## Validation
  validates :title, presence: true
  validates_datetime :starts_at

  def as_json(options = {})
    attrs_hash = {"startsAt" => self.starts_at.to_f*1000, type: "info", editable: true, deletable: true, draggable: false, incrementsBadgeTotal: true,
      "recurs_on_text" => self.recurs_on.text}
    attrs_hash.merge({ "recursOn" => self.recurs_on }) if self.recurs_on_year? || self.recurs_on_month?
    super(options.merge(include: [:user, comments: {include: :user}])).
      merge(attrs_hash)
  end
end
