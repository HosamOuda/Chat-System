require 'elasticsearch/model'
class Message < ApplicationRecord
    belongs_to :Chat, foreign_key: :chat_id
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    def as_indexed_json(options = {})
        self.as_json(
          only: [:id, :content, :sender, :chat_id],
          include: {
          }
        )
    end  
end
