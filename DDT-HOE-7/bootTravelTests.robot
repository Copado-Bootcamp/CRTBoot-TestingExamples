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
    ClickText                 New Travel Approval          recognition_mode=vision

    UseModal                  On
    VerifyText                New Travel Approval
    PickList                  Status                          New
    ClickText                 Department
    TypeText                  Search Departments...           Division of Family    Search Departments...
    ClickText                 Division of Family Resources    recognition_mode=vision
    TypeText                  Purpose of Trip                 Business Development
    TypeText                  Destination State               TX
    ${current_date}=          Get Current Date                result_format=%m/%d/%Y
    ${plus15_date}=           Add Time To Date                ${current_date}         15 days          date_format=%m/%d/%Y    result_format=%m/%d/%Y
    ${plus22_date}=           Add Time To Date                ${current_date}         22 days          date_format=%m/%d/%Y    result_format=%m/%d/%Y
    TypeText                  Trip Start Date                 ${plus15_date}
    TypeText                  Trip End Date                   ${plus22_date}
    TypeText                  External Id                     CRT-999
    ClickText                 Save                            partial_match=False
    UseModal                  Off
    
    Sleep                     1

    VerifyText                Travel Approval - General Details
    VerifyText                Division of Family Resources
    VerifyText                Trip Info
    VerifyText                System Fields


#    Now, let's confirm that our External Id is enforcing Unique by repeating our test with the same External Id

    ClickText                 Travel Approvals Menu
    ClickText                 New Travel Approval          recognition_mode=vision

    UseModal                  On
    VerifyText                New Travel Approval
    PickList                  Status                        New
    ClickText                 Department
    TypeText                  Search Departments...           Division of Family    Search Departments...
    ClickText                 Division of Family Resources    recognition_mode=vision
    TypeText                  Purpose of Trip               Business Development
    TypeText                  Destination State             TX
    TypeText                  Trip Start Date               ${plus15_date}
    TypeText                  Trip End Date                 ${plus22_date}
    TypeText                  External Id                   CRT-999
    ClickText                 Save                          partial_match=False
    VerifyText                We hit a snag.              recognition_mode=vision
    VerifyText                duplicate value found:      recognition_mode=vision

    ClickText                 Cancel                      delay=3
    UseModal                  Off
    
    Sleep                     1

#    Now, let's confirm that our Status Indicator is updating as expected for Approved

    VerifyText                Travel Approval - General Details
    VerifyText                Division of Family Resources
    VerifyText                Trip Info
    VerifyText                System Fields

    ClickText                 Edit                          2
    UseModal                  On
    VerifyText                Edit TA-    
    PickList                  Status                        Approved
    ClickText                 Save                          partial_match=False
    UseModal                  Off
    
    Sleep                     1

#   Let's also make sure the Status Indicator is updating as expected for Rejected

    ClickText                 Edit                          2
    UseModal                  On
    VerifyText                Edit TA-    
    PickList                  Status                        Rejected
    ClickText                 Save                          partial_match=False
    UseModal                  Off
    
    Sleep                     1    

#   Let's not forget to test the Out-of-State checkbox - first any state except TX

    ClickText                 Edit                          2
    UseModal                  On
    VerifyText                Edit TA-    
    TypeText                  Destination State             IL
    ClickText                 Save                          partial_match=False
    UseModal                  Off
    
    Sleep                     1

#   Set it back to TX and test again

    ClickText                 Edit                          2
    UseModal                  On
    VerifyText                Edit TA-    
    TypeText                  Destination State             TX
    ClickText                 Save                          partial_match=False
    UseModal                  Off
    
    Sleep                     1

#   While we are testing the State don't forget our validation rule for uppercase

    ClickText                 Edit                          2
    UseModal                  On
    VerifyText                Edit TA-    
    TypeText                  Destination State             il
    ClickText                 Save                          partial_match=False
    VerifyText                Destination State must be entered in UPPERCASE
    TypeText                  Destination State             IL
    ClickText                 Save                          partial_match=False
    UseModal                  Off
    
    Sleep                     1

#   Finally, don't forget our validation rule that Trip Start must be before Trip End

    ClickText                 Edit                          2
    UseModal                  On
    VerifyText                Edit TA-    
    TypeText                  Trip Start Date               ${plus22_date}
    TypeText                  Trip End Date                 ${plus15_date}
    ClickText                 Save                          partial_match=False
    VerifyText                Trip end date must be greater than or equal to start date
    TypeText                  Trip Start Date               ${plus15_date}
    TypeText                  Trip End Date                 ${plus22_date}
    ClickText                 Save                          partial_match=False
    UseModal                  Off
    
    Sleep                     1
