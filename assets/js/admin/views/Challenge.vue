<template>
  <div v-if="challenge">
    <h1>{{challenge.name}}</h1>
    <user-list />
  </div>
</template>

<script>
import {mapState} from 'vuex'
import UserList from 'Admin/components/UserList.vue'
export default {
  computed: mapState([
  'challenge'
  ]),
  components: {
    UserList
  }
}
</script>
