# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "flowbite", to: "https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.turbo.min.js"
pin "flowbite-datepicker", to: "https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/datepicker.turbo.min.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8
pin "@fortawesome/fontawesome-free", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.1.1/js/all.js"
