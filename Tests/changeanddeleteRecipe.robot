*** Setting ***
Documentation                   This is some basic infor about the whole test suite
Library                         SeleniumLibrary
Test Setup                      Begin Web Test
Test Teardown                   End Web Test
*** Variables ***
${BROWSER}                      chrome
${URL}                          https://www.willys.se/
*** Keywords ***
Begin Web Test
    Open browser                about:blank     ${BROWSER}

Go To Web Page
    Load Page
    Verify Page Loaded
Load Page
    Go to                       ${URL}
Verify Page Loaded
    Wait until Page Contains    Handla billig mat online
Search For Product
    [Arguments]                 ${search_term}  ${search_result}
    Enter Search Term           ${search_term}
    Submit Search
    Verify Search Completed     ${search_result}
Enter Search Term
    [Arguments]                 ${search_term}
    Input Text                  id=selenium--search-items-input   ${search_term}
Submit Search
    Press Keys                  xpath://input[@id="selenium--search-items-input"]       RETURN
    Press Keys                  xpath://input[@id="selenium--search-items-input"]       RETURN
Verify Search Completed
    [Arguments]                 ${search_result}
    Wait until Page Contains    ${search_result}
End Web Test
    Close All Browsers
*** Test Cases ***
User can access website
    [Documentation]             This is some basic info about the test
    [Tags]                      Test 1
    Go To Web Page
    Search For Product          kiwi        Sökord: kiwi


User can search for a prduct
    [Documentation]             This is some basic info about the test
    [Tags]                      Test 2
    Go To Web Page
    Search For Product          mjölk        Sökord: mjölk



User can search for a prduct
    [Documentation]             This is some basic info about the test
    [Tags]                      Test 3
    Go To Web Page
    Search For Product          Godis        Sökord: Godis

