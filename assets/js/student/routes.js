import Router from 'vue-router'
import Vue from 'vue'
import Home from 'Student/views/Home.vue'
import Challenge from 'Student/views/Challenge.vue'

Vue.use(Router)

const routes = [
  {
    path: '/',
    name: 'home',
    component: Home
  },
  {
    path: '/challenge',
    name: 'challenge',
    component: Challenge
  }
]

const router = new Router({
  routes
})

export default router