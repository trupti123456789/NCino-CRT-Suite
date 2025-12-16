*** Settings ***
Library                         QWeb
Library                         Collections
Library                         RequestsLibrary
Library                         JSONLibrary
Library                         OperatingSystem
Resource                        ../resources/common.robot
Resource                        ../resources/keyword.robot



*** Keywords ***
Data

    ${Json_obj}=                Evaluate                    open('${CURDIR}/../Data/Data.json').read()    json
    ${dataA}=                   Evaluate                    json.loads('''${Json_obj}''')       json

    # Extracting data for relationship object and logging the values
    ${data1}=                   Set Variable                ${dataA["data1Relationship"]}
    ${data2}=                   Set Variable                ${dataA["data2Relationship"]}
    ${data3}=                   Set Variable                ${dataA["data3Relationship"]}

    # Setting variables for relationship data
    ${RelationshipData}=        Create Dictionary
    ...                         Name=${data1["Relationship Name"]}
    ...                         Type=${data1["Type"]}
    ...                         Role=${data1["Role"]}
    ...                         Name1=${data2["Relationship Name"]}
    ...                         Type1=${data2["Type"]}
    ...                         Role1=${data2["Role"]}
    ...                         Name2=${data3["Relationship Name"]}
    ...                         Type2=${data3["Type"]}

    [Return]                    ${RelationshipData}

 Adding Relationships
    [Arguments]                 ${Data}
    Relationships
    # Add a new household relationship
    ClickText                   New                         anchor=Import
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
    ClickText                   New                         anchor=Import
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
    ClickText                   New                         anchor=Import
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
    TypeText                    Connected Relationship      ${Household_User_name}
    Drop Down                   Role                        ${RelationshipData["Role"]}
    ClickText                   Save
    Run Keyword                 Wait

    # Create a connection for the business relationship
    ClickText                   Connections
    Use Modal                   On
    ClickText                   New
    Use Table                   Connected Relationship
    ClickCell                   r1c1
    TypeText                    Connected Relationship      ${Business_User_name}
    Drop Down                   Role                        ${RelationshipData["Role"]}
    ClickText                   Save

    # Create a connection for the individual relationship
    ClickText                   Relationships
    ClickText                   ${Business_User_name}
    ClickText                   Connections
    Use Modal                   On
    ClickText                   New
    Use Table                   Connected Relationship
    ClickCell                   r1c1
    TypeText                    Connected Relationship      ${Business_User_name}
    Drop Down                   Role                        ${RelationshipData["Role1"]}
    ClickText                   Save

    # Verify the relationship tree for household
    ClickText                   Relationships
    ClickText                   ${Household_User_name}
    ClickText                   Exposure
    VerifyText                  Connection Tree

    # Verify the relationship tree for business
    ClickText                   Relationships
    ClickText                   ${Household_User_name}
    ClickText                   Exposure
    VerifyText                  Connection Tree


