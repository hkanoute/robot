*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Get iframe and verify title
    Open Browser    https://the-internet.herokuapp.com/iframe
    Maximize Browser Window
    Select Frame    id=mce_0_ifr
    Input Text    xpath=tinymce    Robot Framework
    Frame Should Contain    data-id=mce_0    Robot Framework
    [Teardown]    Close Browser