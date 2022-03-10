Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   #-----------------------------------------------------------------
  #chats routes 
  post "/applications/:token/chats", to:"chats#create"
  get  "/applications/:token/chats", to:"chats#show_all_chats_in_application"
  get  "/applications/:token/chats/:id", to:"chats#show"
  #-----------------------------------------------------------------
  #application routes 
  get "/applications", to: "client_applications#index" 
  post "/applications", to:"client_applications#create"
  get "/applications/:token", to:"client_applications#show"
  put "/applications/:token", to:"client_applications#update"

  
  
   #-----------------------------------------------------------------
  #messages routes 
  post "/applications/chats/:id/message", to:"messages#create"
  get  "/applications/:token/messages", to:"messages#show" #get all messages
  get  "/applications/chats/:id/message", to:"messages#show_all_messages_in_chat" #get all message in chat
  put "/applications/chats/:id/message/:msgID", to:"messages#update" #update message


  get "/message", to:"messages#search" #search message
end
