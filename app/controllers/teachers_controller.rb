# frozen_string_literal: true

class TeachersController < ApplicationController
  before_action :set_teacher, only: %i[show edit update destroy]

  def index
    @teachers = Teacher.all
  end

  def show; end

  def new
    @teacher = Teacher.new
  end

  def edit; end

  def create
    @teacher = Teacher.new(teacher_params)

    if @teacher.save
      redirect_to @teacher, notice: I18n.t('flash.teacher.success.create')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @teacher.update(teacher_params)
      redirect_to @teacher, notice: I18n.t('flash.teacher.success.update'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @teacher.destroy
    redirect_to teachers_url, notice: I18n.t('flash.teacher.success.destroy'), status: :see_other
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def teacher_params
    params.require(:teacher).permit(:name)
  end
end
