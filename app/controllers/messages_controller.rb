class MessagesController < ApplicationController
    protect_from_forgery with: :null_session
    def index 
        puts " hello from messages"
    end 


    # Column    |              Type              | Collation | Nullable |               Default                
    # -------------+--------------------------------+-----------+----------+--------------------------------------
    #  id          | bigint                         |           | not null | nextval('messages_id_seq'::regclass)
    #  msg_number  | integer                        |           |          | 
    #  content     | character varying              |           |          | 
    #  sender      | character varying              |           |          | 
    #  created_at  | timestamp(6) without time zone |           | not null | 
    #  updated_at  | timestamp(6) without time zone |           | not null | 
    #  chat_number | integer                        |           |          | 
    #  chat_id     | bigint                         |           |          | 
    # Indexes:
    
    def create 
        puts "Inside message create"
        
        begin
            puts "inside the begin"
            @message = Message.create(:content=> request[:content], :sender=> request[:sender], :chat_id=> params[:id])
            puts "finished creating the message"
            @chat = Chat.find_by(id: params[:id]).
            puts "finished fetching the chat"
            @chat.messages_count+=1
            puts "finished updating the chat"
            @chat.save!
            puts "saved the chat"
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
            @message = Message.lock(true).find_by( id:params[:msgID])
            @message.content= request["content"]
            @message.save!
            render json:{message:"Message Updated SUccessfully" , content: @message}, status:200
        rescue => exception
            render json:{message:"Error while updating the targeted message"}, status:400
        end
    end

    def search 
        puts "Inside the search"
        puts "-----------------------"
        puts "-----------------"
        puts params[:content]
        puts"YARAB NTA L KAREEM"
        response = Message.__elasticsearch__.search("girlz").results
        puts "------------------------"
        puts response
        puts "------------------------"
          render json: {
            results: response.results,
            total: response.total
          }
    end
          
    

    def search_params
        params.permit(:content, :sender)
      end

end
