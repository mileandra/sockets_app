<template>
  <div v-if="challenge">
    <h1>{{challenge.name}}</h1>
    <team />
    <task v-for="task in challenge.tasks" :task="task" :key="task.id" />
  </div>
</template>

<script>
import { mapState } from 'vuex'
import Task from 'Student/components/Task.vue'
import Team from 'Student/components/Team.vue'
export default {
  computed: mapState(['challenge', 'team']),
  components: {
    Task,
    Team
  }
}
</script>

