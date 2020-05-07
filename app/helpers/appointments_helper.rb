module AppointmentsHelper
  def time_from_ago
    time_from_ago = 20.minutes.ago.change(sec: 0)
  end

  def time_now
    time_now = Time.zone.now.change(sec: 59)
  end

  def get_appointments(user, from, now)
    appointments = user.appointments.where(created_at: from..now)
  end
end
