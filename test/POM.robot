*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/login.resource
*** Test Cases ***
Login with user and password using keywords
    Se connecter    Admin    admin123
