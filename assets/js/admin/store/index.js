import Vue from 'vue'
import Vuex from 'vuex'

import actions from './actions'
import mutations from './mutations'

Vue.use(Vuex)

const state = {
  presences: {},
  teacherConnected: false,
  currentUser: null,
  teams: [],
  challenge: null,
  message: null
}


export default new Vuex.Store({
  state,
  actions,
  mutations
})