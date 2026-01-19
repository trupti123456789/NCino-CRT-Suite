*** Settings ***
Library                         QForce
Library                         QWeb
Resource                        ../resources/common.robot
Resource                        ../resources/Keyword.robot
Suite Setup                     Setup Browser
Suite Teardown                  End Suite

#nCino customization differs with organization, please check the configuration in your nCino Org and make the changes accordingly.
*** Test Cases ***   
E2E flow
    [tags]                    Ncino
   ${RelationshipData}=  Data
    Adding Relationships for Customer Onboarding            ${RelationshipData}
    Verify the Relationships                                ${RelationshipData}
    Create a connection for the household relationship      ${RelationshipData}
    Verify the Exposer abd create the debts                 ${RelationshipData}
    Create a Contact for Bussiness Account                  ${RelationshipData}
    Verifying contact creation                              ${RelationshipData}
    Create a Product package for Business Account           ${RelationshipData}
    Create a new Loan                                       ${RelationshipData}
    Fill the Loan information                               ${RelationshipData}
    Add Team Member in Loan                                 ${RelationshipData}
    Add Entity Involvement in Loan                          ${RelationshipData}
    Add Collateral in Loan                                  ${RelationshipData}
    Add Fee in Loan                                         ${RelationshipData}
    Create Risk Rating in Loan                              ${RelationshipData}
    Add Covenants in Loan                                   ${RelationshipData}
    Verify Covenant in loan                                 ${RelationshipData}










