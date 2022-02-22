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

    ${deptRunId}              Generate Random String       4    [NUMBERS]
    UseModal                  On
    TypeText                  Department Name              Jen Practice Department-${deptRunId}
    TypeText                  Department Code              D-042
    ClickText                 Save                        partial_match=False
    UseModal                  Off
    
    Sleep                     1

    ClickText                 Details
    VerifyText                Jen Practice Department-${deptRunId}    anchor=Information
    VerifyText                D-042    anchor=Information

#    Now, let's confirm that our Deparment Code is enforcing Unique by repeating our test with the same Dept Code

    ClickUntil                Recently Viewed             Departments    2
    ClickUntil                New Department              New

    ${deptRunId}              Generate Random String       4    [NUMBERS]
    UseModal                  On
    TypeText                  Department Name              Jen Practice Department-${deptRunId}
    TypeText                  Department Code              D-042
    ClickText                 Save                        partial_match=False

    IsAlert                   timeout=2s
    TypeText                  Department Code              D-043
    ClickText                 Save                        partial_match=False
    UseModal                  Off

Delete All Departments
    [Documentation]    Rather than going through one-by-one to delete, going to use Dev Console
    [Tags]             delete.Departments
    Appstate                  Home
    LaunchApp                 Travel App

    ClickUntil                Recently Viewed             Departments
    GetTextCount              Jen Practice Department
    ClickText                 Setup
    ClickText                 Developer Console
    SwitchWindow              NEW    # Switches to latest opened tab                     
    ClickText                 File
    ClickText                 Close All
    ClickText                 Debug
    ClickText                 Open Execute Anonymous Window
    TypeText                  //*[@id\='panel-1183-body']/div[1]/div[1]/textarea[1]    delete [SELECT Id FROM Department__c LIMIT 10000];
    ClickText                 Execute
    CloseWindow
    Appstate                  Home
    ClickUntil                Recently Viewed             Departments
    VerifyNoText              Jen Practice Department
