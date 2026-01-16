*** Settings ***
Library                         QForce
Library                         Collections
Library                         RequestsLibrary
Library                         JSONLibrary
Library                         OperatingSystem
Resource                        ../resources/common.robot
Resource                        ../resources/keyword.robot



*** Keywords ***
Data

    ${Json_obj}=                Evaluate                    open('${CURDIR}/../Data/Data.json').read()         json
    ${dataA}=                   Evaluate                    json.loads('''${Json_obj}''')                      json

    # Extracting data for relationship object and logging the values
    ${data1}=                   Set Variable                ${dataA["data1Relationship"]}
    ${data2}=                   Set Variable                ${dataA["data2Relationship"]}
    ${data3}=                   Set Variable                ${dataA["data3Relationship"]}
    ${data4}=                   Set Variable                ${dataA["data1DirectDebt"]}
    ${data5}=                   Set Variable                ${dataA["data2IndirectDebt"]}
    ${data6}=                   Set Variable                ${dataA["data1Loan"]}
    ${data7}=                   Set Variable                ${dataA["data2LoanData"]}
    ${data8}=                   Set Variable                ${dataA["data1EntityInvolvement"]}
    ${data9}=                   Set Variable                ${dataA["data1Collateral"]}
    ${data10}=                  Set Variable                ${dataA["data1Fee"]}

    # Setting variables for relationship data
    ${RelationshipData}=        Create Dictionary
    ...                         Name=${data1["Relationship Name"]}
    ...                         Type=${data1["Type"]}
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
    ...                         Loan_Assistant=${data7["Loan Assistant"]}

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
    TypeText                    Relationship Name           ${Household_User_name}
    Picklist                    Type                        ${RelationshipData["Type"]}
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
    TypeText                    Relationship Name           ${Individual_User_name}
    Picklist                    Type                        ${RelationshipData["Type2"]}
    ClickText                   Save                        partial_match=False

    # Create a connection for the household relationship
    ClickText                   Relationships
    ClickText                   ${Household_User_name}
    ClickText                   Connections
    Use Modal                   On
    ClickText                   New
    Use Table                   Connected Relationship
    ClickCell                   r1c1
    TypeText                    Connected Relationship      ${Business_User_name}
    Clicktext                   Role
    Drop Down                   Role                        ${RelationshipData["Role"]}
    ClickText                   Save
    Run Keyword                 Wait

    #                           # Create a connection for the business relationship
    #                           ClickText                   Connections
    #                           Use Modal                   On
    #                           ClickText                   New
    #                           Use Table                   Connected Relationship
    #                           ClickCell                   r1c1
    #                           TypeText                    Connected Relationship      ${Business_User_name}
    #                           Drop Down                   Role                        ${RelationshipData["Role"]}
    #                           ClickText                   Save

    # Create a connection for the individual relationship
    #                           ClickText                   Relationships
    #                           ClickText                   ${Business_User_name}
    #                           ClickText                   Connections
    #                           Use Modal                   On
    #                           ClickText                   New
    #                           Use Table                   Connected Relationship
    #                           ClickCell                   r1c1
    #                           TypeText                    Connected Relationship      ${Business_User_name}
    #                           Clicktext                   Role
    #                           Drop Down                   Role                        ${RelationshipData["Role1"]}
    #                           ClickText                   Save

    # Verify the Exposer abd create the                     debts
    ClickText                   Relationships
    ClickText                   ${Household_User_name}
    ClickText                   Exposure
    ClickText                   Add Direct Debt
    TypeText                    Debt Name                   ${RelationshipData["DebtName1"]}
    TypeText                    Principal Balance           ${RelationshipData["value1"]}
    ClickText                   Save
    ClickText                   Add Indirect Debt
    TypeText                    Debt Name                   ${RelationshipData["DebtName2"]}
    TypeText                    Principal Balance           ${RelationshipData["value2"]}
    ClickText                   Save
    RefreshPage
    VerifyText                  ${Household_User_name}
    ClickText                   Recalculate Exposure
    VerifyText                  Total Exposure Summary

    #Create a Contact for Bussiness Account
    ClickText                   Relationships
    ClickText                   ${Business_User_name}
    ClickText                   Contacts                    anchor=Credit Actions
    ClickText                   New                         anchor=Refresh
    UseModal                    ON
    PickList                    Salutation                  Mr.
    TypeText                    Last Name                   ${RelationshipData["Contact"]}
    ClickCheckbox               Primary Contact             on
    ClickText                   Save                        partial_match=False

    #Verifying contact creation
    ClickText                   ${RelationshipData["Contact"]}
    VerifyField                 Name                        Mr.${RelationshipData["Contact"]}
    VerifyField                 Relationship Name           ${Business_User_name}
    VerifyCheckbox              Primary Contact             on

    #Create a Product package for Business Account
    ClickText                   Relationships
    ClickText                   ${Business_User_name}
    Clicktext                   New Product Package         anchor=Edit
    ClickText                   Save
    ClickText                   Cancel
    ClickText                   Product Package Details
    VerifyField                 Relationship                ${Business_User_name}
    ClickText                   Edit: Description
    TypeText                    Description                 Test
    ClickText                   Save

    #Create a new Loan
    ClickText                   Loan Facilities
    ClickText                   Magic Wand: Tools and Actions
    ClickText                   New Facility
    VerifyText                  Add New Loan
    DropDown                    Product Line                 ${RelationshipData["Product_Line"]}
    DropDown                    Product Type                 ${RelationshipData["Product_Type"]}
    #ComboBox                   Choose Product              Term Loan
    DropDown                    * Product                    ${RelationshipData["Product"]}
    DropDown                    Borrower Type               ${RelationshipData["Borrower_Type"]}
    TypeText                    Loan Amount                  ${RelationshipData["Loan_Amount"]}
    TypeText                    Loan Purpose                ${RelationshipData["Loan_Purpose"]}
    ClickText                   Create New Loan
    Sleep                       5
    ClickText                   Loan Information
    VerifyText                  Loan Details


    TypeText                    Loan Number                ${RelationshipData["Loan_Number"]}
    ClickText                   --None--                    anchor=Primary Loan Purpose
    ClickText                   Business Start-Up
    ClickText                   nCino HQ
    ClickText                   --None--                    anchor=Application Method
    ClickText                   In-person
    ClickText                   --None--                    anchor=Method of Doc Prep
    ClickText                   Attorney Prepared
    ClickCheckbox               Is Participation            on
    TypeText                    Prepayment Penalty Description                          Test in progress
    ClickText                   --None--                    anchor=Secondary Source of Repayment
    ClickText                   Cash flow from Operations
    ClickText                   --None--                    anchor=Primary Source of Repayment
    ClickText                   Lease Income
    ClickText                   --None--                    anchor=Tertiary Source of Repayment
    ClickText                   Cash flow from Operations
    ClickText                   Loan Structuring
    ClickText                   Save
    ClickText                   Loan Structuring
    ClickText                   Continue
    ClickText                   Add New
    ClickText                   Loan Assistant
    ClickText                   Satish R
    ClickText                   Save                        partial_match=False
    ClickText                   Continue
    sleep                       10


    ClickText                   Add Entity Involvement
    ClickCheckbox               Select _  ${Household_User_name}                on                     partial_match=False
    ClickText                   Add Selected Relationships
    DropDown                    Borrower Type              ${RelationshipData["Borrower_Type"]}
    DropDown                    Contingent Type            ${RelationshipData["Contingent_Type"]}
    TypeText                    Contingent Amount          ${RelationshipData["Contingent_Amount"]}
    ClickText                   Save Entity Involvement
    ClickText                   Continue
    ClickText                   Add Collateral
    ClickText                   Add New Collateral
    ClickItem                   Select
    ClickText                   Next                        parent=LIGHTNING-BUTTON
    ClickText                   Next
    ClickText                   *Type
    ClickText                   Real Estate
    ClickText                   *Subtype
    ClickText                   1-4 Family
    TypeText                    Value                       100
    TypeText                    Collateral Name             TestCollateral
    TypeText                    City                        USA
    TypeText                    Description                 Loan for test
    ClickText                   Save & Next
    ClickText                   Save Pledged Collateral
    ClickCheckbox               Select Item 1               on                          partial_match=False
    ClickText                   Continue


    ClickText                   Back
    ClickText                   Add Non-Standard Fee
    DropDown                    Fee Type                    Appraisal
    DropDown                    Calculation Type            Percentage
    TypeText                    Percentage                  79
    DropDown                    Fee Paid By                 Bank Paid
    DropDown                    Basis Source                Loan Amount
    TypeText                    Amount                      7900000
    DropDown                    Collection Method           Financed
    ClickText                   Save
    ClickText                   Continue


    DropDown                    accounts-list               _ Facebook 1768223476 - Corporation
    DropDown                    templates-list              Commercial & Industrial
    ClickText                   Save
    ClickText                   Calculate and Save
    ClickText                   Calculate and Save
    ClickText                   Risk Rating Worksheet
    ClickText                   Related
    ClickText                   Loans
    ClickText                   _ Facebook 1768223476 - Term Loan - $60,000,000.00      parent=DIV
    ClickText                   Fees
    ClickText                   Loan Information
    ClickText                   Show/Hide Navigation Sidebar
    ClickText                   Show/Hide Navigation Sidebar
    ClickText                   Loan Structuring

    #














