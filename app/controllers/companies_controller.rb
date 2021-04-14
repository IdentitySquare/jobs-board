class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  # before_action :authorized_user, only: [:edit, :update, :destroy]
  after_action :verify_authorized, except: %i[index]
  after_action :verify_policy_scoped, only: %i[index]
  # GET /companies or /companies.json
  def index
    @companies = policy_scope(Company)
  end

  # GET /companies/1 or /companies/1.json
  def show
    @companies = policy_scope(Company)
  end

  # GET /companies/new
  def new
    @company = current_user.companies.new
    authorize @company
  end

  # GET /companies/1/edit
  def edit; end

  # POST /companies or /companies.json
  def create
    @company = current_user.companies.create(company_params)
    authorize @company
    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1 or /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1 or /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.find(params[:id])
    authorize @company
  end

  # Only allow a list of trusted parameters through.
  def company_params
    params.require(:company).permit(:name, :description, :user_id)
  end
end
