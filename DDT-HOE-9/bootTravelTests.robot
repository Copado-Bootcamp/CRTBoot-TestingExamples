*** Settings ***
Resource                      ../resources/common.robot
Library                       DataDriver    reader_class=TestDataApi    name=Travel_Approvals.csv
Suite Setup                   Setup Browser
Suite Teardown                End suite
Test Template                 Entering A Travel Approval

*** Test Case ***
Entering A Travel Approval with ${External_Id__c} ${Status__c} ${Purpose_of_Trip__c} ${Trip_Start_Date__c} ${Trip_End_Date__c} ${Destination_State__c} ${Department__c}

*** Keywords ***
Entering A Travel Approval
    [Arguments]    ${External_Id__c}    ${Status__c}    ${Purpose_of_Trip__c}    ${Trip_Start_Date__c}    ${Trip_End_Date__c}    ${Destination_State__c}    ${Department__c}
    Appstate                  Home
    LaunchApp                 Travel App

    ClickUntil                Recently Viewed             Travel Approvals
    ClickUntil                New Travel Approval              New

    UseModal                  On
    PickList                  Status                        ${Status__c}
    ClickText                 Department
    TypeText                  Search Departments...     ${Department__c}    Search Departments...
    ClickText                 ${Department__c}          2                   delay=5
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
    VerifyText                Trip Info
    VerifyText                System Fields
