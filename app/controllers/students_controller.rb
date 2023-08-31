# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :set_student, only: %i[show edit update destroy]
  before_action :set_year, only: %i[index show]

  def index
    @students = Enrollment.joins(:course)
    .where("courses.year = ?", @year)
    .joins("RIGHT JOIN students ON students.id = enrollments.student_id")
    .order("students.name")
    .select("enrollments.code, students.name AS student_name, courses.name AS course_name, courses.year")
  end

  def show
    @student_params = Student.get_from_year(@year).find_by(id: params[:id])
    if @student_params
      calculate_grades
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

  def calculate_grades
    @grades = @student.grades.includes(exam: %i[subject course]).where(courses: { year: @year })

    @subject_averages = {}
    @grades.group_by { |grade| grade.exam.subject }.each do |subject, grades|
      total_grades = grades.sum(&:value)
      number_of_grades = grades.size
      average = number_of_grades.zero? ? 0 : total_grades / number_of_grades
      @subject_averages[subject] = average
    end
  end

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
