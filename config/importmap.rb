# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.7.1/dist/jquery.js"
pin "stripe_form", to: "stripe_form.js" 