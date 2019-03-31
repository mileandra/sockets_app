<template>
  <div>
    <h2>Admin</h2>
    <flash />
    <user-list />
  </div>
</template>

<script>
import UserList from 'Admin/components/UserList.vue'
import Flash from 'Admin/components/Flash.vue'
export default {
  components: {
    UserList,
    Flash
  },
  mounted () {
    this.$store.dispatch('join')
  }
}
</script>
