*** Settings ***
Documentation   Test Matglads matsedel function
Library         SeleniumLibrary
Test Setup      Begin Web Test
Test Teardown   End Web Test
*** Variables ***
${BROWSER}      chrome
${URL}          http://app.matglad.nu/#/startview

*** Keywords ***
Begin Web Test
    Open Browser                        about:black     ${BROWSER}
    Maximize Browser Window
    Go to                               ${URL}
End web test
    close browser

User is adding a random recipie
    click element   id=planner-btn
    sleep           1
    click element   xpath://*[@id="planner-view-container"]/div/div[7]/div[2]
    sleep           1
    click element    xpath://*[@id="full-container"]/navigation-footer/div/div
    sleep           1
    click element   xpath://*[@id="choose-buttons"]/div[2]
    sleep           1
    sleep           1
    click element   xpath://*[@id="large-footer"]/img
User click on shop
     sleep           1
    click element    xpath://*[@id="full-container"]/navigation-footer/div/div
     sleep           1

User is on the webpage Matglad
    page should contain     Matglad
User is planning meal for today
    User is adding a random recipie
    sleep           1
    User click on shop
    sleep           1
    click element    xpath://*[@id="shop-for-days-container"]/ul/li/div/div[2]/img
    sleep           1
    User click on shop
    sleep           1
    User click on shop

User can see a list of ingredients
    wait until page contains element   id=shoppinglist-table
    page should contain element        id=shoppinglist-table

*** Test Cases ***
User can see a list of ingredients to shop
    [Documentation]     User can see list containing ingredients to shop
    [Tags]              MAT-4

    Given User is on the webpage Matglad
    When User is planning meal for today
    Then User can see a list of ingredients
