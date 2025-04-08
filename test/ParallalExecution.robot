*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        chrome

*** Test Cases ***
Test On Chrome
    [Tags]    Chrome
    [Setup]   Open Browser    https://www.google.com    ${BROWSER}
    Title Should Be    Google
    [Teardown]    Close Browser

Test On Firefox
    [Tags]    Firefox
    [Setup]   Open Browser    https://www.google.com    ${BROWSER}
    Title Should Be    Google
    [Teardown]    Close Browser