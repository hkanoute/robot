*** Settings ***
Library           ../resources/AdditionLibrary.py

*** Test Cases ***
Test Addition
    ${result}=    Addition    5    7
    Should Be Equal As Integers    ${result}    12