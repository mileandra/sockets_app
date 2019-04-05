<template>
  <div>
    <flash />
    <router-view v-if="connected" />
  </div>
</template>

<script>
import Flash from 'Shared/components/Flash.vue'
import { mapState } from 'vuex'
export default {
  components: {
    Flash
  },
  computed: mapState(['connected']),
  mounted () {
    this.$store.dispatch('join')
      .then(() => {
        
      }, err => {
        alert("Unable to join")
      })
  }
}
</script>

<style lang="scss">
@import "../../scss/app";
</style>