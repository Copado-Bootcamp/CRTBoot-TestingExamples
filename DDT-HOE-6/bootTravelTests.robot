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
    VerifyText                Departments
    ClickText                 Departments Menu           delay=3
    ClickText                 New Department    recognition_mode=vision

    UseModal                  On
    TypeText                  Department Name              ${Name}
    TypeText                  Department Code              ${Department_Code__c}
    ClickText                 Save                        partial_match=False
    UseModal                  Off
    
    Sleep                     1

    ClickText                 Details
    VerifyText                ${Name}                  anchor=Information
    VerifyText                ${Department_Code__c}    anchor=Information
