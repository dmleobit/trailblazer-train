module UserHelper
  def friend(record)
    record.initiator == current_user ? record.receiver : record.initiator
  end
end
