*** Settings ***
Library    SeleniumLibrary


*** Keywords ***
Se connecter
    [Arguments]    ${username}    ${password}
    Open Browser    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login    firefox
    Maximize Browser Window
    Set Selenium Implicit Wait    value=5s
    Input Text    name=username   ${username} 
    Input Text    name=password   ${password}
    Click Button    xpath=//*[@type='submit']
    Wait Until Element Is Visible    xpath=//h6
    [Teardown]    Close Browser