class CompaniesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_company, only: %i[show edit update destroy]

  after_action :verify_authorized, except: %i[index show]
  after_action :verify_policy_scoped, only: %i[index]

  def index
    @companies = policy_scope(Company)
  end

  def show; end

  def new
    @company = current_user.companies.new
    authorize @company
  end

  def edit
    authorize @company
  end

  def create
    @company = current_user.companies.new(company_params)
    authorize @company
    if @company.save
      redirect_to @company, notice: 'Company was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @company
    if @company.update(company_params)
      redirect_to @company, notice: 'Company was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @company
    @company.destroy
    redirect_to companies_url, notice: 'Company was successfully destroyed.'
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :description, :user_id)
  end
end
