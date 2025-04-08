*** Settings ***

Library    SeleniumLibrary


*** Test Cases ***

Dynamic Element
    Open Browser    https://the-internet.herokuapp.com/dynamic_loading/1
    Maximize Browser Window
    Click Button    xpath=//button
    Wait Until Element Is Not Visible    id=loading
    Wait Until Element Is Visible    xpath=//h4
    Element Text Should Be    id=finish    Hello World!
    [Teardown]    Close Browser
