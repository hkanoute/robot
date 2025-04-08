*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
OrangeHRM Champs obligatoires d’un formulaire
    Open Browser   https://opensource-demo.orangehrmlive.com/web/index.php/auth/login    firefox
    Maximize Browser Window
    Input Text    name=username   Admin
    Click Button    xpath=//*[@type='submit']
    Wait Until Element Is Visible    xpath=//span
    [Teardown]    Close Browser

