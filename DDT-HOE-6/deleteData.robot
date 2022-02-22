*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Delete All Departments
    [Documentation]    Rather than going through one-by-one to delete, going to use Dev Console
    [Tags]             delete.Departments
    Appstate                  Home
    LaunchApp                 Travel App

    ClickUntil                Recently Viewed             Departments
    VerifyText                16 items
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
    VerifyText                0 items
