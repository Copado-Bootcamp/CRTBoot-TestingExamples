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

    ClickText                 Departments Menu
    ClickText                 + New Department           recognition_mode=vision

    UseModal                  On
    TypeText                  Department Name             Jen Practice Department
    TypeText                  Department Code             D-042
    ClickText                 Save                        partial_match=False
    VerifyText                We hit a snag.              recognition_mode=vision
    VerifyText                duplicate value found:      recognition_mode=vision

    ClickText                 Cancel                      delay=3
    UseModal                  Off
