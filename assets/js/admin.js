import Vue from 'vue'
import App from 'Admin/App.vue'

import store from 'Admin/store'

Vue.config.productionTip = false


new Vue({
  store,
  render: h => h(App)
}).$mount('#app')