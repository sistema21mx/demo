import Vue from 'vue'
import Vuex from 'vuex'
//
import router from '@/router'
import axios from 'axios'
//
Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    protocol: location.protocol + '//', 
    hostName: location.hostname, 
    imageHeight: '.', 
    appName: 'demo',
    apiName: 'demoapi',
    apiRoute: '/api',
    portNumber: ':8000',
    labelBar: '',
    loadData: 1,
    loggedIn: 0,
    keyPass: 0,
    keyUniqueCodes: [],
    // viewPage: {
    //   pageNumber: 0
    // },
    viewData: {
      act: '',
      param: []
    },
    overlay: false,
    json_Snackbar: {
      snackbar: true,
      y: 'top',
      color: 'blue',
      mode: '',
      timeout: 3000,
      text: 'Iniciando Sistema',
      autoheight: true
    },
    userData: { data: {
      error: 1,
      message: '',
      userName: 'userName',
      name: 'Name',
      userId: 'id',
      // dateStrNow: 'Bienvenido  00/00/0000',
      loginTime: '00:00:00',
      token: ''
      // loadData: 0
      // menuCat: [],
      // menuReg: [],
      // menuCon: []
      }
    },
    resultElement: null,
    loadRoute: { route: '', param: {}, title: '', pathRoute: '' },
    itemsModule: [
      {
        action: 'local_activity',
        title: 'Modul title',
        items: [
          { title: 'List title' }
        ]
      }
    ]
  },
  mutations: {
    setLoggedIn (state, payload) {
      state.loggedIn = payload
    },
    setKeyPass (state, payload) {
      state.keyPass = payload
    },
    setKeyUniqueCodes (state, payload) {
      state.keyUniqueCodes = payload
    },
    setViewData (state, payload) {
      state.viewData = payload
    },
    setViewPage (state, payload) {
      state.viewPage = payload
    },
    setUserData (state, payload) {
      state.userData = payload
      // if (payload.error === 0) { sessionStorage.setItem('localUserData', JSON.stringify(payload)) } else { sessionStorage.removeItem('localUserData') }
      sessionStorage.setItem('localUserData', JSON.stringify(payload))
    },
    setLoadData (state, payload) {
      state.loadData = payload
      // if (payload === 0) { state.dialogComponent = {action: 'error', title: 'Aviso', msg: 'Error inesperado, Señal intermitente', button1: '', button2: 'Aceptar'} }
    },
    setImageHeight (state, payload) {
      state.imageHeight = payload
    },
    setMessage (state, payload) {
      state.json_Snackbar.snackbar = true
      state.json_Snackbar.text = payload.msg
      state.json_Snackbar.color = payload.type
      if ( payload !== '') {
        setTimeout(function () { state.json_Snackbar.snackbar = false; state.json_Snackbar.text = null; state.json_Snackbar.color = 'info' }, 3000)
      }
    },
    setLoadRoute (state, payload) {
      if(payload.route===state.loadRoute.route){ return }
      state.overlay = true
      state.labelBar = payload.title
      let matched = null
      let resolve = null
      resolve = router.resolve({name: payload.route})
      matched = resolve.resolved.matched.length
      if (matched > 0) {
        payload.pathRoute = resolve.resolved.matched[0].components.default.name + '/'
      } else {
        resolve = null
        payload.pathRoute = ''
        payload.route = 'Error404'; payload.title = 'Error 404'
      }

      if(payload.route !== state.loadRoute.route){
        router.push({ name: payload.route, params: payload.param })
        state.loadRoute = payload
        //
        // loadAxData
        state.keyUniqueCodes = []
        if(state.keyPass!==0){
          axios({
          method: 'post', 
          url: this.getters.getUrlApi + '/logcreate',
          responseType: 'json',
          data:  {
              user_id : state.userData.data.userId,
              event : payload.route
          }, 
          headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ' + state.keyPass
          }
          })
          .then(response => {
              // console.log(response.data)
              // console.log( '*** ' + response.data + ' *** is good !! '  )
              state.resultElement = response.data.message
              // console.log(resultElement)
          })
          .catch(e => {
              console.log( '*** ' + this.$route.name + ' *** is Not good !! ' + e )
          })
          //
        }
      }
      if (payload.route === '/') { sessionStorage.removeItem('localParams') }
      sessionStorage.removeItem('localLabelBar')
      if (payload !== null && state.loadRoute.route !== 'Home') { 
        sessionStorage.setItem('localLabelBar', JSON.stringify(payload)) 
      } else { 
        sessionStorage.removeItem('localLabelBar') 
        state.keyUniqueCodes = []
      }

    },
    setOverlay (state, payload) {
      state.overlay = payload
    },
    setItemsModule (state, payload) {
      state.itemsModule = payload
    }
  },
  actions: {
    loadLoggedIn ({commit}, payload) {
      commit('setLoggedIn', payload)
    },
    loadKeyPass ({commit}, payload) {
      commit('setKeyPass', payload)
    },
    loadKeyUniqueCodes ({commit}, payload) {
      commit('setKeyUniqueCodes', payload)
    },
    loadViewPage ({commit}, payload) {
      commit('setViewPage', payload)
    },
    loadViewData ({commit}, payload) {
      commit('setViewData', payload)
    },
    loadImageHeight ({commit}, payload) {
      commit('setImageHeight', payload)
    },
    loadUserData ({commit}, payload) {
      commit('setUserData', payload)
    },
    loadLoadData ({commit}, payload) {
      commit('setLoadData', payload)
    },
    loadMessage ({commit}, payload) {
      commit('setMessage', payload)
    },
    loadLoadRoute ({commit}, payload) {
      commit('setLoadRoute', payload)
    },
    loadOverlay ({commit}, payload) {
      commit('setOverlay', payload)
    },
    loadItemsModule ({commit}, payload) {
      commit('setItemsModule', payload)
    },
    loadUpPage () {
      document.body.scrollTop = 0
      document.documentElement.scrollTop = 0
    },
    loadAxData (){
      alert('Ax')
    }
  },
  getters: {
    getUrlApi (state) {
      // return state.hostName
      if (state.hostName === 'localhost'){
        return (state.protocol + state.hostName + 
                state.portNumber + state.apiRoute)
      } else {
        // return state.hostName.split('.')
        return (state.protocol + 
                state.hostName.replace(state.appName, state.apiName) + 
                state.apiRoute)
      }
    },
    getJson_Snackbar (state) {
      return state.json_Snackbar
    },
    getLabelBar (state) {
      return state.labelBar
    },
    getLoadData (state) {
      return state.loadData
    },
    getUserData (state) {
      return state.userData
    },
    getOverlay (state) {
      return state.overlay
    },
    getItemsModule (state) {
      return state.itemsModule
    },
    getLoggedIn (state) {
      return state.loggedIn
    },
    getKeyPass (state) {
      return state.keyPass
    },
    getAppName (state) {
      return state.appName
    },
    getLoadRoute (state) {
      return state.loadRoute
    },
    getKeyUniqueCodes (state) {
      return state.keyUniqueCodes
    },
    getViewPage (state) {
      return state.viewPage
    },
    getViewData (state) {
      return state.viewData
    },
    getImageHeight (state) {
      return state.imageHeight
    }
  },
  modules: {
    //
  }
})
