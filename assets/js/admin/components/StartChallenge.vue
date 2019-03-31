<template>
  <div class="form form-inline">
    <div class="form-group mr-2">
      <select class="form-control" v-model="challenge_id">
        <option value="">Choose Challenge</option>
        <option v-for="challenge in challenges" :key="challenge.id" :value="challenge.id">{{challenge.name}}</option>
      </select>
    </div>
    <button type="button" :disabled="challenge_id == ''" @click.prevent="pairTeams" class="btn btn-primary">
      Pair Teams
    </button>
  </div>
</template>

<script>
export default {
  data () {
    return {
      challenges: [],
      challenge_id: "",
    }
  },
  methods: {
    loadChallenges () {
      this.$store.dispatch('listChallenges')
        .then((resp) => {
          this.challenges = resp.challenges
        },
        (err) => {
          console.log(err)
        })
    },
    pairTeams () {
      this.$store.dispatch('pairTeams', parseInt(this.challenge_id))
        .then(() => {
          this.$store.dispatch('success', "Teams Paired")
          this.$router.push({name: 'teams'})
        })
    }
  },
  mounted () {
    this.loadChallenges()
  }
}
</script>

