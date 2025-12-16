*** Settings ***
Library                Collections
Library                RequestsLibrary
Library                JSONLibrary
Library                OperatingSystem
Resource               ../resources/common.robot
Resource               ../resources/keyword.robot



*** Keywords ***


Data

    ${Json_obj}=       Evaluate                    open('${CURDIR}/../Data/Data.json').read()    json
    ${dataA}=          Evaluate                    json.loads('''${Json_obj}''')       json

    # Extracting data for relationship object and logging the values
    ${data1}=          Set Variable                ${dataA["data1Relationship"]}
    Log                ${data1}
    ${data2}=          Set Variable                ${dataA["data2Relationship"]}
    Log                ${data2}
    ${data3}=          Set Variable                ${dataA["data3Relationship"]}
    Log                ${data3}

    # Setting variables for relationship data
    ${Name}=           Set Variable                ${data1["Relationship Name"]}
    ${Type}=           Set Variable                ${data1["Type"]}
    ${Role}=           Set Variable                ${data1["Role"]}
    ${Name1}=          Set Variable                ${data2["Relationship Name"]}
    ${Type1}=          Set Variable                ${data2["Type"]}
    ${Role1}=          Set Variable                ${data2["Role"]}
    ${Name2}=          Set Variable                ${data3["Relationship Name"]}
    ${Type2}=          Set Variable                ${data3["Type"]}




#  Adding Relationships
#     Relationships
#     # Add a new household relationship
#     ClickText          New                         anchor=Import
#     Use Modal          On
#     ClickText          Household
#     ClickText          Next
#     TypeText           Relationship Name           ${Name}
#     Picklist           Type                        ${Type}
#     ClickText          Save                        partial_match=False
#     Run Keyword        Wait

#     # Add a new business relationship
#     ClickText          Relationships               partial_match=False
#     ClickText          New                         anchor=Import
#     Run Keyword        Wait
#     Use Modal          On
#     ClickText          Business
#     Run Keyword        Wait
#     ClickText          Next
#     TypeText           Relationship Name           ${Name1}
#     Picklist           Type                        ${Type1}
#     ClickText          Save                        partial_match=False

#     # Add a new individual relationship
#     ClickText          Relationships
#     ClickText          New                         anchor=Import
#     Run Keyword        Wait
#     Use Modal          On
#     ClickText          Individual
#     Run Keyword        Wait
#     ClickText          Next
#     TypeText           Relationship Name           ${Name2}
#     Picklist           Type                        ${Type2}
#     ClickText          Save                        partial_match=False

#     # Create a connection for the household relationship
#     ClickText          Relationships
#     ClickText          ${Name}
#     ClickText          Related
#     ClickText          Connections
#     Use Modal          On
#     ClickText          New
#     Use Table          Connected Relationship
#     ClickCell          r1c1
#     TypeText           Connected Relationship      ${Name1}
#     Drop Down          Role                        ${Role}
#     ClickText          Save
#     Run Keyword        Wait

#     # Create a connection for the business relationship
#     ClickText          Related
#    #  ClickText          Connections
#    #  Use Modal          On
#    #  ClickText          New
#    #  Use Table          Connected Relationship
#    #  ClickCell          r1c1
#    #  TypeText           Connected Relationship      ${Name2}
#    #  Drop Down          Role                        ${Role}
#    #  ClickText          Save

#    #  # Create a connection for the individual relationship
#     ClickText          Relationships
#     ClickText          ${Name2}
#     ClickText          Related
#     ClickText          Connections
#     Use Modal          On
#     ClickText          New
#     Use Table          Connected Relationship
#     ClickCell          r1c1
#     TypeText           Connected Relationship      ${Name2}
#     Drop Down          Role                        ${Role1}
#     ClickText          Save

#     # Verify the relationship tree for household
#     ClickText          Relationships
#     ClickText          ${Name}
#     ClickText          Exposure
#     VerifyText         Connection Tree

#     # Verify the relationship tree for business
#     ClickText          Relationships
#     ClickText          ${Name1}
#     ClickText          Exposure
#     VerifyText         Connection Tree


 