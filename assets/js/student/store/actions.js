import socket from '@/socket'

socket.connect()

let teamsChannel
let userChannel
let currentTeamChannel

function bindTeamListeners(context, channel) {
  channel.on('answer_updated', resp => {
    context.commit('setSocketMessage', {key: 'answerUpdated', message: resp})
  })

  channel.on('teacher_message', resp => {
    context.commit('setMessage', {type: 'info', message: resp.message})
  })
}

function bindUserListeners(context, channel) {
  channel.on('paired', resp => {
    if (resp.team_id) {
      console.log('paired', resp.team_id)
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
      if (user.team_id) {
        context.dispatch('joinCurrentTeam', user.team_id)
      }
      return Promise.resolve()
    })
    .receive('error', resp => {
      context.commit('setConnected', false)
      return Promise.reject(resp)
    })
  },
  joinCurrentTeam(context, teamId) {
    if (currentTeamChannel != undefined) {
      return
    }
    teamId = teamId || state.currentUser.team_id
    currentTeamChannel = socket.channel('teams:' + teamId, {})
    currentTeamChannel.join()
    .receive('ok', resp => {
      if (resp.team) {
        context.commit('setTeam', resp.team)
        context.commit('setChallenge', resp.challenge)
        context.commit('setAnswers', resp.answers)
        bindTeamListeners(context, currentTeamChannel)
      }
    })
    .receive('error', resp => {
      console.log(resp)
    })
  },
  updateAnswer(context, answer) {
    console.log(currentTeamChannel)
    currentTeamChannel.push('answer_update', {answer: answer})
  }
}
