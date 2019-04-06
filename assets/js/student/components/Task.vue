<template>
  <div class="form-group">
    <label v-html="task.question"></label>
    <textarea v-model="answer.value" class="form-control" @keyup="push"></textarea>
  </div>
</template>

<script>
import { mapState } from 'vuex'
export default {
  props: {
    task: {
      type: Object
    }
  },
  data () {
    return {
      answer: this.$store.getters.answer(this.task.id)
    }
  },
  computed: mapState(['socketMessage', 'currentUser']),
  methods: {
    push() {
      this.$store.dispatch('updateAnswer', this.answer)
    }
  },
  watch: {
    socketMessage: function(newVal) {
      if (newVal.key == 'answerUpdated' &&
        newVal.message.updated_by != this.currentUser.id &&
        newVal.message.answer.task_id == this.task.id) {
        this.answer.value = newVal.message.answer.value
      } 
    }
  }
}
</script>
