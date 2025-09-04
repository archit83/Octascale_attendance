Rails.application.routes.draw do
  root "pages#welcome"

  # Employee routes
  resources :employees

  # Attendance routes
  resources :attendances, only: [:index, :create, :update] do
    collection do
      post :add_employee          # to support inline employee creation (optional)
      get :edit_existing          # for editing existing/past attendance
    end
  end
end
