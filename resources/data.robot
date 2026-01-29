*** Settings ***
Library                     JSONLibrary
Resource                    ../resources/common.robot

*** Keywords ***
Data

    # ${Json_obj}=          Evaluate                    open('${CURDIR}/../Data/Data.json').read()    json
    # ${dataA}=             Evaluate                    json.loads('''${Json_obj}''')    json
    ${dataA}=               Load JSON From File         ${CURDIR}/../Data/Data.json


    ${Household_Rel}=       Set Variable                ${dataA["data1Relationship"]}
    ${Business_Rel}=        Set Variable                ${dataA["data2Relationship"]}
    ${Individual_Rel}=      Set Variable                ${dataA["data3Relationship"]}
    ${Direct_D}=            Set Variable                ${dataA["DirectDebt"]}
    ${Indirect_D}=          Set Variable                ${dataA["IndirectDebt"]}
    ${Loan}=                Set Variable                ${dataA["Loan"]}
    ${Loan_Info}=           Set Variable                ${dataA["LoanData"]}
    ${Entity_Inv}=          Set Variable                ${dataA["EntityInvolvement"]}
    ${Collateral}=          Set Variable                ${dataA["Collateral"]}
    ${Fee}=                 Set Variable                ${dataA["Fee"]}
    ${Risk_R}=              Set Variable                ${dataA["RiskRating"]}
    ${Covenant}=            Set Variable                ${dataA["Covenant"]}
    ${Product_Pac}=         Set Variable                ${dataA["Product Package"]}
    ${Doc_Man}=             Set Variable                ${dataA["Document Manager"]}
    ${Compliance}=          Set Variable                ${dataA["Compliance"]}
    ${Structure}=           Set Variable                ${dataA["Amortization Structure"]}
    ${Loan_Doc}=            Set Variable                ${dataA["Loan Document"]}


    ${RelationshipData}=    Create Dictionary
    ...                     Name=${Household_Rel["Relationship Name"]}
    ...                     Type0=${Household_Rel["Type"]}
    ...                     Role=${Household_Rel["Role"]}
    ...                     Name1=${Business_Rel["Relationship Name"]}
    ...                     Type1=${Business_Rel["Type"]}
    ...                     Role1=${Business_Rel["Role"]}
    ...                     Contact=${Business_Rel["Contact"]}
    ...                     Name2=${Individual_Rel["Relationship Name"]}
    ...                     Type2=${Individual_Rel["Type"]}
    ...                     DebtName1=${Direct_D["Debt Name"]}
    ...                     value1=${Direct_D["Principal Balance"]}
    ...                     DebtName2=${Indirect_D["Debt Name"]}
    ...                     value2=${Indirect_D["Principal Balance"]}

    ...                     Product_Line=${Loan["Product Line"]}
    ...                     Product_Type=${Loan["Product Type"]}
    ...                     Product=${Loan["Product"]}
    ...                     Borrower_Type=${Loan["Borrower Type"]}
    ...                     Loan_Amount=${Loan["Loan Amount"]}
    ...                     Loan_Purpose=${Loan["Loan Purpose"]}

    ...                     Loan_Number=${Loan_Info["Loan Number"]}
    ...                     Primary_Loan_Purpose=${Loan_Info["Primary Loan Purpose"]}
    ...                     Application_Method=${Loan_Info["Application Method"]}
    ...                     Method_of_Doc_Prep=${Loan_Info["Method of Doc Prep"]}
    ...                     Prepayment_Penalty_Description=${Loan_Info["Prepayment Penalty Description"]}
    ...                     Secondary_Source_of_Repayment=${Loan_Info["Secondary Source of Repayment"]}
    ...                     Primary_Source_of_Repayment=${Loan_Info["Primary Source of Repayment"]}
    ...                     Tertiary_Source_of_Repayment=${Loan_Info["Tertiary Source of Repayment"]}
    ...                     Loan_Amount=${Loan_Info["Loan Amount"]}
    ...                     User=${Loan_Info["User"]}
    ...                     Role=${Loan_Info["Role"]}

    ...                     Borrower_Type=${Entity_Inv["Borrower Type"]}
    ...                     Contingent_Type=${Entity_Inv["Contingent Type"]}
    ...                     Contingent_Amount=${Entity_Inv["Contingent Amount"]}

    ...                     Type=${Collateral["Type"]}
    ...                     Subtype=${Collateral["Subtype"]}
    ...                     Value=${Collateral["Value"]}
    ...                     Collateral_Name=${Collateral["Collateral Name"]}
    ...                     City=${Collateral["City"]}
    ...                     Description=${Collateral["Description"]}

    ...                     Fee_Type1=${Fee["Fee Type1"]}
    ...                     Calculation_Type=${Fee["Calculation Type"]}
    ...                     Percentage=${Fee["Percentage"]}
    ...                     Fee_Paid_By=${Fee["Fee Paid By"]}
    ...                     Basis_Source=${Fee["Basis Source"]}
    ...                     Amount=${Fee["Amount"]}
    ...                     Collection_Method=${Fee["Collection Method"]}
    ...                     Fee_Type2=${Fee["Fee Type2"]}

    ...                     templates-list=${Risk_R["templates-list"]}

    ...                     CategoryCov=${Covenant["CategoryCov"]}
    ...                     Covenant_Type=${Covenant["Covenant Type"]}
    ...                     Effective_Date=${Covenant["Effective Date"]}
    ...                     Frequency_Template=${Covenant["Frequency Template"]}
    ...                     Grace_Days=${Covenant["Grace Days"]}

    ...                     Total_Borrower_Exposure=${Product_Pac["Total Borrower Exposure"]}
    ...                     Total_Obligor_Exposure=${Product_Pac["Total Obligor Exposure"]}
    ...                     Unused=${Product_Pac["Unused"]}
    ...                     Outstanding=${Product_Pac["Outstanding"]}
    ...                     Total_Credit_Exposur=${Product_Pac["Total Credit Exposur"]}
    ...                     New_Money=${Product_Pac["New Money"]}
    ...                     Approval_Committee=${Product_Pac["Approval Committee"]}
    ...                     Parent_Household=${Product_Pac["Parent Household"]}

    ...                     Category=${Doc_Man["Category"]}
    ...                     Document_Placeholder_Name=${Doc_Man["Document Placeholder Name"]}
    ...                     Year=${Doc_Man["Year"]}

    ...                     Question1=${Compliance["Is the loan or line of credit secured by a lien on a dwelling?"]}
    ...                     Question2=${Compliance["Is the loan temporary financing? (i.e., designed to be replaced by a permanent financing)"]}
    ...                     Question3=${Compliance["I certify that this loan IS NOT HMDA Reportable."]}
    ...                     Question4=${Compliance["Is any borrower, co-borrower, or guarantor an executive officer, director, or principal shareholder of that bank, of a bank holding company of which the member bank is a subsidiary, and of any other subsidiary of that bank holding company?"]}
    ...                     Question5=${Compliance["If any borrower, co-borrower, or guarantor of this loan is an employee of the bank or any affiliates, I certify I have indicated this is an \"Employee Loan\"."]}
    ...                     Question6=${Compliance["I certify this loan has been marked as \"Reg O Reportable\"."]}
    ...                     HMDA_Record_Type=${Compliance["HMDA Record Type"]}

    ...                     Term_Length=${Structure["Term Length"]}
    ...                     All-in-Rate=${Structure["All-in Rate"]}
    ...                     Term_Unit=${Structure["Term Unit"]}
    ...                     Index=${Structure["Index"]}
    ...                     Spread=${Structure["Spread"]}
    ...                     Payment_Type=${Structure["Payment Type"]}
    ...                     Term_Length=${Structure["Term Length"]}
    ...                     Payment_Frequency=${Structure["Payment Frequency"]}

    ...                     LoanName=${Loan_Doc["LoanName"]}
    ...                     ClosingChecklistName=${Loan_Doc["ClosingChecklistName"]}
    ...                     Owner=${Loan_Doc["Owner"]}
    ...                     Priority=${Loan_Doc["Priority"]}
    ...                     Needed_By_Stage=${Loan_Doc["Needed By Stage"]}
    ...                     -D_Portal_Doc_Type=${Loan_Doc["-D Portal Doc Type"]}
    ...                     Review_Status=${Loan_Doc["Review Status"]}



    [Return]                ${RelationshipData}

Verify LOS Stage Using VerifyElement
    [Arguments]             ${stage}

    VerifyElement           //span[@class\='current slds-path__stage']//following::span[text()\='${stage}']    20













