<template>
  <v-container>
    
    <v-img
      class="white--text align-end"
      :height="height"
      contain
      :src="require('../assets/yourlogo.png')"
      >
    </v-img>
    <v-text-field
      v-if="imageHeight!==null"
      label="Bearer"
      single-line
      v-model=loadKeyPass
      readonly
    ></v-text-field>

    <div class="text-center" v-if="loggedIn === 0">

      <v-form>
        <v-container>
          <v-row justify="center">

            <v-col cols="10" sm="6">
              <v-text-field
                id="email"
                name="email"
                v-on:keyup="keymonitor"
                prepend-icon="person"
                type="text"
                :hint="`${hintEmail}`"
                dense
                clearable
                persistent-hint

                v-model="logDetails.email"
                label="Usuario"
                outlined
              ></v-text-field>
            </v-col>

            <v-col cols="10" sm="6">
              <v-text-field
                id="password"
                name="password"
                v-on:keyup="keymonitor"
                prepend-icon="lock"
                :append-icon="showPass ? 'mdi-eye' : 'mdi-eye-off'"
                :type="showPass ? 'password' : 'password'"
                :hint="`${hintPass}`"
                dense
                clearable
                persistent-hint
                @click:append="showPass = !showPass"

                v-model="logDetails.password"
                label="Contraseña"
                outlined
              ></v-text-field>
            </v-col>

          </v-row>
        </v-container>
      </v-form>
      <v-btn rounded color="primary" dark
        @click.stop="checkLogin();"
        >
        Entrar
      </v-btn>

    </div>









  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'

export default {
  name: 'Home',
  mixins: [mixshared],
  // props: [''],
  components: {
    //
  },
  data: () => ({
    //
    height: '0%',
    hintEmail: '',
    hintPass: '',
    showPass: false,

    logDetails: {
      email: '', 
      password: '',
      evento: ''
    },
  }),
  methods: {
    initialize: function () {
      //
    },
    checkLogin: function () {
      this.logDetails.evento = ''
      this.logDetails.email = this.logDetails.email.replace(/^\s+|\s+$/gm, '')
      this.logDetails.password = this.logDetails.password.replace(/^\s+|\s+$/gm, '')
      if (this.loadData !== 1 && Number(this.loggedIn) === 0) {
        this.$store.dispatch('loadUpPage')
      }
      if (this.logDetails.email === '' && this.logDetails.password === '') {
        document.getElementById('email').focus()
        this.logDetails.evento = 'Aviso: Ingresar Email'
        this.$store.dispatch('loadMessage', { msg: this.logDetails.evento, type: 'error' })
      }
      if (this.logDetails.email === '' && this.logDetails.password !== '') {
        document.getElementById('email').focus()
        this.logDetails.evento = 'Aviso: Ingresar Email'
        this.$store.dispatch('loadMessage', { msg: this.logDetails.evento, type: 'error' })
      }
      if (this.logDetails.email !== '' && this.logDetails.password === '') {
        document.getElementById('password').focus()
        this.logDetails.evento = 'Aviso: Ingresar Contraseña'
        this.$store.dispatch('loadMessage', { msg: this.logDetails.evento, type: 'error' })
      }
      sessionStorage.setItem('localLogDetails', JSON.stringify(this.logDetails))
      if (this.logDetails.evento !== '') {
        this.logDetails.evento = this.logDetails.evento + ' ' + this.logDetails.email
        // this.$store.dispatch('loadBitacora', this.logDetails)
        this.logDetails.evento = ''
      }
      if (this.logDetails.email !== '' && this.logDetails.password !== '') {
        // this.$store.dispatch('loadLogDetails', this.logDetails)
        this.userIn()
      }
      this.$store.dispatch('loadUpPage')
      //
    },
    userIn: async function () {
      this.btnLoad = true
      await this.getData()
      await this.processData()
      this.$store.dispatch('loadOverlay', true)
    },
    getData: async function () {
      const methodWay = this.methodWay
      const baseURI = this.urlApi + '/login'
      const dataRespond = this.typeDataRespond
      const formData = this.logDetails
      const jwToken = await this.loadKeyPass // this.userData.data.token
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
    },
    processData: async function () {
      if (this.loadData===0){
        this.$store.dispatch('loadMessage', { msg: this.responseData.message, type: 'error' })
        return
      }
      if (this.loadData===1){
        if (this.responseData.error === 1) {
          this.$store.dispatch('loadMessage', { msg: this.responseData.message, type: 'error' })
          this.btnLoad = false
          return
        }
        if (this.responseData.error === 0) {
          this.$store.dispatch('loadMessage', { msg: this.responseData.message, type: 'info' })
          this.logDetails.password = ''
          this.logDetails.email = ''
          sessionStorage.setItem('localLogDetails', JSON.stringify(this.logDetails))
          this.$store.dispatch('loadKeyPass', this.responseData.data.token)
          sessionStorage.setItem('localKeyPass', JSON.stringify(this.loadKeyPass))
          delete this.responseData.data.token
          this.$store.dispatch('loadUserData', this.responseData)
          this.$store.dispatch('loadLoggedIn', 1)
          this.responseData = ''
          sessionStorage.removeItem('localLogDetails')
        }
      }
    },
    keymonitor: function (event) {
      if (event.key === 'Enter' && this.btnLoad === false) {
        this.checkLogin()
      }
    },
  },
  created () {
    //
  },
  mounted () {
    //
    if(Number(this.loggedIn)===1){
      this.height='400px'
    }
    if(Number(this.loggedIn)===0){
      this.height='200px'
    }
    if (sessionStorage.getItem('localLogDetails')) {
      const localLogDetails = JSON.parse(sessionStorage.getItem('localLogDetails'))
      if (localLogDetails.email !== '') { this.logDetails.email = localLogDetails.email }
      if (localLogDetails.password !== '') { this.logDetails.password = localLogDetails.password }
      if (localLogDetails.usr_id !== '') { this.logDetails.usr_id = localLogDetails.usr_id }
    }
    setTimeout(() => {
      if ( this.loggedIn === 0  ) { 
        this.getFocus('email')
      }
    }, 1000)
  },
  updated () {
    //
    if(Number(this.loggedIn)===1){
      this.height='400px'
    }
    if(Number(this.loggedIn)===0){
      this.height='200px'
    }
  },
  watch: {
    //
    'logDetails.email' (val) {
      if(val!==null){this.hintEmail = val} else { this.hintEmail = ''}
    },
    'logDetails.password' (val) {
      if(val!==null && this.showPass!==false){
        this.hintPass = val
      } else {
        this.hintPass = ''
      }
    },
    showPass (val) {
      if (val===true){
        this.hintPass = this.logDetails.password
      } else {
        this.hintPass = ''
      }
    },
    loggedIn (val) {
      if(val===0){
        this.btnLoad = false
      }
    }
  },
  computed: {
    //
    loggedIn () {
      return this.$store.getters.getLoggedIn
    },
    classObject: function () {
      return {
        'headline': this.imageHeight === 'sm' ? true : false,
        'subtitle-1': this.imageHeight !== 'sm' ? true : false,
      }
    },
  }
}
</script>