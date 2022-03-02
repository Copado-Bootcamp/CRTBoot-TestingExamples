*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Entering A Travel Approval
    [tags]                    travel.TravelApproval
    Appstate                  Home
    LaunchApp                 Travel App

    VerifyText                Travel Approvals
    ClickText                 Travel Approvals Menu
    ClickText                 New Travel Approval          recognition_mode=vision    delay=3

    UseModal                  On
    VerifyText                New Travel Approval    
    PickList                  Status                        ${Status__c}
    ClickText                 Department
    TypeText                  Search Departments...     ${Department__c}    Search Departments...
    Sleep                     1

    ${dept_name}=             IsText                    ${Department__c}    anchor=2    recognition_mode=vision

    Run Keyword If            ${dept_name}              Short Department Name    ELSE    Long Department Name

    TypeText                  Purpose of Trip           ${Purpose_of_Trip__c}
    TypeText                  Destination State         ${Destination_State__c}
    ${current_date}=          Get Current Date            result_format=%m/%d/%Y
    ${plus15_date}=           Add Time To Date            ${current_date}         ${Trip_Start_Date__c} days          date_format=%m/%d/%Y    result_format=%m/%d/%Y
    ${plus22_date}=           Add Time To Date            ${current_date}         ${Trip_End_Date__c} days          date_format=%m/%d/%Y    result_format=%m/%d/%Y
    TypeText                  Trip Start Date             ${plus15_date}
    TypeText                  Trip End Date               ${plus22_date}
    TypeText                  External Id                 ${External_Id__c}
    ClickText                 Save                        partial_match=False
    UseModal                  Off
    
    Sleep                     1

    VerifyText                Travel Approval - General Details
    VerifyText                ${Department__c}    
    VerifyText                Trip Info
    VerifyText                System Fields

*** Keywords ***
Short Department Name
    ClickText                 ${Department__c}    3    recognition_mode=vision

Long Department Name
    ClickText                 ${Department__c}    2    recognition_mode=vision
