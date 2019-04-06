<template>
  <div>
    <h2>Welcome {{currentUser.name}}</h2>
    <p>
      Stay tuned! Teams will be paired soon.
    </p>
  </div>
</template>

<script>
import { mapState } from 'vuex'
import socket from '@/socket'

export default {
  computed: mapState(['currentUser', 'challenge']),
  methods: {
    proceedToChallenge() {
      this.$router.push({name: 'challenge'})
    }
  },
  mounted () {
    if (this.challenge) {
      this.proceedToChallenge()
    }
  },
  watch: {
    challenge: function(newVal) {
      if (newVal !== null) {
        this.proceedToChallenge()
      }
    }
  }
}
</script>
