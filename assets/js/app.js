import Vue from 'vue'
import App from 'Student/App.vue'

import store from 'Student/store'
import router from 'Student/routes'

Vue.config.productionTip = false


new Vue({
  store,
  router,
  render: h => h(App)
}).$mount('#app')


