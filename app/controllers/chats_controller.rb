class ChatsController < ApplicationController
    protect_from_forgery with: :null_session

    def index 
        puts "Inside get message get all chats"
        begin
            @chats =Chat.lock(true).all
            render json:{chats: @chats }, status:200
        rescue => exception
            render json: {message: "Fetching Chats failed"}, status: 400
        end
    end 

    def create 
        puts "Inside chat create"
        begin
            @application = Application.lock(true).find_by(token: params[:token])
            @chat = Chat.lock(true).create( :messages_count=>0 , :application_id => @application.id , :application_token=> params[:token])
            @application.chat_count+=1
            @application.save!
            render json: {message: "Chat created successfully " , chat: @chat} , status: 201
        rescue => exception 
            render json: {message: "Failed to create chat"} , status: 400
        end
        
    end

    def show
        puts "search for a certain chat inside a certain application"
        begin
            @chats =Chat.lock(true).find_by(application_token: params[:token] , id: params[:id])
            render json:{chats: @chats }, status:200
        rescue => exception
            render json{"couldn't get chat"}, status:400
        end
        
    end

    def show_all_chats_in_application
        puts "Inside chat get"
        application_token = params[:token]
        @res = Chat.lock(true).where(application_token: application_token)
        render json:{chats: @res} , status: 200
    end


    # def search 
    #     @target = request[:name]
    #     @application = Application.lock(true).find_by(name: @target)
    # end
end
