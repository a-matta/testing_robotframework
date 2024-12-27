*** Settings ***
Library     SeleniumLibrary


*** Keywords ***
Open Browser Key
    [Documentation]    Open Browser
    [Arguments]    ${URL}    ${BROWSER}
    Open Browser    ${URL}    ${BROWSER}
