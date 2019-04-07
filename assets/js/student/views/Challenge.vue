<template>
  <div v-if="challenge">
    <h1>{{challenge.name}}</h1>
    <div class="row">
      <div class="col-sm col-md-8">
        <task v-for="task in challenge.tasks" :task="task" :key="task.id" />
      </div>
      <div class="col-sm col-md-4">
        <team />
        <chat />
      </div>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex'
import Task from 'Student/components/Task.vue'
import Team from 'Student/components/Team.vue'
import Chat from 'Student/components/Chat.vue'
export default {
  computed: mapState(['challenge', 'team']),
  components: {
    Task,
    Team,
    Chat
  }
}
</script>

