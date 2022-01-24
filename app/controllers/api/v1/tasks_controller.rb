class Api::V1::TasksController < ApplicationController

  before_action :set_task, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize, except: [:index, :create]
  # GET /tasks
  def index
    @tasks = Task.all.where(user_id: current_user.id)
    render json: @tasks 
  end

  # GET /tasks/1
  def show
    render json: @task
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id

    if @task.save
      render json: @task, status: :created, location: api_v1_tasks_path(@task)
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
  end

  def correct_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def authorize
      unless current_user.id == @task.user_id
        render status: :unauthorized, json: { error: "You are not authorized to access this resource. Verify that you are passing passing your token." }
      end
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :start_time, :end_time)
    end
end