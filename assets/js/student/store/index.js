import Vue from 'vue'
import Vuex from 'vuex'

import actions from './actions'
import mutations from './mutations'
import getters from './getters'

Vue.use(Vuex)

const state = {
  connected: false,
  currentUser: null,
  team: null,
  challenge: null,
  answers: [],
  message: null,
  socketMessage: null
}


export default new Vuex.Store({
  state,
  actions,
  mutations,
  getters
})