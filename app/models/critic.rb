class Critic < ApplicationRecord
    #  Validations
    validates :title, presence: true
    validates :body, presence: true
  
    # Associations
    belongs_to :user, counter_cache: true
    belongs_to :criticable, polymorphic: true
end
