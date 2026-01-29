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
    Adding Business Relationship for Customer Onboarding    ${RelationshipData}
    Create a Product package for Business Account           ${RelationshipData}
    Create a new Loan for nCino application method and verify LOS Stage    ${RelationshipData}
    # LOS Stage – Qualification
    Configure the Product Package Details and Assign Loan Officer to Loan Team    ${RelationshipData}
    Update Loan Information about Pricing Required fields and Rate and Payment Structure    ${RelationshipData}
    Create Household and Relationship Connections                        ${RelationshipData}
    Create a connection for the household relationship
    Verify the Exposer and create the debts
    Add Entity Involvement by adding CoBorrowers Guarantors to the Borrowing Structure and add Authorized Signers
    Add Collateral with Collateral Ownership in Loan
    Add the Origination Fee
    Generate the Product Package Credit Memo and update Deal Summary and Relationship Narrative
    Change the loan stege from Qualification to Proposal
    Generate Term Sheet via Generate Forms in the Loan Magic Wand
    Add Team Member in Loan
    Change the loan stege from Proposal to Credit Underwriting
    Verify and Review Household and Relationship Connection
    Create Risk Rating in Loan
    Add Covenants in Loan
    Verify Covenant in loan
    On Product Package assign Approver and add Household Relationship
    Configure Document Manager
    Change the loan stege from Credit Underwriting to
    Dealing with Loan Facilities
    Loan submit for Approval
    Change the loan stege Final Review to Approval
    Loan Approver by assign User
    Update the Origination Fee
    Regenerate Credit Memo with approval details
    Complete Review HMDA and CRA Reporting
    Change the loan stege from Approval to Processing
    Document Manager Approval
    Rate and payment configuration
    Approved Product package















