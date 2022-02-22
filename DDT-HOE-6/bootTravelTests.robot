*** Settings ***
Resource                      ../resources/common.robot
Library                       DataDriver    reader_class=TestDataApi    name=Departments.csv
Suite Setup                   Setup Browser
Suite Teardown                End suite
Test Template                 Entering A Department

*** Test Cases ***
Entering A Department with ${Name} ${Department_Code__c}

*** Keywords ***
Entering A Department
    [Arguments]               ${Name}    ${Department_Code__c}
    Appstate                  Home
    LaunchApp                 Travel App
    VerifyText                Home

    ClickUntil                Recently Viewed             Departments
    ClickUntil                New Department              New

    ${deptRunId}              Generate Random String       4    [NUMBERS]
    UseModal                  On
    TypeText                  Department Name              ${Name}-${deptRunId}
    TypeText                  Department Code              ${Department_Code__c}
    ClickText                 Save                        partial_match=False
    UseModal                  Off
    
    Sleep                     1

    ClickText                 Details
    VerifyText                ${Name}-${deptRunId}    anchor=Information
    VerifyText                ${Department_Code__c}    anchor=Information
