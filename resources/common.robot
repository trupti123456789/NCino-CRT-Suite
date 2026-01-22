*** Settings ***
Library                         QForce
Library                         String
Suite Setup                     Open Browser                about:blank                 chrome

*** Variables ***
${BROWSER}                      chrome
${home_url}                     ${login_url}/lightning/page/home
${login_url}                    https://copadotestenvironmentv2--uat.sandbox.lightning.force.com/
${Username}                     satishr@copadoncinoenv2uat.com
${password}                     ncino@1234
${secret}                       EXPK7N6N4MKSBFCHF3MMN2F6BP6YHVCG


*** Keywords ***
Setup Browser   
   Set Library Search Order                          QForce    QWeb
    Open Browser                about:blank                 ${BROWSER}     prefs=download.prompt_for_download: False, plugins.always_open_pdf_externally: True
    SetConfig                   LineBreak                   ${EMPTY}                    #\ue000
    SetConfig                   DefaultTimeout              45s                         #sometimes salesforce is slow
    SetConfig                   Delay                       0.3
End suite
    Close All Browsers
Login
    [Documentation]             Login to Salesforce instance
    GoTo                        ${login_url}
    TypeText                    Username                    ${username}                 delay=1
    sleep                       2
    TypeText                    Password                    ${password}
    ClickText                   Log In
    ${mfa_code}=                GetOTP                      ${username}                 ${secret}
    TypeText                    Verification Code           ${mfa_code}
    ClickText                   Verify

Home
    [Documentation]             Navigate to homepage, login if needed
    GoTo                        ${home_url}
    ${login_status} =           IsText                      To access this page, you have to log in to Salesforce.           2
    Run Keyword If              ${login_status}             Login
    ClickText                   Home
    VerifyTitle                 Home | Salesforce

Wait
    [Documentation]             It will pause the test case for perticular secend
    Sleep                       10

Generate Unique Name
    [Arguments]                 ${base_name}
    ${ts}=                      Get Time                    epoch
    ${unique}=                  Catenate                    _                           ${base_name}                ${ts}
    [Return]                    ${unique}

Get File Path Based on Mode

    [Arguments]    ${uploadfilepath}
    ${contains}=    Evaluate    'execution' in '''${SUITE_SOURCE}'''
   IF    ${contains}
           ${File}=    Set Variable    /home/executor/execution/NCino-CRT-Suite/${uploadfilepath}
    ELSE
        ${File}=    Set Variable    /home/services/suite/${uploadfilepath}
    END
    RETURN   ${File}    
Change Stage
   ClickText                   Loans
    Clicktext                   Mark as Current Stage