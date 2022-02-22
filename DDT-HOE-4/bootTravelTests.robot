*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Entering A Department
    [tags]                    travel.Department
    Appstate                  Home
    LaunchApp                 Travel App

    ClickUntil                Recently Viewed             Departments
    ClickUntil                New Department              New

    UseModal                  On
    TypeText                  Department Name              Jen Practice Department
    TypeText                  Department Code              D-042
    ClickText                 Save                        partial_match=False
    UseModal                  Off
    
    Sleep                     1

    ClickText                 Details
    VerifyText                Jen Practice Department    anchor=Information
    VerifyText                D-042    anchor=Information

#    Now, let's confirm that our Deparment Code is enforcing Unique by repeating our test with the same Dept Code

    ClickUntil                Recently Viewed             Departments    2
    ClickUntil                New Department              New

    UseModal                  On
    TypeText                  Department Name              Jen Practice Department
    TypeText                  Department Code              D-042
    ClickText                 Save                        partial_match=False

    IsAlert                   timeout=2s
    ClickText                 Cancel                      delay=3
    UseModal                  Off
