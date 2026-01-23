*** Settings ***
Library                         QForce
Library                         Collections
Library                         RequestsLibrary
Library                         JSONLibrary
Library                         QVision
Library                         OperatingSystem
Library                         SeleniumLibrary
Library                         ../CustomLibrary/custom_upload_file.py
Resource                        ../resources/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End Suite




*** Keywords ***
Data

    ${Json_obj}=                Evaluate                    open('${CURDIR}/../Data/Data.json').read()              json
    ${dataA}=                   Evaluate                    json.loads('''${Json_obj}''')                           json

    
    ${Household_Rel}=           Set Variable                ${dataA["data1Relationship"]}
    ${Business_Rel}=            Set Variable                ${dataA["data2Relationship"]}
    ${Individual_Rel}=          Set Variable                ${dataA["data3Relationship"]}
    ${Direct_D}=                Set Variable                ${dataA["DirectDebt"]}
    ${Indirect_D}=              Set Variable                ${dataA["IndirectDebt"]}
    ${Loan}=                    Set Variable                ${dataA["Loan"]}
    ${Loan_Info}=               Set Variable                ${dataA["LoanData"]}
    ${Entity_Inv}=              Set Variable                ${dataA["EntityInvolvement"]}
    ${Collateral}=              Set Variable                ${dataA["Collateral"]}
    ${Fee}=                     Set Variable                ${dataA["Fee"]}
    ${Risk_R}=                  Set Variable                ${dataA["RiskRating"]}
    ${Covenant}=                Set Variable                ${dataA["Covenant"]}
    ${Product_Pac}=             Set Variable                ${dataA["Product Package"]}
    ${Doc_Man}=                 Set Variable                ${dataA["Document Manager"]}
    ${Compliance}=              Set Variable                ${dataA["Compliance"]}

    
    ${RelationshipData}=        Create Dictionary
    ...                         Name=${Household_Rel["Relationship Name"]}
    ...                         Type0=${Household_Rel["Type"]}
    ...                         Role=${Household_Rel["Role"]}
    ...                         Name1=${Business_Rel["Relationship Name"]}
    ...                         Type1=${Business_Rel["Type"]}
    ...                         Role1=${Business_Rel["Role"]}
    ...                         Contact=${Business_Rel["Contact"]}
    ...                         Name2=${Individual_Rel["Relationship Name"]}
    ...                         Type2=${Individual_Rel["Type"]}
    ...                         DebtName1=${Direct_D["Debt Name"]}
    ...                         value1=${Direct_D["Principal Balance"]}
    ...                         DebtName2=${Indirect_D["Debt Name"]}
    ...                         value2=${Indirect_D["Principal Balance"]}

    ...                         Product_Line=${Loan["Product Line"]}
    ...                         Product_Type=${Loan["Product Type"]}
    ...                         Product=${Loan["Product"]}
    ...                         Borrower_Type=${Loan["Borrower Type"]}
    ...                         Loan_Amount=${Loan["Loan Amount"]}
    ...                         Loan_Purpose=${Loan["Loan Purpose"]}

    ...                         Loan_Number=${Loan_Info["Loan Number"]}
    ...                         Primary_Loan_Purpose=${Loan_Info["Primary Loan Purpose"]}
    ...                         Application_Method=${Loan_Info["Application Method"]}
    ...                         Method_of_Doc_Prep=${Loan_Info["Method of Doc Prep"]}
    ...                         Prepayment_Penalty_Description=${Loan_Info["Prepayment Penalty Description"]}
    ...                         Secondary_Source_of_Repayment=${Loan_Info["Secondary Source of Repayment"]}
    ...                         Primary_Source_of_Repayment=${Loan_Info["Primary Source of Repayment"]}
    ...                         Tertiary_Source_of_Repayment=${Loan_Info["Tertiary Source of Repayment"]}
    ...                         Loan_Amount=${Loan_Info["Loan Amount"]}
    ...                         User=${Loan_Info["User"]}
    ...                         Role=${Loan_Info["Role"]}

    ...                         Borrower_Type=${Entity_Inv["Borrower Type"]}
    ...                         Contingent_Type=${Entity_Inv["Contingent Type"]}
    ...                         Contingent_Amount=${Entity_Inv["Contingent Amount"]}

    ...                         Type=${Collateral["Type"]}
    ...                         Subtype=${Collateral["Subtype"]}
    ...                         Value=${Collateral["Value"]}
    ...                         Collateral_Name=${Collateral["Collateral Name"]}
    ...                         City=${Collateral["City"]}
    ...                         Description=${Collateral["Description"]}

    ...                         Fee_Type1=${Fee["Fee Type1"]}
    ...                         Calculation_Type=${Fee["Calculation Type"]}
    ...                         Percentage=${Fee["Percentage"]}
    ...                         Fee_Paid_By=${Fee["Fee Paid By"]}
    ...                         Basis_Source=${Fee["Basis Source"]}
    ...                         Amount=${Fee["Amount"]}
    ...                         Collection_Method=${Fee["Collection Method"]}
    ...                         Fee_Type2=${Fee["Fee Type2"]}

    ...                         templates-list=${Risk_R["templates-list"]}

    ...                         CategoryCov=${Covenant["CategoryCov"]}
    ...                         Covenant_Type=${Covenant["Covenant Type"]}
    ...                         Effective_Date=${Covenant["Effective Date"]}
    ...                         Frequency_Template=${Covenant["Frequency Template"]}
    ...                         Grace_Days=${Covenant["Grace Days"]}

    ...                         Total_Borrower_Exposure=${Product_Pac["Total Borrower Exposure"]}
    ...                         Total_Obligor_Exposure=${Product_Pac["Total Obligor Exposure"]}
    ...                         Unused=${Product_Pac["Unused"]}
    ...                         Outstanding=${Product_Pac["Outstanding"]}
    ...                         Total_Credit_Exposur=${Product_Pac["Total Credit Exposur"]}
    ...                         New_Money=${Product_Pac["New Money"]}
    ...                         Approval_Committee=${Product_Pac["Approval Committee"]}
    ...                         Parent_Household=${Product_Pac["Parent Household"]}

    ...                         Category=${Doc_Man["Category"]}
    ...                         Document_Placeholder_Name=${Doc_Man["Document Placeholder Name"]}
    ...                         Year=${Doc_Man["Year"]}

    ...                         Question1=${Compliance["Is the loan or line of credit secured by a lien on a dwelling"]}
    ...                         Question2=${Compliance["Is the loan temporary financing? (i.e., designed to be replaced by a permanent financing)"]}
    ...                         Question3=${Compliance["I certify that this loan IS NOT HMDA Reportable."]}
    ...                         Question4=${Compliance["Is any borrower, co-borrower, or guarantor an executive officer, director, or principal shareholder of that bank, of a bank holding company of which the member bank is a subsidiary, and of any other subsidiary of that bank holding company?"]}
    ...                         Question5=${Compliance["If any borrower, co-borrower, or guarantor of this loan is an employee of the bank or any affiliates, I certify I have indicated this is an "Employee Loan"."]}
    ...                         Question6=${Compliance["I certify this loan has been marked as "Reg O Reportable"."]}
    ...                         HMDA_Record_Type=${Compliance["HMDA Record Type"]}


    [Return]                    ${RelationshipData}

Verify LOS Stage Using VerifyElement
    [Arguments]                 ${stage}

    VerifyElement               //span[@class\='current slds-path__stage']//following::span[text()\='${stage}']     20
Adding Relationships for Customer Onboarding
    [Documentation]             appstate to go directly to nCino / Relationships and create Onboarding
    [Arguments]                 ${RelationshipData}
    Home
    LaunchApp                   Relationships
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

    # Add a new business relationship
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

Verify the Relationships  
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

Verify the Exposer abd create the debts
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

Create a Contact for Bussiness Account
    [Arguments]                 ${RelationshipData}
    ClickText                   Relationships
    ClickText                   ${Business_User_name}
    ClickText                   Contacts                    anchor=Credit Actions
    ClickText                   New                         partial_match=False
    UseModal                    ON
    PickList                    Salutation                  Mr.
    TypeText                    Last Name                   ${RelationshipData["Contact"]}
    ClickCheckbox               Primary Contact             on
    ClickText                   Save                        partial_match=False
    Run Keyword                 Wait
Verifying contact creation
    [Arguments]                 ${RelationshipData}
    ClickText                   ${RelationshipData["Contact"]}
    VerifyField                 Name                        Mr. ${RelationshipData["Contact"]}
    VerifyField                 Relationship Name           ${Business_User_name}       partial_match=true
    Verifytext                  Primary Contact


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

Create a new Loan
    [Arguments]                 ${RelationshipData}
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
    ClickText                   Loan Information
    VerifyText                  Loan Details

Fill the Loan information
    [Arguments]                 ${RelationshipData}
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
    VerifyAll                   Loan Information from Details,Loan Calculated Fields
    ClickText                   Continue

Add Team Member in Loan   
    [Arguments]                 ${RelationshipData}
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

Add Entity Involvement by adding Co-Borrowers/Guarantors to the Borrowing Structure and add Authorized Signers  
    [Arguments]                 ${RelationshipData}
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

Add Collateral in Loan
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

Add Fee in Loan 
    [Arguments]                 ${RelationshipData}
    ClickText                   Add Fee
    ClickText                   Add Non-Standard Fee
    DropDown                    Fee Type                    ${RelationshipData["Fee_Type"]}
    DropDown                    Calculation Type            ${RelationshipData["Calculation_Type"]}
    TypeText                    Percentage                  ${RelationshipData["Percentage"]}
    DropDown                    Fee Paid By                 ${RelationshipData["Fee_Paid_By"]}
    DropDown                    Basis Source                ${RelationshipData["Basis_Source"]}
    TypeText                    Amount                      ${RelationshipData["Amount"]}
    DropDown                    Collection Method           ${RelationshipData["Collection_Method"]}
    ClickText                   Save
    Run Keyword                 Wait
    ClickText                   Continue

Create Risk Rating in Loan 
    [Arguments]                 ${RelationshipData}
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

Configure the Product Package Details and assign Approval Users
    [Arguments]                 ${RelationshipData}
    Clicktext                   Product Package
    Clicktext                   ${Business_User_name}       partial_match=True
    VerifyText                  Items required to submit for approval:
    Verifytext                  Package Information

    ClickText                   Edit: Household
    Clickelement                xpath=//label[text()='Household']//following::lightning-helptext//following-sibling::div//input
    ClickText                   ${RelationshipData["Parent Household"]}
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
    Clicktext                   Assign Approvers            partial_match=False         anchor=Product Package Details
    Run Keyword                 Wait
    Clickelement                xpath=//label[text()='Approver 1']//following::lightning-helptext//following-sibling::div//input
    Clicktext                   ${RelationshipData["User"]}                             anchor=Approver 1
    Clickelement                xpath=//label[text()='Approver 2']//following::lightning-helptext//following-sibling::div//input
    Clicktext                   ${RelationshipData["User"]}                             anchor=Approver 2
    Clickelement                xpath=//label[text()='Approval Committee']//parent::span//following-sibling::div/lightning-base-combobox//button
    Clicktext                   ${RelationshipData["Approval_Committee"]}
    Clicktext                   Save                        anchor=Cancel
    Run Keyword                 Wait

Configure Document Manager
    [Arguments]                 ${RelationshipData}
    Clicktext                   Product Package
    Clicktext                   ${Business_User_name}
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
    Sleep                       3
    Clicktext                   ${RelationshipData["Document_Placeholder_Name"]}
    VerifyAll                   Name,Category,Year
    Verifytext                  ${RelationshipData["Document_Placeholder_Name"]}
    Verifytext                  ${RelationshipData["Category"]}


Dealing with Loan Facilities

    [Arguments]                 ${RelationshipData}
    Clicktext                   Product Package
    Clicktext                   ${Business_User_name}       partial_match=True
    Clicktext                   Loan Facilities             anchor=Fees
    VerifyElementText           //p[text()\='Number of Reviewable Loan Facilities']/following::lightning-formatted-number[1]    0
    Verifytext                  All Facilities
    Clickelement                xpath=//button[text()='Edit']
    ClickCheckbox               Is Review Ready             on
    Clicktext                   Save
    Refreshpage
    VerifyElementText           //p[text()\='Number of Reviewable Loan Facilities']/following::lightning-formatted-number[1]    1

Create a Credit Memo 
    [Arguments]                 ${RelationshipData}
    Clicktext                   Magic Wand
    Clicktext                   Generate                    Credit Memo
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


Loan submit for Approval
    [Arguments]                 ${RelationshipData}
    Clicktext                   Magic Wand
    Clicktext                   Submit For Approval
    VerifyText                  Product Package Approval Process
    ClickText                   Back to Product Package
    VerifyText                  This Product Package is currently pending approval and locked for any edits

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

Generate Commitment Letter via Generate Forms 
    [Arguments]                 ${RelationshipData}
    ClickText                   Loans
    ClickText                   ${Business_User_name}
    Clicktext                   Magic Wand
    ClickText                   Generate Forms
    ClickText                   Generate
    Run Keyword                 Wait
    # ${file_path}=             Verify File Download        timeout=30

Configuring Loan
    [Arguments]                 ${RelationshipData} ${file_patha} ${file_input_xpath}, ${upload_button_xpath}
    ClickText                   Loans
    ClickText                   ${Business_User_name}
    ${relative_path}            Set Variable                tests/../Data/PO.pdf
    ${file_patha}               Get File Path Based on Mode                             ${relative_path}
    Custom Upload File          ${file_patha}
    Choose File                 //input[@type="file"]


































