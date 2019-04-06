import socket from '@/socket'
import { Presence } from 'phoenix'

socket.connect()

let teamsChannel
let teacherChannel
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

function bindTeacherListeners (context, channel) {

}

function sendRequest(channel, method, payload = {}) {
  const promise = new Promise((resolve, reject) => {
    channel.push(method, payload)
      .receive('ok', resp => {
        console.log('method', resp)
        resolve(resp)
      })
      .receive('error', resp => {
        reject(resp)
      })
  })
  return promise
}

export default {
  join (context) {
    let promise = new Promise((resolve, reject) => {
      teamsChannel = socket.channel("teams:lobby", {})
      teamsChannel.join()
        .receive("ok", resp => {
          context.commit('setCurrentUser', resp.current_user)
          bindTeamListeners(context, teamsChannel)
        })
        .receive("error", resp => { console.log("Unable to join", resp) })

      teacherChannel = socket.channel("teacher", {})
      teacherChannel.join()
        .receive("ok", () => {
          context.commit('setTeacherConnected', true)
          bindTeacherListeners(context, teacherChannel)
          resolve("ok")
        })
        .receive("error", resp => { 
          context.commit('setTeacherConnected', true)
          console.log("Unable to join", resp) 
          reject(resp)
        })
      })
    return promise
  },

  listChallenges () {
    return sendRequest(teacherChannel, 'list_challenges')
  },

  pairTeams ({state, commit}, challenge_id) {
    let userIds = []
    for(let key in state.presences) {
      if (state.presences[key].user.role == 'student') {
        userIds.push(key)
      }
    }
    let params = {
      challenge_id: challenge_id,
      user_ids: userIds
    }
    sendRequest(teacherChannel, 'pair_teams', params)
      .then(resp => {
        commit('setTeams', resp.teams)
        commit('setChallenge', resp.challenge)
      }, err => {
        console.log(err)
        dispatch('error', 'Unable to pair teams')
      })
  },

  sendTeacherMessage ({state}, message) {
    teacherChannel.push('send_challenge_message', {
      challenge_id: state.challenge.id,
      message: message
    })
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