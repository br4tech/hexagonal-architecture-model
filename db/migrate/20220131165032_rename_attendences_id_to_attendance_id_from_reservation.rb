class RenameAttendencesIdToAttendanceIdFromReservation < ActiveRecord::Migration[6.0]
  def change
    rename_column :reservations, :attendances_id, :attendance_id
  end
end
