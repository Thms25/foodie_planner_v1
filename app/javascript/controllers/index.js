// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import CounterController from "./counter_controller"
application.register("counter", CounterController)

import DeltaController from "./delta_controller"
application.register("delta", DeltaController)

import HeartController from "./heart_controller"
application.register("heart", HeartController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import MenuController from "./menu_controller"
application.register("menu", MenuController)

import PopUpMenuController from "./pop_up_menu_controller"
application.register("pop-up-menu", PopUpMenuController)

import ReadonlyController from "./readonly_controller"
application.register("readonly", ReadonlyController)

import ServingsController from "./servings_controller"
application.register("servings", ServingsController)

import ShowCheckBoxController from "./show_check_box_controller"
application.register("show-check-box", ShowCheckBoxController)
