*** Settings ***
Documentation   Searches recipe from https://www.foodie.fi/
...             Prints number of recipes found and writes it to a file
...             Give variable in command line using --variable RECIPE_TO_SEARCH:pasta
...             If recipe is not given, defaults to pizza

Library         SeleniumLibrary
Library         OperatingSystem     #used to write number of results to file
Library         String              #used to fetch number of recipes from a string

Suite Setup     Remove Results File
Task Setup      Open Browser  https://www.foodie.fi/recipes
Task Teardown   Close Browser

*** Variables ***

${RECIPE_TO_SEARCH}
${DEFAULT_RECIPE}       pizza     
${FILEPATH}             reports/file/recipe_numbers.log

#css locators
${SEARCH_BOX}           id:multisearch-query
${SEARCH_BTN}           id:multisearch-btn
${RECIPES_AREA}         id:recipes-container
${RECIPES_HEADER}       css:#recipelist-wrapper > div.category-header


*** Tasks ***

Search Recipe And Write Number Of Results To A File
    Search Recipe
    Count Recipe Search Results
    Save Number Of Recipes To A File

*** Keywords ***

Remove Results File
    Remove File         ${FILEPATH}

Search Recipe
    Set Pizza As Default If Recipe Is Empty
    Wait Until Page Contains Element            ${SEARCH_BOX}
    Input Text          ${SEARCH_BOX}           ${RECIPE_TO_SEARCH}
    Click Element       ${SEARCH_BTN}

Set Pizza As Default If Recipe Is Empty
    Run Keyword If      '${RECIPE_TO_SEARCH}' == ''     Set Test Variable   ${RECIPE_TO_SEARCH}  ${DEFAULT_RECIPE}

Are Results Found
    [Documentation]     Searches RECIPES_HEADER element. Returns true if recipes are found and false
    ...                 If recipes are not found. Does not capture Screenshot if RECIPES_HEADER
    ...                 is not visible.
    ${previous kw} =	Register Keyword To Run On Failure	NONE
    ${not_found} =      Run Keyword And Return Status       Page Should Contain Element  ${RECIPES_HEADER}
    Register Keyword To Run On Failure                      ${previous kw}
    [Return]    ${not_found}

Count Recipe Search Results
    Set Test Variable   ${RESULTS}          0
    Wait Until Page Contains Element        ${RECIPES_AREA}
    #Stop Execution if recipes are not found
    ${not_found} =      Are Results Found       
    Run Keyword Unless  ${not_found}                Return From Keyword
    # execution continues if results are found
    ${text}     Get Text                    ${RECIPES_HEADER}
    ${number}   Fetch From Left             ${text}      ${SPACE}
    Set Test Variable    ${RESULTS}         ${number}

Save Number Of Recipes To A File
    Append To File  ${FILEPATH}  ${RECIPE_TO_SEARCH}: ${RESULTS}
    Log To Console  ${RECIPE_TO_SEARCH}: ${RESULTS}