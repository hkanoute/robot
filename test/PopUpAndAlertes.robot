*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${URL}            https://the-internet.herokuapp.com/javascript_alerts
${CONFIRM_BUTTON}    xpath=//button[text()='Click for JS Confirm']
${RESULT_TEXT}       id=result
${EXPECTED_TEXT}     You clicked: Ok

*** Test Cases ***
Handle JavaScript Confirm Alert
    Open Browser    ${URL}    chrome
    Click Button    ${CONFIRM_BUTTON}
    Handle Alert    ACCEPT
    Element Text Should Be    ${RESULT_TEXT}    ${EXPECTED_TEXT}
    Close Browser