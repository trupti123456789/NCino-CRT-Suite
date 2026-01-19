*** Settings ***
Library                         QForce
Library                         Collections
Library                         RequestsLibrary
Library                         JSONLibrary
Library                         OperatingSystem
Resource                        ../resources/common.robot




*** Keywords ***
Data

    ${Json_obj}=                Evaluate                    open('${CURDIR}/../Data/Data.json').read()         json
    ${dataA}=                   Evaluate                    json.loads('''${Json_obj}''')                      json

    # Extracting data for relationship object and logging the values
    ${data1}=                   Set Variable                ${dataA["data1Relationship"]}
    ${data2}=                   Set Variable                ${dataA["data2Relationship"]}
    ${data3}=                   Set Variable                ${dataA["data3Relationship"]}
    ${data4}=                   Set Variable                ${dataA["DirectDebt"]}
    ${data5}=                   Set Variable                ${dataA["IndirectDebt"]}
    ${data6}=                   Set Variable                ${dataA["Loan"]}
    ${data7}=                   Set Variable                ${dataA["LoanData"]}
    ${data8}=                   Set Variable                ${dataA["EntityInvolvement"]}
    ${data9}=                   Set Variable                ${dataA["Collateral"]}
    ${data10}=                  Set Variable                ${dataA["Fee"]}
    ${data11}=                  Set Variable                ${dataA["RiskRating"]}
    ${data12}=                  Set Variable                ${dataA["Covenant"]}

    # Setting variables for relationship data
    ${RelationshipData}=        Create Dictionary
    ...                         Name=${data1["Relationship Name"]}
    ...                         Type0=${data1["Type"]}
    ...                         Role=${data1["Role"]}
    ...                         Name1=${data2["Relationship Name"]}
    ...                         Type1=${data2["Type"]}
    ...                         Role1=${data2["Role"]}
    ...                         Contact=${data2["Contact"]}
    ...                         Name2=${data3["Relationship Name"]}
    ...                         Type2=${data3["Type"]}
    ...                         DebtName1=${data4["Debt Name"]}
    ...                         value1=${data4["Principal Balance"]}
    ...                         DebtName2=${data5["Debt Name"]}
    ...                         value2=${data5["Principal Balance"]}

    ...                         Product_Line=${data6["Product Line"]}
    ...                         Product_Type=${data6["Product Type"]}
    ...                         Product=${data6["Product"]}
    ...                         Borrower_Type=${data6["Borrower Type"]}
    ...                         Loan_Amount=${data6["Loan Amount"]}
    ...                         Loan_Purpose=${data6["Loan Purpose"]}

    ...                         Loan_Number=${data7["Loan Number"]}
    ...                         Primary_Loan_Purpose=${data7["Primary Loan Purpose"]}
    ...                         Application_Method=${data7["Application Method"]}
    ...                         Method_of_Doc_Prep=${data7["Method of Doc Prep"]}
    ...                         Prepayment_Penalty_Description=${data7["Prepayment Penalty Description"]}
    ...                         Secondary_Source_of_Repayment=${data7["Secondary Source of Repayment"]}
    ...                         Primary_Source_of_Repayment=${data7["Primary Source of Repayment"]}
    ...                         Tertiary_Source_of_Repayment=${data7["Tertiary Source of Repayment"]}
    ...                         Loan_Amount=${data7["Loan Amount"]}
    ...                         User=${data7["User"]}
    ...                         Role=${data7["Role"]}

    ...                         Borrower_Type=${data8["Borrower Type"]}
    ...                         Contingent_Type=${data8["Contingent Type"]}
    ...                         Contingent_Amount=${data8["Contingent Amount"]}

    ...                         Type=${data9["Type"]}
    ...                         Subtype=${data9["Subtype"]}
    ...                         Value=${data9["Value"]}
    ...                         Collateral_Name=${data9["Collateral Name"]}
    ...                         City=${data9["City"]}
    ...                         Description=${data9["Description"]}

    ...                         Fee_Type=${data10["Fee Type"]}
    ...                         Calculation_Type=${data10["Calculation Type"]}
    ...                         Percentage=${data10["Percentage"]}
    ...                         Fee_Paid_By=${data10["Fee Paid By"]}
    ...                         Basis_Source=${data10["Basis Source"]}
    ...                         Amount=${data10["Amount"]}
    ...                         Collection_Method=${data10["Collection Method"]}

    ...                         templates-list=${data11["templates-list"]}

    ...                         Category=${data12["Category"]}
    ...                         Covenant_Type=${data12["Covenant Type"]}
    ...                         Effective_Date=${data12["Effective Date"]}
    ...                         Frequency_Template=${data12["Frequency Template"]}
    ...                         Grace_Days=${data12["Grace Days"]}

    [Return]                    ${RelationshipData}


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

Add Entity Involvement in Loan  
    [Arguments]                 ${RelationshipData}
    ClickText                   Add Entity Involvement
    UseModal                    On
    ClickCheckbox               Select ${Household_User_name}                           on                     partial_match=false
    ClickCheckbox               Select all                  on
    Run Keyword                 Wait
    ClickText                   Add Selected Relationships
     UseModal                    On
    DropDown                    Borrower Type               ${RelationshipData["Borrower_Type"]}
    DropDown                    Contingent Type             ${RelationshipData["Contingent_Type"]}
    ClickText                   *Contingent Amount 
    TypeText                    *Contingent Amount          ${RelationshipData["Contingent_Amount"]}           delay=5
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
    DropDown                    accounts-list               ${Business_User_name} - Corporation                partial_match=False
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
    ClickText                   ${RelationshipData["Category"]}
    ClickText                   *Effective Date
    ClickText                   Today
    ClickText                   *Covenant Type
    ClickText                   ${RelationshipData["Covenant_Type"]}
    ClickText                   *Frequency Template
    ClickText                   ${RelationshipData["Frequency_Template"]}
    TypeText                    Grace Days                  ${RelationshipData["Grace_Days"]}
    ClickText                   Create                      partial_match=False
Verify Covenant in loan
    [Arguments]                 ${RelationshipData}
    Clicktext                   Covenants
    ClickElement                xpath=//button[contains(@title,'COV-')]
    VerifyAll                   Category,Covenant Type
    Verifytext                  ${RelationshipData["Category"]}
    Verifytext                  ${RelationshipData["Covenant_Type"]}                    anchor=Category























