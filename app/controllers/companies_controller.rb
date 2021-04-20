class CompaniesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_company, only: %i[show edit update destroy]

  after_action :verify_authorized, except: %i[index show]

  def index
    @companies = Company.all
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
    if @company.destroy
      redirect_to companies_url, notice: 'Company was successfully destroyed.'
    else
      redirect_to companies_url, notice: 'Company could not be destroyed. Try again!'
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :description)
  end
end
