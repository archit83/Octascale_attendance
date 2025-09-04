class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  def index
    @employees = Employee.all
  end

  def show
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to @employee, notice: "✅ Employee added successfully!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      redirect_to @employee, notice: "✅ Employee updated!"
    else
      render :edit
    end
  end

def destroy
  @employee = Employee.find(params[:id])
  @employee.destroy
  redirect_to employees_path, notice: "Employee deleted successfully."
end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:name, :designation)
  end
end
