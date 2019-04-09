<template>
  <div>
    <flash />
    <router-view v-if="teacherConnected" />
  </div>
</template>

<script>
import Flash from 'Shared/components/Flash.vue'
import { mapState } from 'vuex'

export default {
  components: {
    Flash
  },
  computed: mapState(['teacherConnected']),
  mounted () {
    this.$store.dispatch('join')
      .then(() => {
        if (this.$route.name == 'home') {
          this.$router.push({name: 'new'})
        }
      }, err => {
        alert("Unable to join")
      })
  }
}
</script>

<style lang="scss">
@import "../../scss/app";
</style>
