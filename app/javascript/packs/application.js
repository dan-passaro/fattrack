/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from 'vue/dist/vue'
import VueRouter from 'vue-router'
import App from '../components/app.vue'
import OldEntries from '../components/old-entries.vue'

const routes = [
  { path: '/', component: App },
  { path: '/weight-entries', component: OldEntries }
]

document.addEventListener('DOMContentLoaded', () => {
  Vue.use(VueRouter)
  const router = new VueRouter({routes})
  const app = new Vue({router})
  app.$mount('#app-container')
})
