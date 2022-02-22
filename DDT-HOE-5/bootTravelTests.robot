*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Case ***
Entering A Department
    [tags]                    travel.Departments
    Appstate                  Login
    LaunchApp                 Travel App
    VerifyText                Home

    ClickUntil                Recently Viewed             Departments
    ClickUntil                New Department              New

    UseModal                  On
    TypeText                  Department Name              ${Name}
    TypeText                  Department Code              ${Department_Code__c}
    ClickText                 Save                        partial_match=False
    UseModal                  Off
    
    Sleep                     1

    ClickText                 Details
    VerifyText                ${Name}                  anchor=Information
    VerifyText                ${Department_Code__c}    anchor=Information
