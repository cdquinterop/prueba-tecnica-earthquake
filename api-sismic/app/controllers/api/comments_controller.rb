class Api::CommentsController < ApplicationController
    skip_before_action :verify_authenticity_token  # Desactivar
    
  
     def create
        @record = Record.find_by(id: params[:feature_id])
        if @record
          @comment = @record.comments.new(body: params[:body])
          if @comment.save
            render json: @comment, status: :created
          else
            render json: { error: @comment.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: 'Feature not found' }, status: :not_found
        end
      end
end
