class Application < ApplicationRecord
    # primary_key: :token
    has_many :chats, :dependent => :destroy
end
