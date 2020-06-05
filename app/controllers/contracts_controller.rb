include ActionView::Helpers::TextHelper
include ERB::Util

require 'digest/md5'
require 'pdf-reader'

class ContractsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def new

  end

  def create

  end

  def explain

  end

  def explained
    @explained = simple_format html_escape params[:text]
    Term.find_each do |term|
      @explained.gsub! /#{term.text}/i, '<a href="/terms/' + term.id.to_s + '">' + term.text + "</a>"
    end
  end

  def show
    @contract = Contract.find(params[:id])

    @clauses = []
    @contract.clauses.each do |id|
        @clauses << Clause.find(id);
    end
  end

  def generatepdf
    pdf = PdfGenerator.new(Contract.find(params[:id]))
    pdf.generate()
    send_data pdf.render,
      filename: "contract.pdf",
      type: "application/pdf",
      disposition: "inline"
  end

  def printable
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
    data = contract.data
    contract.name = params[:name]
    data[:name] = params[:name]
    contract.lender_address = params[:lender_address]
    data[:lender_address] = params[:lender_address]
    contract.borrower_address = params[:borrower_address]
    data[:borrower_address] = params[:borrower_address]
    contract.borrower_name = params[:borrower_name]
    data[:borrower_name] = params[:borrower_name]
    contract.lender_name = params[:lender_name]
    data[:lender_name] = params[:lender_name]
    contract.loan_amount = params[:loan_amount]
    data[:loan_amount] = params[:loan_amount]
    contract.interest_rate = params[:interest_rate]
    data[:interest_rate] = params[:interest_rate]
    contract.loan_duration = params[:loan_duration]
    data[:loan_duration] = params[:loan_duration]
    contract.user = current_user

    all_parameters = generate_clauses(contract)
    contract.data = data
    store_clauses_as_data(contract, all_parameters)



    contract.save!
    redirect_to contract_path(contract.id)
  end

  def generate
    # For now this is hard coded to create loan contract only
    # Refactor in the future if we decide to work further on this
    contract = Contract.new
    data = {}
    contract.contract_type = 'Loan'
    data[:contract_type] = 'Loan'

    # Common data
    contract.name = params[:name]
    data[:name] = params[:name]

    # Non common data
    contract.lender_address = params[:lender_address]
    data[:lender_address] = params[:lender_address]
    contract.borrower_address = params[:borrower_address]
    data[:borrower_address] = params[:borrower_address]
    contract.borrower_name = params[:borrower_name]
    data[:borrower_name] = params[:borrower_name]
    contract.lender_name = params[:lender_name]
    data[:lender_name] = params[:lender_name]
    contract.loan_amount = params[:loan_amount]
    data[:loan_amount] = params[:loan_amount]
    contract.interest_rate = params[:interest_rate]
    data[:interest_rate] = params[:interest_rate]
    contract.loan_duration = params[:loan_duration]
    data[:loan_duration] = params[:loan_duration]
    contract.user = current_user

    contract.data = data

    all_parameters = generate_clauses(contract)
    store_clauses_as_data(contract, all_parameters)

    contract.save!
    redirect_to contract_path(contract.id)
  end

  def upload

  end

  def upload_file
    if File.extname(params[:file].tempfile) != ".pdf"
      raise "Unsupported file type"
    end
    reader = PDF::Reader.new(params[:file].tempfile)
    data = reader.info
    if data[:contract_type] == "Loan"
      id = upload_loan_contract(data)
    end
    redirect_to contract_path(id)
  end

  def newclause
    contract = Contract.find(params[:id])
    newclause = Clause.create(text: params[:newtext], name: contract.name + '_custom_' + params[:newclauseid], explanation_text: params[:newexplanation], custom: true)
    newclause.save!
    contract.clauses << newclause.id
    contract.save!
    redirect_to contract_path(contract.id)
  end

  def deleteclause
    contract = Contract.find(params[:id])
    clause = Clause.delete(params[:clauseid])
    contract.clauses.delete_at(params[:contractclauseid].to_i - 1)

    contract.save!
    redirect_to contract_path(contract.id)
  end

  private

  def generate_clauses(contract)
    all_parameters = {}
    custom_clauses = []
    contract.clauses.each do |clause|
      current_clause = Clause.find(clause)
      # Only destroy template clauses when you edit
      unless current_clause.custom
        current_clause.destroy
      else
        custom_clauses << current_clause.id
      end
    end
    all_clauses = []
    base_template = ClauseTemplate.find_by(name: 'loan_base')
    parameters = [contract.lender_name, contract.borrower_name, contract.lender_address,
                  contract.borrower_address]
    text = base_template.replace_merge_tags(parameters)
    clause = Clause.create(text: text, name: contract.name + 'loan_base',
                           explanation_text: base_template.explanation_text,
                           template_name: base_template.name, custom: false)
    all_parameters[clause.id] = parameters
    all_clauses << clause.id

    template = ClauseTemplate.find_by(name: 'loan_amount')
    parameters = ['%d' % [contract.loan_amount]]
    text = template.replace_merge_tags(parameters)
    clause = Clause.create(text: text, name: contract.name + 'loan_amount',
                           explanation_text: template.explanation_text,
                           template_name: template.name, custom: false)
    all_parameters[clause.id] = parameters
    all_clauses << clause.id

    template = ClauseTemplate.find_by(name: 'loan_term')
    parameters = ['%d' % [contract.loan_duration]]
    text = template.replace_merge_tags(parameters)
    clause = Clause.create(text: text, name: contract.name + 'loan_duration',
                           explanation_text: template.explanation_text,
                           template_name: template.name, custom: false)
    all_clauses << clause.id
    all_parameters[clause.id] = parameters

    template = ClauseTemplate.find_by(name: 'interest_rate')
    parameters = ['%0.2f' % [contract.interest_rate]]
    text = template.replace_merge_tags(parameters)
    clause = Clause.create(text: text, name: contract.name + 'interest_rate',
                           explanation_text: template.explanation_text,
                           template_name: template.name, custom: false)
    all_clauses << clause.id
    all_parameters[clause.id] = parameters

    template = ClauseTemplate.find_by(name: 'legally_binding')
    text = template.replace_merge_tags([])
    clause = Clause.create(text: text, name: contract.name + 'legally_binding',
                           explanation_text: template.explanation_text,
                           template_name: template.name, custom: false)
    all_clauses << clause.id
    all_parameters[clause.id] = parameters

    custom_clauses.each do |clause|
      all_clauses << clause
    end

    contract.update_attribute(:clauses, all_clauses)
    all_parameters
  end

  def store_clauses_as_data(contract, all_parameters)
    clauses = {}
    count = 1
    contract.clauses.each do |c|
      current_clause = Clause.find(c)
      clauses[count.to_s] = {
        "custom" => current_clause.custom,
        "template_name" => current_clause.template_name,
        "text" => current_clause.text,
        "explanation_text" => current_clause.explanation_text,
        "name" => current_clause.name,
        "parameters" => all_parameters[current_clause.id]
      }
      count += 1
    end
    new_data = contract.data
    new_data["clauses"] = clauses.to_json
    contract.update_attribute(:data, new_data)
    contract.save

  end

  def upload_loan_contract(data)
    contract = Contract.new
    contract.name = data[:name]
    contract.contract_type = 'Loan'
    contract.data = data

    all_clauses = []

    contract.lender_address = data[:lender_address]
    contract.borrower_address = data[:borrower_address]
    contract.borrower_name = data[:borrower_name]
    contract.lender_name = data[:lender_name]
    contract.loan_amount = data[:loan_amount]
    contract.interest_rate = data[:interest_rate]
    contract.loan_duration = data[:loan_duration]
    contract.user = current_user

    json_hash = JSON.parse(data[:clauses])

    json_hash.each do |data|
      clause_data = data[1]
      if clause_data["custom"]
        newclause = Clause.create(text: clause_data["text"], name: clause_data["name"], explanation_text: clause_data["explanation_text"], custom: true)
        newclause.save!
        all_clauses << newclause.id
      else
        template = ClauseTemplate.find_by(name: clause_data["template_name"])
        if template.nil?
          newclause = Clause.create(text: clause_data["text"], name: clause_data["name"], explanation_text: clause_data["explanation_text"], custom: true)
          newclause.save!
          all_clauses << newclause.id
        else
          text = template.replace_merge_tags(clause_data["parameters"])
          newclause = Clause.create(text: text, name: clause_data["name"], explanation_text: clause_data["explanation_text"], custom: false)
          newclause.save!
          all_clauses << newclause.id
        end
      end
    end

    contract.clauses = all_clauses
    contract.save!
    contract.id
  end
end
