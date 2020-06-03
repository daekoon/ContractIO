# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([{name: 'test', email: 'test@test.com', password: 'test', password_confirmation: 'test'}])

ClauseTemplate.create(name: 'loan_amount', text: 'Loan Amount. The Parties agree the Lender will loan the Borrower ${loan_amount} (the “Loan”).', merge_tags: ['{loan_amount}'], explanation_text: 'This clause simply states the amount of money loaned.', tag: 'loan_default')

ClauseTemplate.create(name: 'collateral', text: 'Collateral. The Parties agree that the Borrower will hand over to the Lender {collateral} as security for the Loan (the “Collateral”).', merge_tags: ['{collateral}'], explanation_text: 'Collateral is an asset of a borrower that is given to the lender as a security.', tag: 'loan')

ClauseTemplate.create(name: 'interest_rate', text: 'Interest Rate. The Parties agree the Interest Rate for this loan shall be {interest_rate}% to be accrued yearly.', merge_tags: ['{interest_rate}'], explanation_text: 'This clause simply states the interest rate .', tag: 'loan_default')

ClauseTemplate.create(name: 'loan_base', text: 'This Loan Agreement (the “Agreement”) is entered into on ________ (the “Effective Date”), by and between {lender_name}, with an address of {lender_address}  (the “Lender”) and {borrower_name}, with an address of {borrower_address}, (the “Borrower”), collectively “the Parties.', merge_tags: ['{lender_name}', '{borrower_name}', '{lender_address}', '{borrower_address}'], explanation_text: 'This is a standard template for beginning of a loan contract, stating few important details, such as name and address of borrower/lender, as well as the date when this contract was signed.', tag: 'loan_base')

ClauseTemplate.create(name: 'loan_term', text: 'Loan Term. This Loan shall be for a period of {loan_repayment_duration} months.', merge_tags: ['{loan_repayment_duration}'], explanation_text: 'This clause states how long the loan will be paid back for.', tag: 'loan_default')

ClauseTemplate.create(name: 'prepayment', text: 'Prepayment. Borrower will not be penalized for early payment.', merge_tags: [], explanation_text: 'Prepayment allows borrowers to repay the borrowed sum early at a benefit of reduced interest.', tag: 'loan')

ClauseTemplate.create(name: 'default', text: 'Default (failure to fulfill an obligation). If Borrower defaults on its payments and fails to cure said default within a reasonable amount of time, Lender will have the option to declare the entire remaining amount of Principal and any accrued Interest immediately due and payable.', merge_tags: [], explanation_text: 'Defaulting is when the borrower fails to pay back the lender by the due date, or when he misses his recurring payment. This clause states that the lender will have the ability to make the borrower pay up the full amount when that happens.')

ClauseTemplate.create(name: 'legally_binding', text: 'Legal and Binding Agreement. This Agreement is legal and binding between the Parties as stated above. The Parties each represent that they have the authority to enter into this Agreement.', merge_tags: [], explanation_text: 'This clause ensures that this contract is legally enforceable.')

Clause.create([{name: 'test', tags: ['loans'], text: 'test 123'}])


Term.create(text: 'Default', explanation: "Failure to fulfill an obligation.")
Term.create(text: 'Representations and Warranties', explanation: "Statement of fact made to enter into contract.")
Term.create(text: 'Severability', explanation: "Cancelling of certain terms which may be invalid.")
Term.create(text: 'Waiver', explanation: "Voluntarily surrendering a right or privilege.")