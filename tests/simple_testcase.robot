*** Settings ***
Library         SeleniumLibrary
Resource        ../resource/resource.robot

Test Setup      Open Browser
# Test Teardown    Close Browser


*** Variables ***
${URL}          https://demowebshop.tricentis.com/
${BROWSER}      chrome


*** Test Cases ***
Login Test
    Open Browser Key    ${URL}    ${BROWSER}
    Click Element    link=Log in
    Input Text    id=Email    [email protected]
    Input Text    id=Password    password
    Click Element    xpath=//input[@value='Log in']

Handle TextBox Or InputBox
    Open Browser    https://google.com/    browser=${BROWSER}
    Maximize Browser Window
    ${name_field}=    Input Text    name="q"    amrita
    ${name_field}=    Element Should Be Visible    name="q"    amrita
    Clear Element Text    ${name_field}
    Close Browser

Select RadioButton & UnSelect RadioButton
    Open Browser    https://demo.automationtesting.in/Register.html    browser=${BROWSER}
    Maximize Browser Window
    Select Radio Button    group_name=radiooptions    value=Female
    Unselect Checkbox    locator=Female
    Close Browser

Select CheckBox & UnSelect CheckBox
    Open Browser    https://demo.automationtesting.in/Register.html    browser=${BROWSER}
    Maximize Browser Window
    Select Checkbox    id=checkbox3
    Unselect Checkbox    id=checkbox3
    Close Browser

Select Dropdown & UnSelect Dropdown
    Open Browser    https://demo.automationtesting.in/Register.html    browser=${BROWSER}
    Maximize Browser Window
    Select From List By Value    id=Skills    C++
    Unselect From List By Value    id=Skills    C++
    Select From List By Index    id=Skills    2
    Unselect From List By Index    id=Skills    2
    Select From List By Label    id=Skills    CSS
    Unselect From List By Label    id=Skills    CSS
    Close Browser

Open Browser InCognito Mode
    Open Browser    https://google.com/    browser=${BROWSER}    options=add_argument("--incognito")
    Maximize Browser Window
    Close Browser

Handle Alerts
    Open Browser    https://testautomationpractice.blogspot.com/    browser=${BROWSER}
    Maximize Browser Window
    Click Element    id=alertBtn
    Handle Alert    accept
    Sleep    5s
    Click Element    id=confirmBtn
    Handle Alert    accept
    Click Element    id=confirmBtn
    Handle Alert    dismiss
    Sleep    5s
    Close Browser

For Loop
    @{item}=    Create List    121    52    140    84    5
    FOR    ${counter}    IN    @{item}
        IF    ${counter} == 140    BREAK
        Log To Console    ${counter}
    END

Count And Extract Links
    Open Browser    https://demo.guru99.com/test/newtours/    browser=${BROWSER}
    Maximize Browser Window
    ${element_count}=    Get Element Count    xpath=//a
    ${links}=    Get WebElements    xpath=//a
    ${count}=    Get Length    ${links}
    Log To Console    ${count}
    FOR    ${link}    IN    1    ${count}
        ${link}=    Get Text    xpath=(//a)[${link}]
        Log To Console    ${link}
    END
    Close Browser
