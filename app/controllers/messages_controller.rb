class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_conversation

  def index
    @messages = @conversation.messages

    respond_to do |format|
      format.json { render json: {messages: @messages, total: @conversation.messages.count} }
    end
  end


  def create
    @messages = @conversation.messages[0..10]
    @message = @conversation.messages.new(message_params)

    if @message.save
      ActionCable.server.broadcast "conversation_channel_#{@conversation.id}", @message

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
