class AttendancesController < ApplicationController
  def index
    @date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    @employees = Employee.all
    @existing_attendance = Attendance.where(date: @date).pluck(:employee_id, :status).to_h
  end

  def create
    date = params[:attendance_date].present? ? Date.parse(params[:attendance_date]) : Date.today

    params[:attendance]&.each do |employee_id, status|
      Attendance.create(employee_id: employee_id, date: date, status: status)
    end

    redirect_to attendances_path(date: date), notice: "Attendance recorded!"
  end

  def edit_existing
    @date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    @employees = Employee.all
    @existing_attendance = Attendance.where(date: @date).pluck(:employee_id, :status).to_h
  end

  def update
    date = params[:attendance_date].present? ? Date.parse(params[:attendance_date]) : Date.today

    params[:attendance]&.each do |employee_id, status|
      record = Attendance.find_or_initialize_by(employee_id: employee_id, date: date)
      record.status = status
      record.save
    end

    redirect_to attendances_path(date: date), notice: "Attendance updated!"
  end

  def add_employee
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to attendances_path, notice: "Employee added."
    else
      redirect_to attendances_path, alert: "Failed to add employee."
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :designation)
  end
end
