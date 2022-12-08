*** Settings ***
Resource                 ../resources/common.robot
Suite Setup              Setup Browser
Suite Teardown           End suite
Test Setup               Appstate                    DynamicHome                 # as Test Cases grow in complexity it is important to reset the system each time
Test Teardown            RefreshPage

*** Test Cases ***
Close an Opportunity from Its Path

    ClickText            Opportunities
    ClickText            Jen Test 4
    ClickText            Qualification
    ClickText            Mark as Current Stage
    ClickText            Needs Analysis
    ClickText            Mark as Current Stage
    ClickText            Value Proposition
    ClickText            Mark as Current Stage
    ClickText            Id. Decision Makers
    ClickText            Mark as Current Stage
    ClickText            Perception Analysis
    ClickText            Mark as Current Stage
    ClickText            Proposal/Price Quote
    ClickText            Mark as Current Stage
    ClickText            Negotiation/Review
    ClickText            Mark as Current Stage
    ClickText            Closed
    ClickText            Select Closed Stage
    UseModal             On
    VerifyText           Close This Opportunity
    DropDown             Stage                       Closed Lost
    ClickText            Save                        partial_match=false
    UseModal             Off
