class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from stream_name
  end

  private

  def stream_name
    "conversation_channel_#{conversation_id}"
  end

  def conversation_id
    params.fetch('data').fetch('conversation')
  end
end
