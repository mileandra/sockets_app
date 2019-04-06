<template>
  <div>
    <h3>Team</h3>
    <span v-for="user in team.users" :key="user.id">
      {{user.name}}
    </span>
  </div>
</template>

<script>
import { mapState } from 'vuex'
export default {
  computed: mapState(['team'])
}
</script>
