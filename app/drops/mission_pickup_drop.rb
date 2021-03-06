class MissionPickupDrop < DynamicBaseDrop
  
  accessible! :pickup, :comment?
  
  def address
    pickup.address.to_s
  end

  def comment
    mission_pickup.comment.to_s
  end
  
  def name
    pickup.name
  end
  
  def time
    mission_pickup.pickup_at && ::I18n.l(mission_pickup.pickup_at, :format => :pickup_time).gsub(/0(\d:\d{2})/, '\1')
  end
  
end