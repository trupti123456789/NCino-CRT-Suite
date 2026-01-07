*** Settings ***
Library                 QForce
Library                 String
Resource                common.robot
Suite Setup             Open Browser     about:blank    chrome

*** Keywords ***


Loans
    [Documentation]             Custom appstate to go directly to nCino / Relationships
    Home
    LaunchApp                   nCino LOS
    VerifyText                  Welcome to nCino
    ClickText                   Loans
    VerifyPageHeader            Loans

Verify nCino Value
    [Documentation]             Verifies values from nCino views based on label
    [Arguments]                 ${label}                    ${value}
    # handles two different custom components
    ${text}=                    GetText                     //label[text()\="${label}"]/ancestor::nc-field-label-template/following-sibling::nc-read-only-field-template|//label[text()\="${label}"]/ancestor::nds-label/following-sibling::div
    Should Be Equal As Strings                              ${text}                     ${value}

nCino Dropdown
    [Documentation]             Selects a value from nCino custom "dropdown"
    [Arguments]                 ${label}                    ${value}
    VerifyText                  ${label}
    ${id}=                      GetAttribute                //nds-label/label[text()\="${label}"]                   for
    ClickElement                //*[@id\="${id}" and @role\="combobox"]
    ClickText                   ${value}                    anchor=${label}

    # Example of custom keyword with robot fw syntax
VerifyStage
    [Documentation]             Verifies that stage given in ${text} is at ${selected} state; either selected (true) or not selected (false)
    [Arguments]                 ${text}                     ${selected}=true
    VerifyElement               //a[@title\="${text}" and @aria-checked\="${selected}"]


DeleteRelationship
    [Documentation]             RunBlock to remove all data until it doesn't exist anymore
    ClickText                   Show Actions                
    ClickText                   Delete
    VerifyText                  Are you sure you want to delete this relationship?
    ClickText                   Delete                      anchor=Cancel
    VerifyText                  Undo
    VerifyNoText                Undo
    ClickText                   Relationships               partial_match=False
# Generate Unique Name
#     [Arguments]    ${base_name}
#     ${ts}=    Get Time    epoch
#     ${unique}=     Catenate    _    ${base_name}    ${ts}
#     [Return]    ${unique}     