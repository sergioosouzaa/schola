# frozen_string_literal: true

class ExamsController < ApplicationController
  before_action :set_exam, only: %i[show edit update destroy]

  def index
    @exams = Exam.all
  end

  def show; end

  def new
    @exam = Exam.new
  end

  def edit; end

  def create
    @exam = Exam.new(exam_params)

    if @exam.save
      redirect_to @exam, notice: I18n.t('flash.exam.success.create')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @exam.update(exam_params)
      redirect_to @exam, notice: I18n.t('flash.exam.success.update'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @exam.destroy
    redirect_to exams_url, notice: I18n.t('flash.exam.success.destroy'), status: :see_other
  end

  private

  def set_exam
    @exam = Exam.find(params[:id])
  end

  def exam_params
    params.require(:exam).permit(:course_id, :subject_id, :realized_on)
  end
end
