<template>
  <div>
    <h3>Message Teams</h3>
    <form @submit="sendMessage">
      <textarea v-model="message" class="form-control"></textarea>
      <button type="submit">Send</button>
    </form>
  </div>
</template>

<script>
export default {
  data () {
    return {
      message: ''
    }
  },
  methods: {
    
    sendMessage(e) {
      e.preventDefault()
      this.$store.dispatch('sendTeacherMessage', this.message)
      this.message = ''
    }
  }
}
</script>
