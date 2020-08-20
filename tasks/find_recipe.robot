*** Settings ***

Library         SeleniumLibrary
Library         OperatingSystem     #used to write number of results to file
Library         String              #used to fetch number of recipes from a string

#Suite Setup    Remove Results File  # this is needed if run without docker, otherwise it writes to an existing file
Task Setup      Open Browser  https://www.foodie.fi/recipes
Task Teardown   Close Browser

*** Variables ***

${RECIPE_TO_SEARCH}     pizza
${FILEPATH}             reports/file/recipe_numbers.log

*** Tasks ***

Search Recipe And Write Number Of Results To A File
    Search Recipe
    Count Recipe Search Results
    Save Number Of Recipes To A File

*** Keywords ***

Search Recipe
    Wait Until Page Contains Element            id:multisearch-query
    Input Text          id:multisearch-query    ${RECIPE_TO_SEARCH}
    Click Element       id:multisearch-btn

Count Recipe Search Results
    Set Test Variable   ${RESULTS}          0
    Wait Until Page Contains Element        id:recipes-container
    #Stop Execution if recipes are not found
    ${not_found}    Run Keyword And Return Status   Page Should Contain Element  css:#recipelist-wrapper > div.category-header
    Run Keyword Unless  ${not_found}                Return From Keyword
    # execution continues if results are found
    ${text}     Get Text                    css:#recipelist-wrapper > div.category-header 
    ${number}   Fetch From Left             ${text}      ${SPACE}
    Set Test Variable    ${RESULTS}         ${number}

Save Number Of Recipes To A File
    Append To File  ${FILEPATH}  ${RECIPE_TO_SEARCH}: ${RESULTS} \n
    Log To Console  ${RESULTS}