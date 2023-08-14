# frozen_string_literal: true

class TeacherAssignmentsController < ApplicationController
  before_action :set_teacher_assignment, only: %i[show edit update destroy]

  def index
    @teacher_assignments = TeacherAssignment.all
  end

  def show; end

  def new
    @teacher_assignment = TeacherAssignment.new
  end

  def edit; end

  def create
    @teacher_assignment = TeacherAssignment.new(teacher_assignment_params)

    if @teacher_assignment.save
      redirect_to @teacher_assignment, notice: I18n.t('flash.teacher_assignment.success.create')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @teacher_assignment.update(teacher_assignment_params)
      redirect_to @teacher_assignment, notice: I18n.t('flash.teacher_assignment.success.update'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @teacher_assignment.destroy
    redirect_to teacher_assignments_url, notice: I18n.t('flash.teacher_assignment.success.destroy'), status: :see_other
  end

  private

  def set_teacher_assignment
    @teacher_assignment = TeacherAssignment.find(params[:id])
  end

  def teacher_assignment_params
    params.require(:teacher_assignment).permit(:teacher_id, :subject_id, :course_id)
  end
end
