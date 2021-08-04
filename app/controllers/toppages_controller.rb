class ToppagesController < ApplicationController
  def index
    if logged_in?
      @task = current_user.tasks.build  
      @pagy, @tasks = pagy(current_user.tasks.order(id: :desc))
    end
  end
end
