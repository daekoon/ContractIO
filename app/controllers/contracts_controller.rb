class ContractsController < ApplicationController

  def new

  end

  def create

  end

  def show
    @contract = Contract.find(params[:id])

    @clauses = []
    @contract.clauses.each do |id|
        @clauses << Clause.find(id);
    end
  end

  def select
  end

  def edit
    @contract = Contract.find(params[:id])
  end

  def editpost
    contract = Contract.find(params[:id])

    contract.name = params[:name]
    contract.lender_address = params[:lender_address]
    contract.borrower_address = params[:borrower_address]
    contract.borrower_name = params[:borrower_name]
    contract.lender_name = params[:lender_name]
    contract.loan_amount = params[:loan_amount]
    contract.user = current_user

    contract.save!
    redirect_to contract_path(contract.id)
  end

  def generate
    # For now this is hard coded to create loan contract only
    # Refactor in the future if we decide to work further on this
    contract = Contract.new

    contract.name = params[:name]
    contract.lender_address = params[:lender_address]
    contract.borrower_address = params[:borrower_address]
    contract.borrower_name = params[:borrower_name]
    contract.lender_name = params[:lender_name]
    contract.loan_amount = params[:loan_amount]
    contract.user = current_user
    contract.clauses = [1]

    contract.save!
    redirect_to contract_path(contract.id)
  end
end
