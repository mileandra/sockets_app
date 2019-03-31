<template>
  <div>
    <start-challenge />
    <user-list />
  </div>
</template>

<script>
import UserList from 'Admin/components/UserList.vue'
import StartChallenge from 'Admin/components/StartChallenge.vue'
export default {
  components: {
    UserList,
    StartChallenge
  }
}
</script>
