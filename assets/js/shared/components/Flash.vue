<template>
  <div class="alert" :class="messageType" v-if="message">
    {{message.message}}
  </div>
</template>

<script>
export default {
  computed: {
    message () {
      return this.$store.state.message
    },
    messageType () {
      if (this.message.type == 'warn') {
        return 'alert-danger'
      }
      return 'alert-' + this.message.type
    }
  }
}
</script>

