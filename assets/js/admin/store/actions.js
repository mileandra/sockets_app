import socket from '@/socket'
import { Presence } from 'phoenix'

socket.connect()

let teamsChannel
let presences = {}

function bindTeamListeners(context, channel) {
  channel.on("presence_state", state => {
    presences = Presence.syncState(presences, state)
    context.commit('setPresences', state)
  })
  
  channel.on("presence_diff", diff => {
    for (let key in diff.joins) {
      let presence = diff.joins[key]
      context.dispatch('success', `User ${presence.user.name} joined`)
    }
    for (let key in diff.leaves) {
      let presence = diff.leaves[key]
      context.dispatch('warn', `User ${presence.user.name} left`)
    }
    presences = Presence.syncDiff(presences, diff)
    context.commit('setPresences', presences)
  })
}

export default {
  join (context) {
    teamsChannel = socket.channel("teams:lobby", {})
    teamsChannel.join()
      .receive("ok", resp => {
        bindTeamListeners(context, teamsChannel)
      })
      .receive("error", resp => { console.log("Unable to join", resp) })
  },

  // Messages
  addMessage({commit}, message) {
    commit('setMessage', message)
    setTimeout(() => {
      commit('setMessage', null)
    }, 4000)
  },
  success({dispatch}, message) {
    dispatch('addMessage', {type: 'success', message: message})
  },
  info({dispatch}, message) {
    dispatch('addMessage', {type: 'info', message: message})
  },
  warn({dispatch}, message) {
    dispatch('addMessage', {type: 'warn', message: message})
  }
}