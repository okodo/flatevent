describe "main", ->
  it "should handle auth error", ->

    # get vars
    form = element(By.id("sign-in-form"))
    submit_button = element(By.css('[value="Sign in"]'))
    errors = element(By.css('div.alert'))


    # visit main page
    browser.get("/")
    browser.waitForAngular()

    expect(form.isDisplayed()).toBeTruthy()
    expect(submit_button.isDisplayed()).toBeTruthy()
    expect(errors.isDisplayed()).toBeFalsy()

    submit_button.click()

    expect(form.isDisplayed()).toBeTruthy()
    expect(errors.isDisplayed()).toBeTruthy()

  it "should handle register errors", ->

    # get vars
    register_form = element(By.id("sign-up-form"))
    submit_button = element(By.css('[value="Sign up"]'))
    register_link = element(By.css('a[href="#/register"]'))
    email = element(By.css('input[name="email"]'))
    password = element(By.css('input[name="password"]'))
    password_confirmation = element(By.css('input[name="password_confirmation"]'))
    errors = element(By.css('div.alert'))

    # visit main page
    browser.get("/")
    browser.waitForAngular()

    expect(register_link.isDisplayed()).toBeTruthy()

    register_link.click()
    browser.waitForAngular()

    expect(register_form.isDisplayed()).toBeTruthy()
    expect(submit_button.isDisplayed()).toBeTruthy()
    expect(errors.isDisplayed()).toBeFalsy()

    email.sendKeys('kii@ocodo.ru')
    password.sendKeys('some_passwd')
    password_confirmation.sendKeys('some_other_passwd')

    submit_button.click()

    expect(register_form.isDisplayed()).toBeTruthy()
    expect(submit_button.isDisplayed()).toBeTruthy()
    expect(errors.isDisplayed()).toBeTruthy()

  it "register and create event", ->

    # get vars
    register_form = element(By.id("sign-up-form"))
    submit_button = element(By.css('[value="Sign up"]'))
    register_link = element(By.css('a[href="#/register"]'))
    email = element(By.css('input[name="email"]'))
    password = element(By.css('input[name="password"]'))
    password_confirmation = element(By.css('input[name="password_confirmation"]'))

    create_new_event_button = element(By.css("button[title='Add new event']"))

    event_form = element(By.css('form[name="form.eventForm"]'))
    title = element(By.css('input[name="title"]'))
    type = element(By.css('form[name="form.eventForm"] select'))
    type_option = element(By.css('option[value="string:month"]'))
    date = element(By.css('input[name="starts_at"]'))
    event_submit = element(By.css('form[name="form.eventForm"] button'))
    errors = element(By.css('div.alert'))

    events_table = element(By.css('table.table'))

    # visit main page
    browser.get("/")
    browser.waitForAngular()

    expect(register_link.isDisplayed()).toBeTruthy()

    register_link.click()

    expect(register_form.isDisplayed()).toBeTruthy()
    expect(submit_button.isDisplayed()).toBeTruthy()

    email.sendKeys('kii@ocodo.ru')
    password.sendKeys('somepasswd')
    password_confirmation.sendKeys('somepasswd')

    submit_button.click()

    browser.waitForAngular()

    expect(errors.isDisplayed()).toBeFalsy()

    expect(create_new_event_button.isDisplayed()).toBeTruthy()
    expect(events_table.isDisplayed()).toBeFalsy()

    create_new_event_button.click()

    expect(event_form.isDisplayed()).toBeTruthy()

    title.sendKeys('Some new event')
    type.click()
    type_option.click()
    event_submit.click()

    expect(events_table.isDisplayed()).toBeTruthy()
