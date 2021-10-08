class Api::UsersController < ApplicationController
      
      def index
        users = User.all
        render json: users
      end
  
      def show
        if current_user
          render json: current_user, status: :ok
        else
          render json: { user: 'not logged in' }, status: :unauthorized
        end
      end
    
      def create
        user = User.create(user_params)
        if user.valid?
          session[:user_id] = user.id
          render json: user, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end


    
      private
    
      def user_params
        params.permit(:username, :email, :password, :password_confirmation, :wallet_address)
      end

end