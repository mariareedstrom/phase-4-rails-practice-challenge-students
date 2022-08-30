class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  def index
    instructors = Instructor.all
    render json: instructors, status: :ok
  end

  def create
    instructor = Instructor.create!(instructor_params)
    render json: instructor, status: :created
  end

  def update
    instructor = Instructor.find(params[:id])
    instructor.update!(instructor_params)
    render json: instructor, status: :ok
  end

  def destroy
    instructor = Instructor.find(params[:id])
    instructor.destroy
    head :no_content
  end


  private

  def instructor_params
    params.permit(:name)
  end

  def record_invalid(invalid)
    render json: {errors: invalid.record.errors.messages }, status: :unprocessable_entity
  end
end
