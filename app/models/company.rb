class Company < ApplicationRecord
    # Attached
    has_one_attached :cover
    validates :name, presence: true, uniqueness: true

    # Associations
    has_many :involved_companies, dependent: :destroy
    has_many :games, through: :involved_companies, counter_cache: true
    has_many :critics, as: :criticable, dependent: :destroy
    has_one_attached :cover
end
