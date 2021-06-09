*** Settings ***
Documentation   Test select and save Recipe
Library         SeleniumLibrary
Test Setup      Begin Web Test
Test Teardown   End Web Test
*** Variables ***
${BROWSER}              chrome
${URL}                  http://app.matglad.nu/#/startview
${element}              Matglad
${menu}                 Veckomatsedel
${title}                 Välj recept
${Image}              xpath://*[@id="collection-wrapper"]/div/collection-view/ul/li[1]/a/div/img

*** Keywords ***
Begin Web Test
    Open Browser                        about:black     ${BROWSER}
    Maximize Browser Window
    Go to                               ${URL}
    sleep                                2
    Page should contain                 ${element}
#  TEST 1----------------------------------------------------------------------------
User is on the Matglad page
    wait until page contains    ${element}
    click element             xpath://*[@id="planner-btn"]

Menu page opened
    wait until page contains element    xpath://*[@id="full-container"]/navigation-bar/div/h1
    Page should contain                 ${menu}
#GHERKIN TEST 2------------------------------------------------------------------------------
User is on the Weekly menu page
    User is on the Matglad page
    sleep                       1
    click element               xpath://*[@id="planner-view-container"]/div/div[3]/div[1]/div[1]/div[1]/h3
Choose recipe page is opened
    wait until page contains element    xpath://*[@id="title"]/h1
    Page should contain                 ${title}
# TEST 3-----------------------------------------------------------------------------
User is on the choose recipes page
   User is on the Matglad page
    sleep                       1
    page should contain          ${menu}
    click image               xpath://*[@id="next-week"]/img
    sleep                        2
    click element               xpath://*[@id="planner-view-container"]/div/div[4]/div[1]/div[1]/div[1]/h3
    sleep                        2
    Page should contain         ${title}
    click element                xpath://*[@id="choose-buttons"]/div[1]/h3
    click image                 ${Image}
User saves the recipes
   sleep                        2
   click image                  xpath://*[@id="collection-wrapper"]/div/collection-view/ul/li[1]/a/div/img
   sleep                        2
   click image                xpath://*[@id="small-footer"]/img
   page should contain image    xpath://*[@id="planner-view-container"]/div/div[3]/div[2]/img
   sleep                        2

End Web Test
    Close Browser

*** Test Cases ***
User opens the app
    [Documentation]         open the menu
    [Tags]                  PB-24
    Given User is on the Matglad page
    Menu page opened
User chooses the Recipe
    [Documentation]         choose the recipes
    [Tags]                  PB-27
    Given User is on the Weekly menu page
    Choose recipe page is opened
User saves the recipes
    [Documentation]         Select and save recipe
    [Tags]                  PB-29
    Given User is on the choose recipes page
    User saves the recipes
