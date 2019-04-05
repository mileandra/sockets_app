<template>
  <div>
    <h2>Welcome {{currentUser.name}}</h2>
    <p>
      Stay tuned! Teams will be paired soon.
    </p>
  </div>
</template>

<script>
import { mapState } from 'vuex'
export default {
  computed: mapState(['currentUser'])
}
</script>
