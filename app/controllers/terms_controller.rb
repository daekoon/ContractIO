class TermsController < ApplicationController
  def show
    @term = Term.find(params[:id])
  end
end
