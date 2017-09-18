class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @conversations = Conversation.all
  end

  def create
    if Conversation.between(current_user, params[:recipient_id]).present?
      @conversation = Conversation.between(current_user, params[:recipient_id]).first
    else
      @conversation = Conversation.create!(sender_id: current_user.id, recipient_id: params[:recipient_id])
    end

    respond_to do |format|
      format.json { render json: @conversation }
    end
  end
end
