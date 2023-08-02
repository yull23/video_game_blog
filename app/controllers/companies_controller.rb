class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
      redirect_to company_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :description, :start_date, :country)
  end
end
