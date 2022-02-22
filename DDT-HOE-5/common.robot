*** Settings ***
Library                   QWeb
Library                   QForce
Library                   String
Library                   DateTime


*** Variables ***
${username}               jnelson@crtbootcamp1.com
${login_url}              https://login.salesforce.com/            # Salesforce instance. NOTE: Should be overwritten in CRT variables
${my_domain_url}          https://copado-6a.lightning.force.com/    # Salesforce instance. NOTE: Should be overwritten in CRT variables
${home_url}               ${my_domain_url}/lightning/page/home
${deptRunId}


*** Keywords ***
Setup Browser
    Open Browser          about:blank                 ${BROWSER}
    SetConfig             LineBreak                   ${EMPTY}               #\ue000
    SetConfig             DefaultTimeout              20s                    #sometimes salesforce is slow


End suite
    Close All Browsers


Login
    [Documentation]       Login to Salesforce instance
    GoTo                  ${login_url}
    TypeText              Username                    ${username}             delay=1
    TypeText              Password                    ${password}
    ClickText             Log In


Home
    [Documentation]       Navigate to homepage, login if needed
    GoTo                  ${home_url}
    ${login_status} =     IsText                      To access this page, you have to log in to Salesforce.    2
    Run Keyword If        ${login_status}             Login
    ClickText             Home
    VerifyTitle           Home | Salesforce


NoData
    VerifyNoText          ${data}                     timeout=3                        delay=2
