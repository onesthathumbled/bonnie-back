class Category < ApplicationRecord
    acts_as_paranoid

    belongs_to :user
    has_many :tasks

    validates :category_name, presence: true
    validates :category_details, presence: true
end
