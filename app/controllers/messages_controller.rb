class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_conversation

  def index
    @messages = @conversation.messages

    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true;
      end
    end

    respond_to do |format|
      format.json { render json: @messages }
    end
  end


  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.json { render json: @message }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end

  def get_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end
