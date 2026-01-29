*** Settings ***
Library                         QForce
Library                         QVision
Library                         OperatingSystem
Resource                        ../resources/common.robot
Resource                        ../resources/data.robot
Suite Setup                     Setup Browser
Suite Teardown                  End Suite

*** Keywords ***
    ${RelationshipData}=        Data

Adding Business Relationship for Customer Onboarding
    [Documentation]             appstate to go directly to nCino / Relationships and create Onboarding
    [Arguments]                 ${RelationshipData}
    Home
    LaunchApp                   Relationships
    ClickText                   Relationships               partial_match=False
    ClickText                   New                         anchor=Import               partial_match=False
    Run Keyword                 Wait
    Use Modal                   On
    ClickText                   BusinessSelect "Business" to add a Corporation, Partnership, or other business relationship type.
    Run Keyword                 Wait
    ClickText                   Next
    ${Business_User_name}=      Generate Unique Name        ${RelationshipData["Name1"]}
    Set Suite Variable          ${Business_User_name}
    TypeText                    Relationship Name           ${Business_User_name}
    Picklist                    Type                        ${RelationshipData["Type1"]}
    ClickText                   Save                        partial_match=False

Create a Product package for Business Account
    [Arguments]                 ${RelationshipData}
    ClickText                   Relationships
    ClickText                   ${Business_User_name}
    Clicktext                   New Product Package         anchor=Edit
    ClickText                   Save
    ClickText                   Cancel
    ClickText                   Product Package Details
    VerifyText                  ${Business_User_name}
    ClickText                   Edit: Description
    TypeText                    Description                 Test
    ClickText                   Save

Create a new Loan for nCino application method and verify LOS Stage
    [Arguments]                 ${RelationshipData} ${stage}
    ClickText                   Loan Facilities
    ClickText                   Magic Wand: Tools and Actions
    ClickText                   New Facility
    VerifyText                  Add New Loan
    DropDown                    Product Line                ${RelationshipData["Product_Line"]}
    DropDown                    Product Type                ${RelationshipData["Product_Type"]}
    DropDown                    * Product                   ${RelationshipData["Product"]}
    DropDown                    Borrower Type               ${RelationshipData["Borrower_Type"]}
    TypeText                    Loan Amount                 ${RelationshipData["Loan_Amount"]}
    TypeText                    Loan Purpose                ${RelationshipData["Loan_Purpose"]}
    ClickText                   Create New Loan
    Run Keyword                 Wait
    Verify LOS Stage Using VerifyElement                    Qualification

Configure the Product Package Details and Assign Loan Officer to Loan Team
    [Arguments]                 ${RelationshipData}
    Clicktext                   Product Package
    Clicktext                   ${Business_User_name}       partial_match=True
    VerifyText                  Items required to submit for approval:
    Verifytext                  Package Information
    ClickText                   Edit: Household
    Clickelement                xpath=//label[text()='Household']//following::lightning-helptext//following-sibling::div//input
    ClickText                   ${RelationshipData["Parent_Household"]}
    Clickelement                xpath=//label[text()='Primary Officer']//following-sibling::div//input
    Clicktext                   ${RelationshipData["User"]}
    Clickelement                xpath=//label[text()='Secondary Officer']//following-sibling::div//input
    Clicktext                   ${RelationshipData["User"]}
    TypeText                    Total Borrower Exposure     ${RelationshipData["Total_Borrower_Exposure"]}
    TypeText                    Total Obligor Exposure      ${RelationshipData["Total_Obligor_Exposure"]}
    TypeText                    Unused                      ${RelationshipData["Unused"]}
    TypeText                    Outstanding                 ${RelationshipData["Outstanding"]}
    TypeText                    Total Credit Exposure       ${RelationshipData["Total_Credit_Exposur"]}
    TypeText                    New Money                   ${RelationshipData["New_Money"]}
    ClickText                   Save
    Run Keyword                 Wait

Update Loan Information about Pricing Required fields and Rate and Payment Structure
    [Arguments]                 ${RelationshipData}
    Clicktext                   Loans
    Clicktext                   ${Business_User_name}
    Run Keyword                 Wait
    ClickText                   Loan Information
    VerifyText                  Loan Details
    TypeText                    Loan Number                 ${RelationshipData["Loan_Number"]}
    ClickText                   --None--                    anchor=Primary Loan Purpose
    ClickText                   ${RelationshipData["Primary_Loan_Purpose"]}
    ClickText                   --None--                    anchor=Application Method
    ClickText                   ${RelationshipData["Application_Method"]}
    ClickText                   --None--                    anchor=Method of Doc Prep
    ClickText                   ${RelationshipData["Method_of_Doc_Prep"]}
    ClickCheckbox               Is Participation            on
    TypeText                    Prepayment Penalty Description                          ${RelationshipData["Prepayment_Penalty_Description"]}
    ClickText                   --None--                    anchor=Secondary Source of Repayment
    ClickText                   ${RelationshipData["Secondary_Source_of_Repayment"]}
    ClickText                   --None--                    anchor=Primary Source of Repayment
    ClickText                   ${RelationshipData["Primary_Source_of_Repayment"]}
    ClickText                   --None--                    anchor=Tertiary Source of Repayment
    ClickText                   ${RelationshipData["Tertiary_Source_of_Repayment"]}
    TypeText                    Loan Amount                 ${RelationshipData["Loan_Amount"]}
    ClickText                   Save
    Run Keyword                 Wait
    ClickText                   Loan Structuring
    Run Keyword                 Wait
    VerifyAll                   Loan Information from Details,Loan Calculated Fields
    VerifyText                  Amortization Structure
    ClickText                   Create Structure
    UseModal                    ON
    ClickText                   Effective Date
    ClickText                   Today
    TypeText                    Term Length                 ${RelationshipData["Term_Length"]}
    TypeText                    All-in Rate                 ${RelationshipData["All-in-Rate"]}
    ClickText                   Term Unit
    ClickText                   ${RelationshipData["Term_Unit"]}
    ClickText                   Variable
    ClickText                   Index
    ClickText                   ${RelationshipData["Index"]}
    TypeText                    Spread                      ${RelationshipData["Spread"]}
    ClickText                   Repayment Structure
    ClickText                   Payment Type
    ClickText                   ${RelationshipData["Payment_Type"]}
    TypeText                    Term Length                 ${RelationshipData["Term_Length"]}
    ClickText                   Effective Date
    ClickText                   Today
    ClickText                   Payment Frequency
    ClickText                   ${RelationshipData["Payment_Frequency"]}
    ClickText                   Save
    Run Keyword                 Wait


Create Household and Relationship Connections
    [Documentation]             appstate to go directly to nCino / Relationships and create Onboarding
    [Arguments]                 ${RelationshipData}
    ClickText                   Relationships
    VerifyPageHeader            Relationships
    # Add a new household relationship
    VerifyText                  New
    ClickText                   New                         anchor=Import               partial_match=False
    Use Modal                   On
    ClickText                   HouseholdSelect "Household" if you're adding a Household relationship type.
    ClickText                   Next
    ${Household_User_name}=     Generate Unique Name        ${RelationshipData["Name"]}
    Set Suite Variable          ${Household_User_name}
    TypeText                    Relationship Name           ${Household_User_name}
    ClickText                   Save                        partial_match=False
    Run Keyword                 Wait

    # Add a new individual relationship
    ClickText                   Relationships
    ClickText                   New                         anchor=Import               partial_match=False
    Run Keyword                 Wait
    Use Modal                   On
    ClickText                   IndividualSelect "Individual" to add an Individual relationship type.
    Run Keyword                 Wait
    ClickText                   Next
    ${Individual_User_name}=    Generate Unique Name        ${RelationshipData["Name2"]}
    Set Suite Variable          ${Individual_User_name}
    TypeText                    Relationship Name           ${Individual_User_name}
    Picklist                    Type                        ${RelationshipData["Type2"]}
    ClickText                   Save                        partial_match=False
    Run Keyword                 Wait

Create a connection for the household relationship
    [Arguments]                 ${RelationshipData}
    ClickText                   Relationships
    ClickText                   ${Household_User_name}
    ClickText                   Connections
    ClickText                   New
    Use Modal                   On
    Use Table                   Connected Relationship
    ClickCell                   r1c1
    TypeText                    Connected Relationship      ${Business_User_name}
    Clicktext                   Role
    ClickText                   Save
    Run Keyword                 Wait

Verify the Exposer and create the debts
    [Arguments]                 ${RelationshipData}
    ClickText                   Relationships
    ClickText                   ${Household_User_name}
    ClickText                   Exposure
    Run Keyword                 Wait
    ClickText                   Add Direct Debt
    TypeText                    Debt Name                   ${RelationshipData["DebtName1"]}
    Run Keyword                 Wait
    ClickText                   Principal Balance
    TypeText                    *Principal Balance          ${RelationshipData["value1"]}
    ClickText                   Principal Balance
    ClickText                   Save
    Run Keyword                 Wait
    ClickText                   Add Indirect Debt
    TypeText                    Debt Name                   ${RelationshipData["DebtName2"]}
    ClickText                   Principal Balance           delay=5
    TypeText                    *Principal Balance          ${RelationshipData["value2"]}
    ClickText                   Principal Balance
    ClickText                   Save
    Run Keyword                 Wait
    RefreshPage
    VerifyText                  ${Household_User_name}
    ClickText                   Exposure
    ClickText                   Recalculate Exposure
    Sleep                       20
    VerifyText                  Total Exposure Summary

Add Entity Involvement by adding CoBorrowers Guarantors to the Borrowing Structure and add Authorized Signers  
    [Arguments]                 ${RelationshipData}
    Clicktext                   Loans
    Clicktext                   ${Business_User_name}
    Run Keyword                 Wait
    Clicktext                   Borrowing Structure
    Sleep                       3
    ClickText                   Add Entity Involvement
    UseModal                    On
    ClickCheckbox               Select ${Household_User_name}                           on                          partial_match=false
    ClickCheckbox               Select all                  on
    Run Keyword                 Wait
    ClickText                   Add Selected Relationships
    UseModal                    On
    DropDown                    Borrower Type               ${RelationshipData["Borrower_Type"]}
    DropDown                    Contingent Type             ${RelationshipData["Contingent_Type"]}
    ClickText                   *Contingent Amount
    TypeText                    *Contingent Amount          ${RelationshipData["Contingent_Amount"]}                delay=5
    ClickText                   Save Entity Involvement
    Run Keyword                 Wait
    ClickText                   Continue

Add Collateral with Collateral Ownership in Loan
    [Arguments]                 ${RelationshipData}
    ClickText                   Add Collateral
    ClickText                   Add New Collateral
    ClickItem                   Select
    ClickText                   Next                        parent=LIGHTNING-BUTTON
    ClickText                   Next
    UseModal                    On
    ClickElement                xpath=//button[@aria-label="Type"]//following-sibling::div/lightning-icon//lightning-primitive-icon
    ClickItem                   ${RelationshipData["Type"]}
    ClickText                   *Subtype
    ClickItem                   ${RelationshipData["Subtype"]}
    TypeText                    Value                       ${RelationshipData["Value"]}
    TypeText                    Collateral Name             ${RelationshipData["Collateral_Name"]}
    TypeText                    City                        ${RelationshipData["City"]}
    TypeText                    Description                 ${RelationshipData["Description"]}
    ClickText                   Save & Next
    Run Keyword                 Wait
    ClickText                   Save Pledged Collateral
    Run Keyword                 Wait
    ClickCheckbox               Select Item 1               on                          partial_match=False
    ClickText                   Continue
    ${CollateralID}             GetUrl
    Set Suite Variable          ${CollateralID}

Add the Origination Fee
    [Arguments]                 ${RelationshipData}
    ClickText                   Add Fee
    ClickText                   Add Non-Standard Fee
    DropDown                    Fee Type                    ${RelationshipData["Fee_Type1"]}
    DropDown                    Calculation Type            ${RelationshipData["Calculation_Type"]}
    TypeText                    Percentage                  ${RelationshipData["Percentage"]}
    DropDown                    Fee Paid By                 ${RelationshipData["Fee_Paid_By"]}
    DropDown                    Basis Source                ${RelationshipData["Basis_Source"]}
    TypeText                    Amount                      ${RelationshipData["Amount"]}
    DropDown                    Collection Method           ${RelationshipData["Collection_Method"]}
    ClickText                   Save
    Run Keyword                 Wait
    ClickText                   Continue

financials and other documents and upload to Relationship and loan    
    [Arguments]                 ${RelationshipData}
    ClickText                   Relationships
    ClickText                   ${Business_User_name}       partial_match=True
    ${relative_path}            Set Variable                tests/../Data/relationships.png
    ${file_path}                Get File Path Based on Mode                             ${relative_path}
    ClickText                   Document Manager
    Run Keyword                 Wait
    Execute JavaScript          script= Array.from(document.querySelectorAll('input[type="file"]')).forEach(function(input) { input.className = 'enableAction'; })
    Upload File                 Upload Files                ${file_path}                anchor=Add Placeholder
    Sleep                       5
    RefreshPage
    ClickText                   Loans
    ClickText                   ${Business_User_name}       partial_match=True
    ClickText                   Document Manager
    ${relative_path}            Set Variable                tests/../Data/loan.png
    ${file_path}                Get File Path Based on Mode                             ${relative_path}
    Execute JavaScript          script= Array.from(document.querySelectorAll('input[type="file"]')).forEach(function(input) { input.className = 'enableAction'; })
    Upload File                 Upload Files                ${file_path}
    RefreshPage
Generate the Product Package Credit Memo and update Deal Summary and Relationship Narrative
    [Arguments]                 ${RelationshipData}
    Clicktext                   Product Package
    Clicktext                   ${Business_User_name}       partial_match=True
    Clicktext                   Magic Wand
    Clicktext                   Generate Credit Memo
    Run Keyword                 Wait
    Verifytext                  Generate Form
    Clicktext                   Generate
    QVision.Clicktext           Save to Document Manager    delay=20
    ${relative_path}            Set Variable                tests/../Data/PO.pdf
    ${file_path}                Get File Path Based on Mode                             ${relative_path}
    VerifyText                  Save To Placeholder
    UploadFile                  Upload                      ${file_path}
    Run Keyword                 Wait
    QVision.Clicktext           Placeholder
    QVision.Clicktext           ${RelationshipData["Document_Placeholder_Name"]}
    ClickText                   Save
    Back

Change the loan stage from Qualification to Proposal
    [Arguments]                 ${RelationshipData}         ${stage}
    ClickText                   Loans
    Clicktext                   ${Business_User_name}       partial_match=True
    Clicktext                   Mark Stage as Complete
    sleep                       3
    Verify LOS Stage Using VerifyElement                    Proposal

Generate Term Sheet via Generate Forms in the Loan Magic Wand
    [Arguments]                 ${RelationshipData}
    ClickText                   Loans
    ClickText                   ${Business_User_name}
    Clicktext                   Magic Wand
    ClickText                   Generate Forms
    ClickText                   Generate
    Run Keyword                 Wait
    #${Dfile_path}=             Verify File Download        timeout=30


Add Loan assistant Team Member in Loan   
    [Arguments]                 ${RelationshipData}
    ClickText                   Loans
    ClickText                   ${Business_User_name}
    Clicktext                   Loan Team
    Verifytext                  Team Members
    ClickText                   Add New
    UseModal                    On
    ClickText                   Role
    TypeText                    Role                        ${RelationshipData["Role"]}
    ClickText                   ${RelationshipData["Role"]}
    ClickText                   User
    TypeText                    User                        ${RelationshipData["User"]}
    ClickText                   ${RelationshipData["User"]}
    ClickText                   Save                        partial_match=False
    Run Keyword                 Wait
    ClickText                   Continue
    Run Keyword                 Wait
Upload documents to DocMan on the Collateral   
    [Arguments]                 ${RelationshipData}
    GoTo                        ${CollateralID}
    ClickText                   Document Manager
    ClickText                   Collateral Valuation
    ${relative_path}            Set Variable                tests/../Data/Collateral.png
    ${file_path}                Get File Path Based on Mode                             ${relative_path}
    Execute JavaScript          script= Array.from(document.querySelectorAll('input[type="file"]')).forEach(function(input) { input.className = 'enabledAction'; })
    Upload File                 Upload Files                ${file_path}                anchor=Portal Options
    RefreshPage


Change the loan stage from Proposal to Credit Underwriting
    [Arguments]                 ${RelationshipData}         ${stage}
    ClickText                   Loans
    Clicktext                   ${Business_User_name}       partial_match=True
    Clicktext                   Mark Stage as Complete
    sleep                       3
    Verify LOS Stage Using VerifyElement                    Credit Underwriting

Verify and Review Household and Relationship Connection
    [Arguments]                 ${RelationshipData}
    ClickText                   Relationships
    VerifyText                  ${Individual_User_name}
    VerifyText                  ${Business_User_name}
    VerifyText                  ${Household_User_name}
    ClickText                   ${Household_User_name}
    VerifyField                 Relationship Type           ${RelationshipData["Type0"]}
    ClickText                   Relationships
    ClickText                   ${Business_User_name}
    VerifyField                 Relationship Type           ${RelationshipData["Type1"]}
    ClickText                   Relationships
    ClickText                   ${Individual_User_name}
    VerifyField                 Relationship Type           ${RelationshipData["Type2"]}

Review Doc Man on the Loan and Borrower and Collateral   
    [Arguments]                 ${RelationshipData}         ${CollateralID}
    ClickText                   Relationships
    Clicktext                   ${Business_User_name}       partial_match=True
    ClickText                   Document Manager
    Run Keyword                 Wait
    ClickText                   Upload Files
    QVision.ClickText           Cancel
    VerifyText                  File Staging
    VerifyText                  relationship.png
    ClickText                   Loans
    Clicktext                   ${Business_User_name}       partial_match=True
    ClickText                   Document Manager
    Run Keyword                 Wait
    ClickText                   Upload Files
    QVision.ClickText           Cancel
    VerifyText                  File Staging
    VerifyText                  loan.png
    GoTo                        ${CollateralID}
    ClickText                   Document Manager
    ClickText                   Collateral Valuations
    VerifyText                  Collateral.png

Perform Spreads 
    [Arguments]                 ${RelationshipData}

Create Risk Rating in Loan 
    [Arguments]                 ${RelationshipData}
    ClickText                   Loans
    ClickText                   ${Business_User_name}
    ClickText                   Create Risk Rating
    ClickElement                xpath=//select[@id="accounts-list"]
    DropDown                    accounts-list               ${Business_User_name} - Corporation                     partial_match=False
    Sleep                       1
    DropDown                    templates-list              ${RelationshipData["templates-list"]}
    ClickText                   Save
    Run Keyword                 Wait
    RefreshPage

Add Covenants in Loan   
    [Arguments]                 ${RelationshipData}
    ClickText                   Relationships
    ClickText                   ${Business_User_name}
    ClickText                   Credit Resources
    ClickText                   Covenants
    ClickText                   Create Covenant
    UseModal                    On
    ClickText                   *Category
    ClickText                   ${RelationshipData["CategoryCov"]}
    ClickText                   *Effective Date
    ClickText                   Today
    ClickText                   *Covenant Type
    ClickText                   ${RelationshipData["Covenant_Type"]}
    ClickText                   *Frequency Template
    ClickText                   ${RelationshipData["Frequency_Template"]}
    TypeText                    Grace Days                  ${RelationshipData["Grace_Days"]}
    ClickText                   Create                      partial_match=False
    Run Keyword                 Wait

Verify Covenant in loan
    [Arguments]                 ${RelationshipData}
    Clicktext                   Covenants
    ClickElement                xpath=//button[contains(@title,'COV-')]
    VerifyAll                   Category,Covenant Type
    Verifytext                  ${RelationshipData["CategoryCov"]}
    Verifytext                  ${RelationshipData["Covenant_Type"]}                    anchor=Category

Compliance Questionnaires
    [Arguments]                 ${RelationshipData}
    ClickText                   Loans
    ClickText                   ${Business_User_name}
    Clicktext                   Compliance
    Run Keyword                 Wait
    Clicktext                   HMDA Eligibility
    DropDown                    Is the loan or line of credit secured by a lien on a dwelling?                      ${RelationshipData["Question1"]}
    DropDown                    Is the loan temporary financing? (i.e., designed to be replaced by a permanent financing)            ${RelationshipData["Question2"]}
    DropDown                    I certify that this loan IS NOT HMDA Reportable.        ${RelationshipData["Question3"]}
    ClickText                   Continue
    DropDown                    Is any borrower, co-borrower, or guarantor an executive officer, director, or principal shareholder of that bank, of a bank holding company of which the member bank is a subsidiary, and of any other subsidiary of that bank holding company?    ${RelationshipData["Question4"]}
    DropDown                    If any borrower, co-borrower, or guarantor of this loan is an employee of the bank or any affiliates, I certify I have indicated this is an "Employee Loan".    ${RelationshipData["Question5"]}
    #DropDown                   I certify this loan has been marked as "Reg O Reportable".                          ${RelationshipData["Question6"]}
    ClickText                   Continue
    Sleep                       5
    ClickText                   Continue
    Sleep                       5
    ClickText                   Continue
    Sleep                       5
    Dropdown                    Will this loan be used for construction of:             A 1-4 Family Residence
    ClickText                   Continue
    Sleep                       5
    DropDown                    Is this loan HMDA reportable?                           ${RelationshipData["Question1"]}
    ClickText                   Continue
    Sleep                       5
    ClickText                   Edit: HMDA Record Type
    ClickText                   --None--                    anchor=HMDA Record Type
    ClickText                   ${RelationshipData["HMDA_Record_Type"]}                 anchor=Skip to Navigation
    ClickText                   Save

On Product Package assign Approver and add Household Relationship
    [Arguments]                 ${RelationshipData}
    Clicktext                   Product Package
    Clicktext                   ${Business_User_name}       partial_match=True
    VerifyText                  Items required to submit for approval:
    Verifytext                  Package Information
    Clicktext                   Assign Approvers            partial_match=False         anchor=Product Package Details
    Run Keyword                 Wait
    Verifytext                  Level 1 Approval
    VerifyText                  Approver 1
    Clickelement                xpath=//label[text()='Approver 1']//following::lightning-helptext//following-sibling::div//input
    Clicktext                   ${RelationshipData["User"]}                             anchor=Approver 1
    Verifytext                  Level 2 Approval
    Clickelement                xpath=//label[text()='Approver 2']//following::lightning-helptext//following-sibling::div//input
    Clicktext                   ${RelationshipData["User"]}                             anchor=Approver 2
    Verifytext                  Level 3 Approval
    Clickelement                xpath=//label[text()='Approval Committee']//parent::span//following-sibling::div/lightning-base-combobox//button
    Clicktext                   ${RelationshipData["Approval_Committee"]}               anchor=Approver 3
    Clicktext                   Save                        anchor=Cancel
    Run Keyword                 Wait

Configure Document Manager
    [Arguments]                 ${RelationshipData}         ${relative_path}            ${file_path}
    Clicktext                   Product Package
    Clicktext                   ${Business_User_name}       partial_match=True
    Clicktext                   Document Manager
    Run Keyword                 Wait
    Clicktext                   Add Placeholder             delay=5
    Usemodal                    on
    ClickElement                xpath=//input[@id="docTypeInputField"]
    ClickText                   ${RelationshipData["Category"]}
    ClickElement                xpath=//input[@id="nameInputField"]
    ClickText                   ${RelationshipData["Document_Placeholder_Name"]}
    Typetext                    Year                        ${RelationshipData["Year"]}
    Clicktext                   Save                        anchor=Cancel
    Usemodal                    Off
    Sleep                       5
    Clicktext                   ${RelationshipData["Document_Placeholder_Name"]}        anchor=Open
    VerifyAll                   Name,Category,Year
    Verifytext                  ${RelationshipData["Document_Placeholder_Name"]}
    Verifytext                  ${RelationshipData["Category"]}
    ${relative_path}            Set Variable                tests/../Data/PO.pdf
    ${file_path}                Get File Path Based on Mode                             ${relative_path}
    Clicktext                   More Options
    Execute JavaScript          script= Array.from(document.querySelectorAll('input[type="file"]')).forEach(function(input) { input.className = 'enabledAction'; })
    Upload File                 Add File                    ${file_path}                anchor=Portal Options
    RefreshPage

Change the loan stage from Credit Underwriting to Final Review
    [Arguments]                 ${RelationshipData}         ${stage}
    ClickText                   Loans
    Clicktext                   ${Business_User_name}       partial_match=True
    Clicktext                   Mark Stage as Complete
    sleep                       3
    Verify LOS Stage Using VerifyElement                    Final Review

Review Loan and associated Product Package
    [Arguments]                 ${RelationshipData}
    ClickText                   Loans
    Clicktext                   ${Business_User_name}       partial_match=True          #Loan
    VerifyElementText           //p[text()\='Relationship']/following::p[1]             ${Business_User_name}       partial_match=True    #Relationship
    VerifyElement               //a[contains(text(),'PP')]                              #Product package

Dealing with Loan Facilities

    [Arguments]                 ${RelationshipData}
    Clicktext                   Product Package
    Clicktext                   ${Business_User_name}       partial_match=True
    Clicktext                   Loan Facilities             anchor=Fees
    VerifyElementText           //p[text()\='Number of Reviewable Loan Facilities']/following::lightning-formatted-number[1]         0
    Verifytext                  All Facilities
    Clickelement                xpath=//button[text()='Edit']
    ClickCheckbox               Is Review Ready             on
    Clicktext                   Save
    Refreshpage
    VerifyElementText           //p[text()\='Number of Reviewable Loan Facilities']/following::lightning-formatted-number[1]         1

Loan submit for Approval
    [Arguments]                 ${RelationshipData}
    Clicktext                   Magic Wand
    Clicktext                   Submit For Approval
    VerifyText                  Product Package Approval Process
    ClickText                   Back to Product Package
    VerifyText                  This Product Package is currently pending approval and locked for any edits

Change the loan stage Final Review to Approval
    [Arguments]                 ${RelationshipData}         ${stage}
    ClickText                   Loans
    Clicktext                   ${Business_User_name}       partial_match=True
    sleep                       3
    Verify LOS Stage Using VerifyElement                    Approval / Loan Committee
Loan Approver by assign User   
    [Arguments]                 ${RelationshipData}
    LaunchApp                   Approval Requests
    VerifyText                  ${Business_User_name}
    ClickText                   Show Actions                anchor=${Business_User_name}
    ClickText                   Approve
    TypeText                    Comments                    Approving test 1
    Run Keyword                 Wait
    ClickText                   Approve                     partial_match=False
    VerifyText                  ${Business_User_name}
    ClickText                   Show Actions                anchor=${Business_User_name}
    ClickText                   Approve
    TypeText                    Comments                    Approving test 2
    Run Keyword                 Wait
    ClickText                   Approve                     partial_match=False

Update the Origination Fee
    [Arguments]                 ${RelationshipData}
    ClickText                   Fees
    Clicktext                   Add Fee
    ClickText                   Add Non-Standard Fee
    DropDown                    Fee Type                    ${RelationshipData["Fee_Type2"]}
    DropDown                    Calculation Type            ${RelationshipData["Calculation_Type"]}
    TypeText                    Percentage                  ${RelationshipData["Percentage"]}
    DropDown                    Fee Paid By                 ${RelationshipData["Fee_Paid_By"]}
    DropDown                    Basis Source                ${RelationshipData["Basis_Source"]}
    TypeText                    Amount                      ${RelationshipData["Amount"]}
    DropDown                    Collection Method           ${RelationshipData["Collection_Method"]}
    ClickText                   Save
    Run Keyword                 Wait

Regenerate Credit Memo with approval details 
    [Arguments]                 ${RelationshipData}
    Clicktext                   Product Package
    Clicktext                   ${Business_User_name}       partial_match=True
    Clicktext                   Magic Wand
    Clicktext                   Generate Credit Memo
    Run Keyword                 Wait
    Verifytext                  Generate Form
    Clicktext                   Generate
    QVision.Clicktext           Save to Document Manager    delay=20
    ${relative_path}            Set Variable                tests/../Data/PO.pdf
    Set Suite Variable          ${relative_path}
    ${file_path}                Get File Path Based on Mode                             ${relative_path}
    Set Suite Variable          ${file_path}
    VerifyText                  Save To Placeholder
    UploadFile                  Upload                      ${file_path}
    Run Keyword                 Wait
    QVision.Clicktext           Placeholder
    QVision.Clicktext           ${RelationshipData["Document_Placeholder_Name"]}
    ClickText                   Save
    Back

Complete Review HMDA and CRA Reporting
    [Arguments]                 ${RelationshipData}
    ClickText                   Loans
    ClickText                   ${Business_User_name}
    Clicktext                   Compliance
    Run Keyword                 Wait
    ClickText                   Certifications
    VerifyAll                   Employee Loan,Reg O Loan,CRA Reportable,HMDA Record Type,HMDA Reportable,


Change the loan stage from Approval to Processing
    [Arguments]                 ${RelationshipData}         ${stage}
    ClickText                   Loans
    Clicktext                   ${Business_User_name}       partial_match=True
    Clicktext                   Mark Stage as Complete
    sleep                       3
    Verify LOS Stage Using VerifyElement                    Processing

Approved Product package
    [Arguments]                 ${RelationshipData}
    Clicktext                   Product Package
    Clicktext                   ${Business_User_name}       partial_match=True
    Run Keyword                 Wait
    ClickText                   Approval History
    ClickElement                xpath=//button[@data-toggle="dropdown"]
    ClickElement                xpath=//a[@data-ncino-element-id="PICKLIST-APPROVE_/_REJECT"]
    Run Keyword                 Wait
    TypeText                    Comments                    Approving Product Package
    ClickText                   Approve
    Run Keyword                 Wait


Document Manager Approval
    [Arguments]                 ${RelationshipData}         ${relative_path}            ${file_path}
    ClickText                   Loans
    Clicktext                   ${Business_User_name}       partial_match=True
    Clicktext                   Document Manager
    Run Keyword                 Wait
    ClickText                   In-File                     anchor= ${RelationshipData["Document_Placeholder_Name"]}
    ClickText                   Approved
    VerifyText                  Approved                    anchor=Status
    Run Keyword                 Wait

Change the loan stage from Processing to Doc Prep
    [Arguments]                 ${RelationshipData}         ${stage}
    ClickText                   Loans
    Clicktext                   ${Business_User_name}       partial_match=True
    Clicktext                   Mark Stage as Complete
    sleep                       3
    Verify LOS Stage Using VerifyElement                    Doc Prep

Rate and payment configuration
    [Arguments]                 ${RelationshipData}
    ClickText                   Loans
    ClickText                   ${Business_User_name}       partial_match=True
    ClickText                   Approved Details
    Verifytext                  Payment Structure
    Verifytext                  Rate Structure
    VerifyAll                   Sequence,Effective Date,Term Length,Term Unit


Configure the Loan Document
    [Arguments]                 ${RelationshipData}
    LaunchApp                   Loan Documents
    ClickText                   New
    UseModal                    On
    TypeText                    *Name                       ${RelationshipData["LoanName"]}
    ComboBox                    Search Loans...             ${Business_User_name}       partial_match=True
    ClickText                   Select a date for Date      anchor=Approval Date
    ClickText                   Today
    ComboBox                    Search People...            ${RelationshipData["User"]}
    ComboBox                    Search Closing Checklists...                            ${RelationshipData["ClosingChecklistName"]}
    ComboBox                    Search DocManagers...       Account
    PickList                    Priority                    ${RelationshipData["Priority"]}
    PickList                    -D Portal Doc Type          --None--
    PickList                    -D Portal Doc Type          ${RelationshipData["-D_Portal_Doc_Type"]}
    PickList                    Review Status               ${RelationshipData["Review_Status"]}
    ClickText                   Save                        partial_match=False
    UseModal                    Off

Change the loan stage from Doc Prep to Closing
    [Arguments]                 ${RelationshipData}         ${stage}
    ClickText                   Loans
    Clicktext                   ${Business_User_name}       partial_match=True
    Clicktext                   Mark Stage as Complete
    sleep                       3
    Verify LOS Stage Using VerifyElement                    Closing

Change the loan stage from Closing to Boarding
    [Arguments]                 ${RelationshipData}         ${stage}
    ClickText                   Loans
    Clicktext                   ${Business_User_name}       partial_match=True
    Clicktext                   Mark Stage as Complete
    sleep                       3
    Verify LOS Stage Using VerifyElement                    Boarding
    
Change the loan stage from Boarding to Booked
    [Arguments]                 ${RelationshipData}         ${stage}
    ClickText                   Loans
    Clicktext                   ${Business_User_name}       partial_match=True
    Clicktext                   Mark Stage as Complete
    sleep                       3
    Verify LOS Stage Using VerifyElement                    Booked   


























