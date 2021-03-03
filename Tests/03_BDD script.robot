*** Settings ***
Library  SeleniumLibrary

*** Test Cases ***
Bol.com - Controleer productgegevens
    [Setup]  Given I'm on the bol.com website
    When I search for design patterns
    And I select the product with title Design Patterns
    Then Subtitle Elements Of Reusable Object-Oriented Software is displayed
    And ISBN 9780201633610 is displayed
    [Teardown]  Close bol.com website

*** Keywords ***
I'm on the bol.com website
    open browser  about:blank  chrome
    maximize browser window
    go to  https://www.bol.com/nl/
    click element  xpath://span[.='Accepteren']

I select the product with title ${product_title}
    click element  xpath://a[@data-test='product-title' and .='${product_title}']

I search for ${product_title}
    input text  id:searchfor  ${product_title}
    press keys  id:searchfor  RETURN
    page should contain  '${product_title}' in Alle artikelen

Subtitle ${product_title} is displayed
    page should contain  ${product_title}

ISBN ${isbn} is displayed
    wait until page contains element  xpath://ul[contains(@class, 'product-small-specs')]//li[contains(., '${isbn}')]  2s

Controleer product in aanbevolen items
    wait until page contains element  xpath://div[contains(@class, 'recommended-products')]//div[contains(@class, 'product-item')]//span[.= '${item}']  2s

Close bol.com website
    close browser