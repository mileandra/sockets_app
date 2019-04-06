export default {
  setCurrentUser (state, user) {
    state.currentUser = user
  },

  setConnected (state, connected) {
    state.connected = connected
  },

  setTeam (state, team) {
    state.team = team
  },

  setChallenge (state, challenge) {
    state.challenge = challenge
  },

  setAnswers (state, answers) {
    state.answers = answers
  },

  setSocketMessage (state, message) {
    state.socketMessage = message
  }
}