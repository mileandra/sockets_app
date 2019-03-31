<template>
  <div>
    <h3>Users online</h3>
    <ul>
      <li v-for="(presence, key) in presences" :key="key">
        <span class="name">{{presence.user.name}}</span>
        <span class="role" :class="presence.user.role">{{presence.user.role}}</span>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  computed: {
    presences () {
      return this.$store.getters.presences
    }
  }
}
</script>

