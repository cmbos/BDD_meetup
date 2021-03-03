*** Settings ***
Library  SeleniumLibrary

*** Test Cases ***
Bol.com - zoeken naar product
    open browser  about:blank  chrome
    maximize browser window
    go to  https://www.bol.com/nl/
    click element  xpath://span[.='Accepteren']
    input text  id:searchfor  design patterns
    press keys  id:searchfor  RETURN
    page should contain  'design patterns' in Alle artikelen
    click element  xpath://a[@data-test='product-title' and .='Design Patterns']
    page should contain  Elements Of Reusable Object-Oriented Software
    wait until page contains element  xpath://ul[contains(@class, 'product-small-specs')]//li[contains(., '9780201633610')]  2s
    wait until page contains element  xpath://div[contains(@class, 'recommended-products')]//div[contains(@class, 'product-item')]//span[.= 'Clean Code']  2s
    close browser



