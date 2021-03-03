*** Settings ***
Library  DataDriver  file=zoekscenario's bol.csv
Library  SeleniumLibrary

Test Setup      Open bol.com website
Test Template   Zoeken naar product en controleren productgegevens
Test Teardown   Afsluiten bol.com website

*** Test Cases ***
Zoeken naar ${zoekterm}  dummy

*** Keywords ***
Zoeken naar product en controleren productgegevens
    [Arguments]  ${zoekterm}  ${productnaam}  ${productomschrijving}
    Zoeken naar product  ${zoekterm}
    Kies specifiek product  ${productnaam}
    Controleer subtitel  ${productomschrijving}

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

Afsluiten bol.com website
    close browser

