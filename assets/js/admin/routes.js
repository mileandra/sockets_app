import Router from 'vue-router'
import Vue from 'vue'
import Home from 'Admin/views/Home.vue'

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
    component: () => import(/* webpackChunkName: "new" */ 'Admin/views/New.vue'),
  }
]

const router = new Router({
  routes
})

export default router