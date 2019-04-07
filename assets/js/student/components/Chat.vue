<template>
  <div>
    <h3>Chat with your teammates</h3>
    <div class="message" v-for="(message, index) in chatMessages" :key="index">
      {{message.from}}:<br>
      <p v-html="message.message"></p>
    </div>
    <form class="mt-4" @submit="sendMessage">
      <textarea v-model="msg" class="form-control"></textarea>
      <button type="submit" class="btn btn-primary">
        Send
      </button>
    </form>
  </div>
</template>

<script>
import {mapState} from 'vuex'
export default {
  data () {
    return {
      msg: ''
    }
  },
  computed: mapState(['chatMessages']),
  methods: {
    sendMessage(e) {
      e.preventDefault()
      this.$store.dispatch('sendChatMessage', this.msg)
      this.msg = ''
    }
  }
}
</script>
