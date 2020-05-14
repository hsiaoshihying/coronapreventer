module AppointmentsHelper
  def time_from_ago
    time_from_ago = Time.current.beginning_of_month
  end

  def time_now
    time_now = Time.current.end_of_month
  end

  def get_appointments(user, from, now)
    appointments = user.appointments.where(created_at: from..now)
  end
end
