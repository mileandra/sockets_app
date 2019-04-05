import socket from '@/socket'

socket.connect()

let teamsChannel
let userChannel
let currentTeamChannel

function bindTeamListeners(context, channel) {

}

function bindUserListeners(context, channel) {
  channel.on('paired', resp => {
    if (resp.team_id) {
      console.log('joining team', resp)
      context.dispatch('joinCurrentTeam', resp.team_id)
    } else {
      console.log('no team provided')
    }
  })
}

export default {
  join (context) {
    teamsChannel = socket.channel("teams:lobby", {})
    teamsChannel.join()
      .receive("ok", resp => {
        context.commit('setCurrentUser', resp.current_user)
        bindTeamListeners(context, teamsChannel)
        return context.dispatch('joinUserChannel', resp.current_user)
      })
      .receive("error", resp => 
      { 
        console.log("Unable to join", resp) 
        return Promise.reject(resp)
      })
  },
  joinUserChannel (context, user) {
    userChannel = socket.channel('user:' + user.id, {})
    userChannel.join()
    .receive('ok', () => {
      bindUserListeners(context, userChannel)
      context.commit('setConnected', true)
      return Promise.resolve()
    })
    .receive('error', resp => {
      context.commit('setConnected', false)
      return Promise.reject(resp)
    })
  },
  joinCurrentTeam({commit}, teamId) {
    currentTeamChannel = socket.channel('team:' + teamId, {})
    currentTeamChannel.join()
    .receive('ok', resp => {
      if (resp.challenge) {
        commit('setChallenge', challenge)
        console.log(this._vm)
        console.log(this._vm.$root)
      }
    })
  }
}