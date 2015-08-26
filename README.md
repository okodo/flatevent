# Тестовое задание

* Задача: [Github](https://github.com/fs/test-tasks/tree/master/ruby)
* Сделано для: flatstack.com
* Сделано кем: Ivan Kenig <kii@ocodo.ru>
* Корреспондент: Anna Gashina <join@flatstack.com>
* Начало: 24.08.2015
* Сдано: 26.08.2015

## Первое задание

Тут речь идёт о последовательности чисел под названием Look and say. Задание было сделано не по числам, как это предусматривает математическая последовательность, а с помощью RegExp'а на начальном стринге. Преимущество данного решения заключается в том, что можно выводить бесконечное число элементов последовательности не боясь больших численных значений.

Код решения находится в папке lib основного проекта. Из консоли запускается так: "> LookAndSay.perform count", где "count" это необходимое число элементов последовательности, которое должно быть выведено на экран.

## Второе задание

Задание было сделано в основном с помощью AngularJS.
В качестве дополнительной функциональности имплементировал возможность комментировать события.
Приложение было развёрнуто в Heroku по ссылке: [https://radiant-peak-7849.herokuapp.com/](https://radiant-peak-7849.herokuapp.com/)



## Особенности имплементации

* Frontend on Angular, backend on Rails API on json served as one app together
* 100% test coverage - both JS + RSpec
* Templates using angular-rails-templates - Slim
* CSS - Less
* Javascript - coffeescript
* API - json
* Ruby unit test - RSpec
* Angular e2e testing - Protractor


## Особенности развёртывания приложения локально

* bundle install
* Create config/database.yml, configure it for postgresql
* rake db:create
* rake db:migrate
* rspec
* rake protractor:spec
