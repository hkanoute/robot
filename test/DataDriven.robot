*** Settings ***
Library           DataDriver    ../resources/login2.csv
Library    SeleniumLibrary
Test Template     Login With User And Password

*** Test Cases ***
Login with user ${username} and password ${password}    Default    UserData

*** Keywords ***
Login With User And Password
    [Arguments]    ${username}    ${password}
    Open Browser    https://the-internet.herokuapp.com/login    firefox
    Maximize Browser Window
    Set Selenium Implicit Wait    value=5s
    Input Text    id=username   ${username} 
    Input Text    id=password   ${password}
    Click Button    xpath=//*[@type='submit']
    Wait Until Element Is Visible    xpath=//h2
    Element Should Not Contain    xpath=//h2    Login Page
    [Teardown]    Close Browser