class Company < ApplicationRecord
    # Attached
    has_one_attached :cover
    validates :name, presence: true, uniqueness: true

    # Associations
    has_many :involved_companies, dependent: :destroy
    has_many :games, through: :involved_companies, counter_cache: true
    has_many :received_critics, class_name: "Critic", 
    as: :criticable, 
    dependent: :destroy
end
