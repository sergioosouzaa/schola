# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :set_student, only: %i[show edit update destroy]
  before_action :set_year, only: %i[index show]

  def index
    @students = Student.includes(enrollments: :course)
  end

  def show
    @student_params = Student.get_from_year(@year).find_by(id: params[:id])
    if @student_params
      @grades = @student.grades.includes(enrollment: :student, exam: [:subject, :course]).where(courses: { year: @year })
    else
      flash.now[:alert] = I18n.t('flash.student.error.not_enrolled')
    end
  end

  def new
    @student = Student.new
  end

  def edit; end

  def create
    @student = Student.new(student_params)

    if @student.save
      redirect_to @student, notice: I18n.t('flash.student.success.create')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @student.update(student_params)
      redirect_to @student, notice: I18n.t('flash.student.success.update'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @student.destroy
    redirect_to students_url, notice: I18n.t('flash.student.success.destroy'), status: :see_other
  end

  private

  def set_year
    @year = params[:year].to_i
    @year = 2023 unless (2012..2022).cover?(@year)
  end

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :born_on)
  end
end
