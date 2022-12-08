*** Settings ***
Library                   QForce
Library                   String
Library                   DateTime


*** Keywords ***
Setup Browser
    Open Browser          about:blank                 ${Browser}
    SetConfig             LineBreak                   ${EMPTY}                    #\ue000
    SetConfig             DefaultTimeout              60s                         #sometimes salesforce sandboxes are really slow
    SetConfig             HighlightColor              orange                      # Salesforce is very blue, changing highlight color to orange provides contrast


End suite
    Close All Browsers


DynamicLogin
    [Documentation]       Login to Salesforce instance using Dynamic Logic
    ${DYNAMIC_LOGIN}=     Get Variable Value          ${loginUrl}                 NoValuePassed
    IF                    '${DYNAMIC_LOGIN}' == 'NoValuePassed'
        OpenBrowser       ${localLoginURL}            ${Browser}
        TypeText          Username                    ${localUsername}
        TypeText          Password                    ${localPassword}
        ClickText         Log In
    ELSE
        OpenBrowser       ${DYNAMIC_LOGIN}            ${Browser}
        TypeText          Username                    ${ORG_USERNAME}
        TypeText          Password                    ${ORG_PASSWORD}
        ClickText         Log In
    END


DynamicHome
    [Documentation]       Navigate to homepage of Service App, login if needed using Dynamic Logic
    ${DYNAMIC_LOGIN}=     Get Variable Value          ${loginUrl}                 NoValuePassed
    IF                    '${DYNAMIC_LOGIN}' == 'NoValuePassed'
        GoTo              ${localLoginURL}/lightning/page/home
        ${login_status} =                             IsText                      To access this page, you have to log in to Salesforce.    2
        Run Keyword If    ${login_status}             DynamicLogin
        Sleep             1
        LaunchApp         Service
        ClickText         Home
        VerifyTitle       Home | Salesforce
    ELSE
        GoTo              ${loginUrl}/lightning/page/home
        ${login_status} =                             IsText                      To access this page, you have to log in to Salesforce.    2
        Run Keyword If    ${login_status}             DynamicLogin
        Sleep             1
        LaunchApp         Service
        ClickText         Home
        VerifyTitle       Home | Salesforce
    END


RecordDelete
    [Documentation]       On a record, click the Delete button if visible, else select Show more actions to Delete
    ${deleteVisible}=     Run Keyword And Return Status                           VerifyText                  Delete
    IF                    '${deleteVisible}' == 'False'
        ClickText         Show more actions
        ClickText         Delete
    ELSE
        ClickText         Delete
    END
