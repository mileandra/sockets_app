<template>
  <div v-if="challenge">
    <h1>{{challenge.name}}</h1>
    <div class="row">
      <div class="col-sm col-md-4">
        <user-list />
      </div>
      <div class="col-sm col-md-8">
        <challenge-message />
      </div>
    </div>
  </div>
</template>

<script>
import {mapState} from 'vuex'
import UserList from 'Admin/components/UserList.vue'
import ChallengeMessage from 'Admin/components/ChallengeMessage.vue'

export default {
  computed: mapState([
  'challenge'
  ]),
  components: {
    UserList,
    ChallengeMessage
  }
}
</script>
