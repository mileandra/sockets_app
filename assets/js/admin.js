import Vue from 'vue'
import App from 'Admin/App.vue'

import store from 'Admin/store'
import router from 'Admin/routes'

Vue.config.productionTip = false


new Vue({
  store,
  router,
  render: h => h(App)
}).$mount('#app')