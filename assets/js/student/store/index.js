import Vue from 'vue'
import Vuex from 'vuex'

import actions from './actions'
import mutations from './mutations'

Vue.use(Vuex)

const state = {
  connected: false,
  currentUser: null,
  challenge: null,
  message: null
}


export default new Vuex.Store({
  state,
  actions,
  mutations
})