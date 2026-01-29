*** Settings ***
Resource                        ../resources/Keyword.robot
Resource                        ../resources/data.robot
Suite Setup                     Setup Browser
Suite Teardown                  End Suite

#nCino customization differs with organization, please check the configuration in your nCino Org and make the changes accordingly.
*** Test Cases ***   
E2E Positive flow
    [tags]                      nCino
    ${RelationshipData}=        Data
    # LOS Stage – Qualification
    Adding Business Relationship for Customer Onboarding    ${RelationshipData}
    Create a Product package for Business Account           ${RelationshipData}
    Create a new Loan for nCino application method and verify LOS Stage         ${RelationshipData}
    # LOS Stage – Proposal
    Configure the Product Package Details and Assign Loan Officer to Loan Team                  ${RelationshipData}
    Update Loan Information about Pricing Required fields and Rate and Payment Structure        ${RelationshipData}
    Create Household and Relationship Connections           ${RelationshipData}
    Create a connection for the household relationship      ${RelationshipData}
    Verify the Exposer and create the debts                 ${RelationshipData}
    Add Entity Involvement by adding CoBorrowers Guarantors to the Borrowing Structure and add Authorized Signers    ${RelationshipData}
    Add Collateral with Collateral Ownership in Loan        ${RelationshipData}
    Add the Origination Fee     ${RelationshipData}
    financials and other documents and upload to Relationship and loan          ${RelationshipData}
    Generate the Product Package Credit Memo and update Deal Summary and Relationship Narrative    ${RelationshipData}
    Change the loan stage from Qualification to Proposal    ${RelationshipData}                 ${stage}
    # LOS Stage – Credit Underwriting
    Generate Term Sheet via Generate Forms in the Loan Magic Wand               ${RelationshipData}
    Add Loan assistant Team Member in Loan                  ${RelationshipData}
    Upload documents to DocMan on the Collateral            ${RelationshipData}
    Change the loan stage from Proposal to Credit Underwriting                  ${RelationshipData}    ${stage}
    # LOS Stage – Final Review
    Verify and Review Household and Relationship Connection                     ${RelationshipData}
    Review Doc Man on the Loan and Borrower and Collateral                      ${RelationshipData}    ${CollateralID}
    Create Risk Rating in Loan                              ${RelationshipData}
    Add Covenants in Loan       ${RelationshipData}
    Verify Covenant in loan     ${RelationshipData}
    Compliance Questionnaires                               ${RelationshipData}
    On Product Package assign Approver and add Household Relationship           ${RelationshipData}
    Configure Document Manager                              ${RelationshipData}                 ${relative_path}    ${file_path}
    Change the loan stage from Credit Underwriting to Final Review              ${RelationshipData}    ${stage}
    # LOS Stage – Approval
    Review Loan and associated Product Package              ${RelationshipData}
    Dealing with Loan Facilities                            ${RelationshipData}
    Loan submit for Approval    ${RelationshipData}
    Change the loan stage Final Review to Approval          ${RelationshipData}                 ${stage}
    # LOS Stage – Processing
    Loan Approver by assign User                            ${RelationshipData}
    Update the Origination Fee                              ${RelationshipData}
    Regenerate Credit Memo with approval details            ${RelationshipData}
    Complete Review HMDA and CRA Reporting                  ${RelationshipData}
    Change the loan stage from Approval to Processing       ${RelationshipData}                 ${stage}
    # LOS Stage – Doc Prep
    Approved Product package    ${RelationshipData}
    Document Manager Approval                               ${RelationshipData}                 ${relative_path}    ${file_path}
    Change the loan stage from Processing to Doc Prep       ${RelationshipData}                 ${stage}
    # LOS Stage – Closing
    Rate and payment configuration                          ${RelationshipData}
    Configure the Loan Document                             ${RelationshipData}
    Change the loan stage from Doc Prep to Closing          ${RelationshipData}                 ${stage}
    # LOS Stage – Boarding
    Change the loan stage from Closing to Boarding          ${RelationshipData}                 ${stage}
    # LOS Stage – Booked
    Change the loan stage from Boarding to Booked           ${RelationshipData}                 ${stage}


