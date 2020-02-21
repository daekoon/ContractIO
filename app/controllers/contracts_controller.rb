class ContractsController < ApplicationController

  def new

  end

  def create

  end

  def show
    @contract = Contract.find(params[:id])
  end

  def select
  end

  def generate
  end
end
