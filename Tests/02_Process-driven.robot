*** Settings ***
Library  SeleniumLibrary

Test Setup      Open bol.com website
Test Teardown   Afsluiten bol.com website

*** Test Cases ***
Bol.com - Controleer productgegevens
    Zoeken naar product     design patterns
    Kies specifiek product  Design Patterns
    Controleer subtitel     Elements Of Reusable Object-Oriented Software
    Controleer ISBN         9780201633610

Bol.com - Controleer aanbevolen product
    Zoeken naar product     design patterns
    Kies specifiek product  Design Patterns
    Controleer product in aanbevolen items  Clean Code

*** Keywords ***
Open bol.com website
    open browser  about:blank  chrome
    maximize browser window
    go to  https://www.bol.com/nl/
    click element  xpath://span[.='Accepteren']

Kies specifiek product
    [Arguments]  ${product_titel}
    click element  xpath://a[@data-test='product-title' and .='${product_titel}']

Zoeken naar product
    [Arguments]  ${product_titel}
    input text  id:searchfor  ${product_titel}
    press keys  id:searchfor  RETURN
    page should contain  '${product_titel}' in Alle artikelen

Controleer subtitel
    [Arguments]  ${subtitel}
    page should contain  ${subtitel}

Controleer ISBN
    [Arguments]  ${isbn}
    wait until page contains element  xpath://ul[contains(@class, 'product-small-specs')]//li[contains(., '9780201633610')]  2s

Controleer product in aanbevolen items
    [Arguments]  ${item}
    wait until page contains element  xpath://div[contains(@class, 'recommended-products')]//div[contains(@class, 'product-item')]//span[.= '${item}']  2s

Afsluiten bol.com website
    close browser