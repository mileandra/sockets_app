<template>
  <div>
    <flash />
    <router-view />
  </div>
</template>

<script>
import Flash from 'Admin/components/Flash.vue'
export default {
  components: {
    Flash
  },
  mounted () {
    this.$store.dispatch('join')
      .then(() => {
        this.$router.push({name: 'new'})
      }, err => {
        alert("Unable to join")
      })
  }
}
</script>

<style lang="scss">
@import "../../scss/app";
</style>
