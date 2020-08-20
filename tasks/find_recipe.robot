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
    Search Recipe   ${RECIPE_TO_SEARCH}
    ${number} =     How Many Results On Page
    Log To Console  ${number}
    Append To File  ${FILEPATH}  ${RECIPE_TO_SEARCH}: ${number} \n

*** Keywords ***

Search Recipe
    [Arguments]  ${recipe_input}
    Wait Until Page Contains Element        id:multisearch-query
    Input Text      id:multisearch-query    ${recipe_input}
    Click Element   id:multisearch-btn

How Many Results On Page
    Wait Until Page Contains Element        id:recipes-container
    #Return 0 if no results
    ${not_found}    Run Keyword And Return Status   Page Should Contain Element  css:#recipelist-wrapper > div.category-header
    Run Keyword Unless  ${not_found}            Return From Keyword  0
    # execution continues if results are found
    ${text}     Get Text                    css:#recipelist-wrapper > div.category-header 
    ${number}   Fetch From Left             ${text}      ${SPACE}
    [RETURN]    ${number}

