*** Settings ***
Library                         QForce
Library                         QWeb
Resource                        ../resources/common.robot
Resource                        ../resources/keyword.robot
Resource                        ../resources/Keyword2.robot
Suite Setup                     Setup Browser
Suite Teardown                  End Suite

##nCino customization differs with organization, please check the configuration in your nCino Org and make the changes accordingly.
*** Test Cases ***
E2E_flow
   ${Data}=  Data
   Adding Relationships      ${Data}







