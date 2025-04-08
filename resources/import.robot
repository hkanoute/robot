*** Settings ***
Library    XrayApiImporter.py
Library    OperatingSystem

*** Keywords ***
Import Results To Xray
    ${result}=   import_robot_results    test/login_test/results/output.xml
    Log    ${result}
