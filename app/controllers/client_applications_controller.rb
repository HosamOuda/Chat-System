class ClientApplicationsController < ApplicationController
    protect_from_forgery with: :null_session
    def index 
        @applications =Application.lock(true).all
        render json:{applications: @applications }, status:200
    end 
 
    def create 
        @token = generate_token(request["name"]) 
        @application_name = request["name"]
        @application = Application.lock(true).create(:token => @token, :chat_count=>0 ,  :name => @application_name)
        render json: {message: "Application created successfully " , content: @application} , status: 201
    end

    def show 
        @is_exist = Application.exists?(token: params[:token])
        if @is_exist
            @application = Application.lock(true).find_by!(token: params[:token])
            render json: @application, status: 200
        else
            render json: { message: "Application Not found "}, status: 404
        end   
    end

    def update 
        puts "Inside application update"
        @is_exist = Application.exists?(token: params[:token])
        if @is_exist
            @application = Application.lock(true).find_by!(token: params[:token])
            @application.lock!
            @application.name = request["name"]
            @application.token = generate_token(request["name"])
            @application.save!
            render json: @application, status: 200
        else
            render json: { message: "Application Not found "}, status: 404
        end  
    end

    private 

    def generate_token(key)
        require 'digest'
        return Digest::SHA1.hexdigest(key)[8..16]
        
    end

    def pattern_matcher_params
        params.permit(
          :name
        )
    end
end
