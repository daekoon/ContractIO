require "prawn"

# Class containing the logic for generating pdf from the contract

class PdfGenerator
    def self.generate(contract)
        pdf = Prawn::Document.new
        pdf.text contract.contract_type + " Agreement"
        clause_counter = 1
        contract.clauses.each do |clause|
            current_clause = Clause.find(clause)
            current_text = clause_counter.to_s + "."
            current_text += " ";
            current_text += current_clause.text
            pdf.text current_text
            clause_counter += 1
        end
        pdf
    end
  end
  