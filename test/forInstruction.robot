*** Settings ***
Library    SeleniumLibrary

*** Variables ***
@{LINKS}    https://example.com    https://www.robotframework.org    https://www.selenium.dev

*** Test Cases ***
Open Multiple Links And Display Titles
    Open Browser    about:blank
    FOR    ${link}    IN    @{LINKS}
        Open Link And Display Title    ${link}
    END
    Close Browser

*** Keywords ***
Open Link And Display Title
    [Arguments]    ${link}
    Go To    ${link}
    ${title}=    Get Title
    Log    Title of ${link}: ${title}