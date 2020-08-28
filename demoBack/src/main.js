import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import vuetify from './plugins/vuetify';
import '@babel/polyfill'
import 'roboto-fontface/css/roboto/roboto-fontface.css'
import '@mdi/font/css/materialdesignicons.css'
import 'material-design-icons-iconfont/dist/material-design-icons.css' // Ensure you are using css-loader
import vSelect from 'vue-select'

import axios from 'axios'

import mixmain from './mixins/mixmain.js';

Vue.prototype.axios = axios
Vue.config.productionTip = false
Vue.component('v-select2', vSelect)

new Vue({
  router,
  store,
  vuetify,
  mixins: [mixmain],
  render: h => h(App)
}).$mount('#app')
