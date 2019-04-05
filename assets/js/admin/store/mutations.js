export default {
  setTeacherConnected (state, connect) {
    state.teacherConnected = connect
  },
  setPresences (state, presences) {
    state.presences = presences
  },
  setCurrentUser (state, user) {
    state.currentUser = user
  },
  setTeams (state, teams) {
    state.teams = teams
  },
  setChallenge(state, challenge) {
    state.challenge = challenge
  },
  setMessage (state, message) {
    state.message = message
  }
}