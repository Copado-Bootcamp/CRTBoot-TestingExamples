*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Case ***
Entering A Department
    [tags]                    travel.Departments
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
