*** Settings ***
Library                         QForce
Library                         QWeb
Resource                        ../resources/common.robot
Resource                        ../resources/keyword.robot
Resource                        ../resources/Keyword2.robot
Suite Setup                     Setup Browser
Suite Teardown                  End Suite

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
    ...                         Matutitydate1=${data4["Matutitydate"]}
    ...                         DebtName2=${data5["Debt Name"]}
    ...                         value2=${data5["Principal Balance"]}
    ...                         Matutitydate2=${data5["Matutitydate"]}

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
    TypeText                    Maturity Date               ${RelationshipData["Matutitydate1"]}
    ClickText                   Save
    ClickText                   Add Indirect Debt
    TypeText                    Debt Name                   ${RelationshipData["DebtName2"]}
    TypeText                    Principal Balance           ${RelationshipData["value2"]}
    TypeText                    Maturity Date               ${RelationshipData["Matutitydate2"]}
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






