*** Settings ***
Library                         QForce
Library                         String
Suite Setup                     Open Browser                about:blank                 chrome

*** Variables ***
${BROWSER}                      chrome
${home_url}                     ${login_url}/lightning/page/home
${login_url}                   https://copadotestenvironment--qa.sandbox.lightning.force.com/
${Username}                     satish.r@cloudfulcrum.com.copadoqa
${password}                     ncino@1234
${secret}                       QIKMG7VHQ4JJSWXRD7WULZHV23ZZFPDT


*** Keywords ***
Setup Browser   
    Set Library Search Order    QForce
    Open Browser                about:blank                 ${BROWSER}
    SetConfig                   LineBreak                   ${EMPTY}                    #\ue000
    SetConfig                   DefaultTimeout              45s                         #sometimes salesforce is slow
    SetConfig                   Delay                       0.3
End suite
    Close All Browsers
Login
    [Documentation]             Login to Salesforce instance
    GoTo                        ${login_url}
    TypeText                    Username                    ${username}                 delay=1
    TypeText                    Password                    ${password}
    ClickText                   Log In
    ${mfa_code}=                GetOTP                      ${username}                 ${secret}
    TypeText                    Verification Code           ${mfa_code}
    ClickText                   Verify

Home
    [Documentation]             Navigate to homepage, login if needed
    GoTo                        ${home_url}
    ${login_status} =           IsText                      To access this page, you have to log in to Salesforce.    2
    Run Keyword If              ${login_status}             Login
    ClickText                   Home
    VerifyTitle                 Home | Salesforce


    