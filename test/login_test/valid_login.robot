*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/import.robot

*** Test Cases ***
Test Case 1
    #[Tags]    robot    POEI25-712
    #[Setup]
    #Set Selenium Implicit Wait    value=5s
    #Open Browser    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login    firefox
    #Maximize Browser Window
    #Input Text    name=username   Admin
    #Input Text    name=password   admin123
    #Click Button    xpath=//*[@type='submit']
    #Wait Until Element Is Visible    xpath=//h6
    #[Teardown]    Close Browser
    Import Results To Xray
    