<template>
  <div class="alert" :class="messageType" v-if="message">
    {{message.message}}
  </div>
</template>

<script>
export default {
  computed: {
    message () {
      return this.$store.getters.message
    },
    messageType () {
      if (this.message.type == 'warn') {
        return 'danger'
      }
      return this.message.type
    }
  }
}
</script>

