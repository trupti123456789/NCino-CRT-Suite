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


*** Test ***

Adding Business Relationship for Customer Onboarding
     [tags]                   nCino12
    [Documentation]             appstate to go directly to nCino / Relationships and create Onboarding
    [Arguments]                 ${RelationshipData}
    Home
    Clicktext                   Loans
    Clicktext                   Relationship-HouseHold - HH - Real Estate
    Clicktext                   Document Manager
    Clicktext                   Borrower Financial Statement
    ${relative_path}            Set Variable                tests/../Data/PO.pdf
    ${file_path}                Get File Path Based on Mode                             ${relative_path}
  Selenium.Upload File Lightning                        locator=//button[normalize-space()='Upload File']  file_path=${file_path}
