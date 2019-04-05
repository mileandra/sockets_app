import Router from 'vue-router'
import Vue from 'vue'
import Home from 'Student/views/Home.vue'

Vue.use(Router)

const routes = [
  {
    path: '/',
    name: 'home',
    component: Home
  }
]

const router = new Router({
  routes
})

export default router