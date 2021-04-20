class JobsController < ApplicationController
  before_action :set_company
  before_action :set_job, only: %i[show edit update destroy]

  after_action :verify_authorized, except: %i[index show]

  def index
    redirect_to controller: :companies, action: :show, id: @company.id, company_id: nil
  end

  def show; end

  def new
    @job = @company.jobs.new
    authorize @job
  end

  def edit
    authorize @job
  end

  def create
    @job = @company.jobs.new(job_params)
    authorize @job
    if @job.save
      redirect_to companies_path(@company), notice: 'Job was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @job
    if @job.update(job_params)
      redirect_to company_path(@company), notice: 'Job was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @job
    if @job.destroy
      redirect_to companies_path(@company), notice: 'Job was successfully destroyed.'
    else
      redirect_to companies_path(@company), notice: 'Job could not be destroyed. Try again!'
    end
  end

  private

  def set_job
    @job = @company.jobs.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :company_id, :job_type)
  end

  def set_company
    @company = Company.find(params[:company_id])
  end
end
