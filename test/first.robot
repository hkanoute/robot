*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Test Case 1
    Open Browser    https://example.com    firefox
    Maximize Browser Window
    Title Should Be    Example Domain
    [Teardown]    Close Browser
