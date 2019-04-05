import Router from 'vue-router'
import Vue from 'vue'
import Home from 'Admin/views/Home.vue'
import New from 'Admin/views/New.vue'
import Challenge from 'Admin/views/Challenge.vue'

Vue.use(Router)

const routes = [
  {
    path: '/',
    name: 'home',
    component: Home
  },
  {
    path: '/new',
    name: 'new',
    component: New
  },
  {
    path: '/challenge/:id',
    name: 'challenge',
    component: Challenge
  }
]

const router = new Router({
  routes
})

export default router