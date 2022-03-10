class MessageIndex
    include SearchFlip::Index
  
    def self.index_name
      "messages"
    end
  
    def self.model
      Message
    end
  
    def self.serialize(message)
      {
        id: message.id,
        content: message.content,
        sender: message.sender,
        created_at: message.created_at,
        updated_at: message.updated_at,
        chat_id: message.chat_id
      }
    end
  end