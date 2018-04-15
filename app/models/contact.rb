class Contact < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  validates :lastname, presence: true
  before_validation :downcase_email

  accepts_nested_attributes_for :tags, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :taggings

  def name
    "#{lastname.upcase} #{firstname.capitalize} "
  end

  def downcase_email
    self.email.try(:downcase!)
  end

end
