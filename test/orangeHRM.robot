*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Test Case 1
    [Setup]
    Set Selenium Implicit Wait    value=5s
    Open Browser    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login    firefox
    Maximize Browser Window
    Input Text    name=username   Admin
    Input Text    name=password   admin123
    Click Button    xpath=//*[@type='submit']
    Wait Until Element Is Visible    xpath=//h6
    [Teardown]    Close Browser