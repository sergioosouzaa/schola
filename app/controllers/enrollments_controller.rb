# frozen_string_literal: true

class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: %i[show edit update destroy]

  def index
    @enrollments = Enrollment.includes(:student, :course).all
  end

  def show; end

  def new
    @enrollment = Enrollment.new
  end

  def edit; end

  def create
    @enrollment = Enrollment.new(enrollment_params)

    if @enrollment.save
      redirect_to @enrollment, notice: I18n.t('flash.enrollment.success.create')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @enrollment.update(enrollment_params)
      redirect_to @enrollment, notice: I18n.t('flash.enrollment.success.update'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @enrollment.destroy
    redirect_to enrollments_url, notice: I18n.t('flash.enrollment.success.destroy'), status: :see_other
  end

  private

  def set_enrollment
    @enrollment = Enrollment.find(params[:code])
  end

  def enrollment_params
    params.require(:enrollment).permit(:code, :student_id, :course_id)
  end
end
