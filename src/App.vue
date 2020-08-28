<template>
  <v-app>
    <v-app-bar
      v-if="loggedIn === 1"
      app
      color="primary"
      dark
      >
      <v-btn text color="white" small
        :min-height="0" :min-width="0" @click.stop="openMenu()"
        >
        <v-icon>list</v-icon>Menu
      </v-btn>
      <!-- v-app-bar-nav-icon @click.stop="openMenu()"></v-app-bar-nav-icon -->
      <!-- v-toolbar-title>Title</v-toolbar-title -->
      <span class="caption font-weight-medium font-italic">{{ this.userData.data.dateStrNow }}</span>
      <v-avatar v-if="loadData === 1" size="20" color="green" >
        <v-icon dark small>swap_vert</v-icon>
      </v-avatar>
      <v-avatar v-if="loadData === 0" size="20" color="red" >
        <v-icon dark small>swap_vert</v-icon>
      </v-avatar>
      
      <DiV v-if="imageHeight!==null">{{ imageHeight }}-{{ appName }}-{{ loadRouteName }}</DiV>
      
    </v-app-bar>



    <v-navigation-drawer app
      v-model="drawer"
      v-if="loggedIn === 1"
      width="300"
      >
      <v-list-item @click="drawer = false">
        <v-list-item-avatar>
          <v-img :src="require('@/assets/avatar01.png')">
          </v-img>
        </v-list-item-avatar>
        <v-list-item-title>
          <span class="caption font-weight-medium font-italic">{{ userData.data.name }}</span>
        </v-list-item-title>
      </v-list-item>
      <v-divider></v-divider>

      <v-list dense>
        <v-list-group
          v-for="item in itemsModule"
          :key="item.title"
          v-model="item.active"
          :prepend-icon="item.action"
          no-action
          >
          <template v-slot:activator>
            <v-list-item-content>
              <v-list-item-title v-text="item.title"></v-list-item-title>
            </v-list-item-content>
          </template>
          <v-list-item
            v-for="subItem in item.items"
            :key="subItem.title" link
            
            @click="selectMenu({ route: subItem.link, param: {}, title: subItem.description })"
            >
            <v-list-item-title  v-text="subItem.title"
              >
            </v-list-item-title>
              <v-list-item-action>
                <v-icon v-text="subItem.icon"></v-icon>
              </v-list-item-action>            
          </v-list-item>
        </v-list-group>
      </v-list>

      <v-list dense>
        <v-list-item
          v-for="item in itemsMenu"
          :key="item.title"
          link
          @click="selectMenu({ route: item.act, param: {}, title: item.title })"
          >
          <v-list-item-icon>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>{{ item.title }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>

    <v-main class="pa-10 ma-0">
      <router-view/>
    </v-main>

    <v-row v-if="dialogPass" justify="center">
      <v-dialog v-model="dialogPass" persistent max-width="600px">
        <v-card>
          <v-card-title>
            <span class="headline">Cambiar contraseña</span>
          </v-card-title>
          <v-card-text>
            <v-container>
              <v-row>

                <v-col cols="12">
                  <v-text-field id="text_oldPass" ref="text_oldPass" v-on:keyup="keymonitor" :rules="[rules.required]"
                    v-model="oldPass" label="Contraseña actual" 
                    clearable
                    prepend-icon="lock"
                    :append-icon="showPass ? 'mdi-eye' : 'mdi-eye-off'"
                    :type="showPass ? 'password' : 'password'"
                    :hint="`${hintoldPass}`"
                    persistent-hint
                    @click:append="showPass = !showPass"
                    ></v-text-field>
                </v-col>
                <v-col cols="12">
                  <v-text-field id="text_newPass" ref="text_newPass" v-on:keyup="keymonitor" :rules="[rules.required]"
                    v-model="newPass" label="Nueva contraseña"
                    clearable
                    prepend-icon="lock"
                    :append-icon="showPass ? 'mdi-eye' : 'mdi-eye-off'"
                    :type="showPass ? 'password' : 'password'"
                    :hint="`${hintnewPass}`"
                    persistent-hint
                    @click:append="showPass = !showPass"
                    ></v-text-field>

                </v-col>
                <v-col cols="12">
                  <v-text-field id="text_conPass" ref="text_conPass" v-on:keyup="keymonitor" :rules="[rules.required]"
                    v-model="conPass" label="Confirmar la nueva contraseña"
                    clearable
                    prepend-icon="lock"
                    :append-icon="showPass ? 'mdi-eye' : 'mdi-eye-off'"
                    :type="showPass ? 'password' : 'password'"
                    :hint="`${hintconPass}`"
                    persistent-hint
                    @click:append="showPass = !showPass"
                    ></v-text-field>
                </v-col>

              </v-row>
            </v-container>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn color="blue darken-1" text @click="savePass();">Guardar</v-btn>
            <v-btn color="blue darken-1" text @click="dialogPass = false">Cancelar</v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-row>

    <v-dialog v-model="dialog" persistent max-width="290">
      <v-card>
        <v-card-title class="headline">Aviso:</v-card-title>
        <v-card-text>Realmente desea Salir del Sistema.</v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="green darken-1" text @click="dialogOff('Cancelar')">Cancelar</v-btn>
          <v-btn color="green darken-1" text @click="dialogOff('Aceptar')">Aceptar</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>


    <v-footer app v-if="loggedIn === 0"
      color="primary lighten-1"
      padless
      >
      <v-row
        justify="center"
        no-gutters
        >
        <v-btn
          v-for="link in footlinks"
          :key="link.title"
          @click="footLaunch(link.action)"
          color="white"
          text
          rounded
          class="my-2"
          >
          {{ link.title }}
        </v-btn>
        <v-col
          class="primary lighten-2 py-4 text-center white--text"
          cols="12"
          >
          {{ new Date().getFullYear() }} — <strong>fmassoft</strong>
          {{ imageHeight }} @ {{ appName }} - {{ browserName }}
        </v-col>
      </v-row>
    </v-footer>


    <v-overlay :value="overlay">
      <v-progress-circular indeterminate size="100"></v-progress-circular>
    </v-overlay>


    <v-snackbar
      v-model="json_snackbar.snackbar"
      :bottom="false"
      :color="json_snackbar.color"
      :left="false"
      :multi-line="false"
      :right="false"
      :timeout="json_snackbar.timeout"
      :top="true"
      :vertical="false"
      >
      {{ json_snackbar.text }}
    </v-snackbar>
    


  </v-app>
</template>
<script>
import {mixshared} from '@/mixins/mixshared.js'
export default {
  name: 'App',
  mixins: [mixshared],
  // props: [''],
  components: {
    //
  },
  data: () => ({
    //
    // drawer: false,
    group: null,
    //
    dialog: false,
    //
    dialogPass: false,
    oldPass: '',
    newPass: '',
    conPass: '',
    showPass: false,
    hintoldPass: '',
    hintnewPass: '',
    hintconPass: '',
    //
    footlinks: [
      { title: 'Nuestro Equipo', action: 'https://fmassoft.com/' },
      { title: 'Contacto', action: 'https://api.whatsapp.com/send?phone=524425473828&text=' },
    ],
    itemsMenu: [
      // { title: 'Contacto', icon: 'perm_phone_msg', act: 'Contacto' },
      { title: 'Contraseña', icon: 'mdi-key-variant', act: 'Contraseña' },
      { title: 'Salir', icon: 'exit_to_app', act: 'Salir' }
    ]
  }),
  methods: {
    openMenu: function () {
      //
      document.documentElement.scrollTop = 0
      this.drawer = true
      // this.showForm = false
    },
    dialogOn: function () {
      this.dialog = true
    },
    dialogOff: function (val) {
      if (val === 'Cancelar'){
        this.dialog = false
      }
      if (val === 'Aceptar'){
        this.checkLogout()
        this.dialog = false
      }
    },
    savePass: async function () {
      this.$store.dispatch('loadUpPage')
      let message = ''
      let type = 'info'
      if(await this.validationFields()){
        this.$store.dispatch('loadOverlay', true)
        await this.setPass()
        if(await this.loadData===1 && await this.responseData.length !== 0){
          message = this.responseData.message
          if(this.responseData.error===0){
           // this.closEditDialog()
           this.dialogPass = false
          } else {
            type = 'error'
          }
        } else {
          type = 'error'
          message = 'Error: No actualizo el registro'
        }
        await this.$store.dispatch('loadMessage', { msg: message, type: type })
        if(await this.responseData.column){
          await this.getFocus(this.responseData.column)
        }
      }
    },
    validationFields: async function () {
      this.oldPass = await this.trimField(this.oldPass)
      this.newPass = await this.trimField(this.newPass)
      this.conPass = await this.trimField(this.conPass)

      let message = await null
      let isValid = await true
      if(await this.oldPass===null && await message === null){
          message = await 'Aviso: Ingresar contraseña actual'
          await document.getElementById('text_oldPass').focus()
      }
      if(await this.newPass===null && await message === null){
          message = await 'Aviso: Ingresar nueva contraseña'
          await document.getElementById('text_newPass').focus()
      }
      if(await this.conPass===null && await message === null){
          message = await 'Aviso: Ingresar confirmación de la contraseña'
          await document.getElementById('text_conPass').focus()
      }
      if((await this.newPass!==this.conPass)){
        message = await 'Error. La nueva contraseña no coincide con la confirmación'
      }
      if(await message!==null){
        await this.$store.dispatch('loadMessage', { msg: message, type: 'error' })
        isValid = await false
      }
      return isValid
    },
    setPass: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/setpass'
      const dataRespond = this.typeDataRespond
      const formData = await {
        id: this.userData.data.userId,
        oldPass: this.oldPass,
        newPass: this.newPass,
        // conPass: this.conPass
      }
      const jwToken = await this.loadKeyPass // this.userData.data.token
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.responseData = await []
    },
    keymonitor: function (event) {
      if (event.key === 'Enter' && this.btnLoad === false) {
        this.savePass()
      }
    },
    menus: async function () {
      await this.getMenu()
      await this.$store.dispatch('loadItemsModule', this.responseData.data)
      // this.responseData = await []
    },
    getMenu: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/profile/' + this.userData.data.userId
      const dataRespond = this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
    },
    selectMenu: function (item) {
      this.drawer = false
      if (item.title === 'Salir') {
        this.$store.dispatch('loadLoadRoute', { route: 'Home', param: {}, title: null })
        this.dialogOn()
        return
      }
      if (item.title === 'Contraseña') {
        this.$store.dispatch('loadLoadRoute', { route: 'Home', param: {}, title: null })
        this.dialogPass=true
        return
      }
      this.$store.dispatch('loadLoadRoute', item)
    },
    footLaunch: function (val) {
      if (val !== '') {
        window.open(val, '_blank')
      }
    }
  },
  created () {
    //
  },
  mounted () {
    //
    this.$store.dispatch('loadOverlay', true)
    if (sessionStorage.getItem('localUserData')) {
      const localUserData = JSON.parse(sessionStorage.getItem('localUserData'))
      this.$store.dispatch('loadUserData', localUserData)
      this.$store.dispatch('loadMessage', { msg: 'Aviso: RE Iniciando Sesion', type: 'info' })
      if (localUserData.error === 0) {
        this.$store.dispatch('loadLoggedIn', 1)
      }
    }
    if (sessionStorage.getItem('localLabelBar')) {
      const localLabelBar = JSON.parse(sessionStorage.getItem('localLabelBar'))
      this.$store.dispatch('loadLoadRoute', { route: localLabelBar.route, param: localLabelBar.param, title: localLabelBar.title })
    }
    if (sessionStorage.getItem('localKeyPass')) {
      const localKeyPass = JSON.parse(sessionStorage.getItem('localKeyPass'))
      this.$store.dispatch('loadKeyPass', localKeyPass)
    }
    if ( this.loggedIn === 0  ) { 
      if(this.$route.name !== 'Home'){
        this.loadRoute({ route: 'Home', param: {}, title: '' })
      }
    }
    this.$store.dispatch('loadImageHeight', this.breakpointName )
    this.browserName = this.browserDetect()
  },
  updated () {
    //
  },
  watch: {
    //
    breakpointName (val) {
      this.$store.dispatch('loadImageHeight', val )
    },
    overlay (val) {
      val && setTimeout(() => {
        this.$store.dispatch('loadOverlay', false)
      }, 1000)
    },
    loggedIn (val) {
      if(val===1){
        if(this.userData.error===0){
          this.menus()
        }
      }
    },
    oldPass (val) {
      if(val!==null && this.showPass!==false){
        this.hintoldPass = val
      } else {
        this.hintoldPass = ''
      }
    },
    newPass (val) {
      if(val!==null && this.showPass!==false){
        this.hintnewPass = val
      } else {
        this.hintnewPass = ''
      }
    },
    conPass (val) {
      if(val!==null && this.showPass!==false){
        this.hintconPass = val
      } else {
        this.hintconPass = ''
      }
    },
    showPass (val) {
      if (val===true){
        this.hintoldPass = this.oldPass
        this.hintnewPass = this.newPass
        this.hintconPass = this.conPass
      } else {
        this.hintoldPass = ''
        this.hintnewPass = ''
        this.hintconPass = ''
      }
    },
    dialogPass (val) {
      if(val===true){
        setTimeout(() => {
          document.getElementById('text_oldPass').focus()
        }, 1000)
      }
    },
  },
  computed: {
    //
    breakpointName () {
      if(this.urlApi.includes('localhost')){
        return this.$vuetify.breakpoint.name
      } 
      return null
    },
    json_snackbar () {
      return this.$store.getters.getJson_Snackbar
    },
    loggedIn () {
      return this.$store.getters.getLoggedIn
    },
    menuAdm () {
      return this.$store.getters.getUserData.menuAdm
    },
    menuCat () {
      return this.$store.getters.getUserData.menuCat
    },
    menuReg () {
      return this.$store.getters.getUserData.menuReg
    },
    menuCon () {
      return this.$store.getters.getUserData.menuCon
    },
    overlay () {
      return this.$store.getters.getOverlay
    },
    itemsModule () {
      return this.$store.getters.getItemsModule
    },
    footer () {
      return this.$store.getters.getFooter
    },
    loadRouteName () {
      return this.$store.getters.getLoadRoute.route
    }
  }
}
</script>
<!-- style>
#app {
    background-color: var(--v-background-base);
}
</style -->
<style lang='scss' src="./scss/main.scss"></style>