class Movie < ApplicationRecord
  has_many :bookmarks, dependent: :restrict_with_error

  validates :title, uniqueness: { case_sensitive: false }
  validates :overview, uniqueness: { case_sensitive: false }
end
