*** Settings ***
Library                         QForce
Library                         Collections
Library                         RequestsLibrary
Library                         JSONLibrary
Library                         QVision
Library                        SeleniumLibrary
Library                         ../CustomLIbrary/Selenium.py
Library                         OperatingSystem
Resource                        ../resources/common.robot
Resource                        ../resources/data.robot
Suite Setup                     Setup Browser
Suite Teardown                  End Suite


*** Keywords ***
    ${RelationshipData}=        Data

Adding Business Relationship for Customer Onboarding
    [Documentation]             appstate to go directly to nCino / Relationships and create Onboarding
    [Arguments]                 ${RelationshipData}
    Home
    Clicktext                   Loans
    Clicktext                   Relationship-HouseHold - HH - Real Estate
    Clicktext                   Document Manager
    Clicktext                   Borrower Financial Statement