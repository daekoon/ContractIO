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
    contract.interest_rate = params[:interest_rate]
    contract.loan_duration = params[:loan_duration]
    contract.user = current_user

    generate_clauses(contract)

    contract.save!
    redirect_to contract_path(contract.id)
  end

  def generate
    # For now this is hard coded to create loan contract only
    # Refactor in the future if we decide to work further on this
    contract = Contract.new
    contract.contract_type = 'Loan'

    contract.name = params[:name]
    contract.lender_address = params[:lender_address]
    contract.borrower_address = params[:borrower_address]
    contract.borrower_name = params[:borrower_name]
    contract.lender_name = params[:lender_name]
    contract.loan_amount = params[:loan_amount]
    contract.interest_rate = params[:interest_rate]
    contract.loan_duration = params[:loan_duration]
    contract.user = current_user

    generate_clauses(contract)

    contract.save!
    redirect_to contract_path(contract.id)
  end

  private

  def generate_clauses(contract)
    contract.clauses.each do |clause|
      Clause.find(clause).destroy
    end

    all_clauses = []
    base_template = ClauseTemplate.find_by(name: 'loan_base')
    parameters = [contract.lender_name, contract.borrower_name, contract.lender_address,
                  contract.borrower_address]
    text = base_template.replace_merge_tags(parameters)
    clause = Clause.create(text: text, name: contract.name + 'loan_base',
                           explanation_text: base_template.explanation_text)
    all_clauses << clause.id

    template = ClauseTemplate.find_by(name: 'loan_amount')
    parameters = ['%d' % [contract.loan_amount]]
    text = template.replace_merge_tags(parameters)
    clause = Clause.create(text: text, name: contract.name + 'loan_amount',
                           explanation_text: template.explanation_text)
    all_clauses << clause.id

    template = ClauseTemplate.find_by(name: 'loan_term')
    parameters = ['%d' % [contract.loan_duration]]
    text = template.replace_merge_tags(parameters)
    clause = Clause.create(text: text, name: contract.name + 'loan_duration',
                           explanation_text: template.explanation_text)
    all_clauses << clause.id

    template = ClauseTemplate.find_by(name: 'interest_rate')
    parameters = ['%0.2f' % [contract.interest_rate]]
    text = template.replace_merge_tags(parameters)
    clause = Clause.create(text: text, name: contract.name + 'interest_rate',
                           explanation_text: template.explanation_text)
    all_clauses << clause.id

    contract.update_attribute(:clauses, all_clauses)
  end
end
