# frozen_string_literal: true

Rails.application.routes.draw do
  resources :students
  resources :enrollments, param: :code
  resources :teachers
  resources :courses
  resources :exams
  resources :subjects

  root 'students#index'
end
