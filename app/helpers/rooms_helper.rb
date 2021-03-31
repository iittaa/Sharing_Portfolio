module RoomsHelper
  def opened_user(room)
    entry = room.entries.where.not(user_id: current_user)
    entry[0].user
  end

  # 最新メッセージの内容を取得する
  def get_new_msg(room)
    @message = room.messages.order(updated_at: :desc).limit(1)
    @message = @message[0]
    if @message.present?
      tag.div @message.message.truncate(30).to_s
    else
      tag.div 'まだメッセージはありません'
    end
  end

  # 最新メッセージの時間を取得する
  def get_new_msg_time(room)
    @message = room.messages.order(updated_at: :desc).limit(1)
    @message = @message[0]
    if @message.present?
      tag.div @message.created_at.strftime('%Y/%m/%d %H:%M').to_s
    else
      tag.div ''
    end
  end
end
