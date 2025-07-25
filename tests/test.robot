*** Settings ***
Library    JSONLibrary
#Library    YAMLLibrary
Library    SeleniumLibrary
Library    OperatingSystem
Variables  test2.yml


*** Test Cases ***
Open Google
    Open Browser    https://www.google.com    Chrome
    Title Should Be    Google
    Close Browser

Test
  ${jsonfile}  Load JSON From File   tests/test1.json
  ${user1}  Get Value From Json   ${jsonfile}  $.user
  #og To Console  ${user}[0][profile][email]
  Log To Console    ${jsonfile}[user]

Test1
  Skip   msg="Skipping this test"
  Log To Console    This test is skipped    