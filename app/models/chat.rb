class Chat < ApplicationRecord
    belongs_to :Application, foreign_key: :application_id
    has_many :messages, :dependent => :destroy
end
