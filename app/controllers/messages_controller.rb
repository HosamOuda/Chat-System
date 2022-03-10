class MessagesController < ApplicationController
    protect_from_forgery with: :null_session
    def index 
    end 

    def create 
        puts "Inside message create"
        
        begin
            @message = Message.lock(true).create(:content=> request[:content], :sender=> request[:sender], :chat_id=> params[:id])
            @chat = Chat.lock(true).find_by(id: params[:id])
            @chat.messages_count+=1
            @chat.save!
            render json:{message: "Message created successfully" , content: @message} , status: 201
        rescue => exception 
            render json:{message: "Message creation failed #{exception}"} , status: 400
        end
        
    end

    def show
        puts "Entered message show function "
       begin
        @messages = Message.lock(true).all
        render json:{messages: @messages}, status:200
       rescue => exception
        render json:{message: "Message Fetch failed"} , status: 400
       end
    end

    def show_all_messages_in_chat
        puts "Inside show all messages get"
        begin
            @messages = Message.lock(true).where(chat_id: params[:id]) 
            render json:{messages: @messages}, status:200
        rescue => exception
            render json:{message: "Message Fetch failed"} , status: 400
        end
    end

    def update
        puts "inside message update "
        begin
            @message = Message.lock(true).find_by( id: params[:msgID])
            @message.content= request["content"]
            @message.save!
            render json:{message:"Message Updated Successfully" , content: @message}, status:200
        rescue => exception
            render json:{message:"Error while updating the targeted message"}, status:400
        end
    end

    def search 
        puts "Inside the search"
        query = MessageIndex.search(params[:query].to_s)
        @results = query.records
        render json: @results , status:200
    end
          
    

    def search_params
        params.permit(:content, :sender)
      end

end
