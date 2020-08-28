<template>
  <v-container>
    <v-layout justify-center>
      <v-flex xs12 sm12 md12>
        <v-card-title>
          <div class="flex-grow-1"></div>
          <v-flex xs5 md5>
            <v-text-field
              v-model="search"
              append-icon="search"
              label="Buscar"
              single-line
              hide-details
              clearable
            ></v-text-field>
          </v-flex>&nbsp;

          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn color="primary" fab small v-on="on" @click="createPdf();">
                <v-icon>local_printshop</v-icon>
              </v-btn>
            </template>
            <span>Imprimir Lista</span>
          </v-tooltip>&nbsp;

          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn color="primary" fab small v-on="on" @click="newItem();">
                <v-icon>add</v-icon>
              </v-btn>
            </template>
            <span>Nuevo</span>
          </v-tooltip>&nbsp;

          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn color="primary" fab small v-on="on" @click="exitHome();">
                <v-icon>keyboard_arrow_left</v-icon>
              </v-btn>
            </template>
            <span>Salir</span>
          </v-tooltip>&nbsp;

        </v-card-title>
        <v-card>
          <v-card flat>
            <div class="light-blue darken-4 white--text text-xs-center">&nbsp;&nbsp;
              <span class="caption font-weight-medium font-italic">Lista de Usuarios</span>
            </div>
          </v-card>
          <v-data-table
            :headers="headers"
            :items="data"
            :items-per-page="itemsPerPage"
            :page.sync="page"
            class="elevation-1"
            :search="search"
            :loading="loading"
            hide-default-footer
            dense
            @page-count="pageCount = $event"
          >

            <template v-slot:item.status="{ item }" v-if="loading===false">
              <v-icon  color="green darken-2" v-if="item.active === 'Si' ">done</v-icon>
              <v-icon  color="red darken-2" v-else>clear</v-icon>
            </template>

            <template v-slot:item.action="{ item }" v-if="loading===false">
              <v-tooltip bottom>
                <template v-slot:activator="{ on }">
                  <v-icon  class="mr-2" @click="editItem(item)" v-on="on" color="blue darken-2">
                    edit
                  </v-icon>
                </template>
                <span>Editar Usuario</span>
              </v-tooltip>
            </template>

          </v-data-table>
          <div class="text-center pt-2" @click="pageUp();">
            <v-pagination v-model="page" :length="pageCount" 
              >
            </v-pagination>
          </div>
        </v-card>
      </v-flex>
    </v-layout>

    <v-dialog v-model="editDialog" max-width="80%" persistent >
      <v-card>
        <v-card-title class="headline grey lighten-2" primary-title>
          <span class="headline">{{ formTitle }}
          </span>
        </v-card-title>

        <v-card-text>
          <v-container>
            <v-form>
              <v-row>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_email" ref="text_email" v-on:keyup="keymonitor" :rules="[rules.required]"
                    hint="Email" persistent-hint
                    v-model="editedItem.email" label="Email"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_firstname" ref="text_firstname" v-on:keyup="keymonitor" :rules="[rules.required]"
                    v-model="editedItem.firstname" label="Nombre"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_midname" ref="text_midname" v-on:keyup="keymonitor"
                    v-model="editedItem.midname" label="Paterno"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_lastnamme" ref="text_lastname" v-on:keyup="keymonitor"
                    v-model="editedItem.lastname" label="Materno"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_movil" ref="text_movil" v-on:keyup="keymonitor" counter maxlength="10"
                    v-model="editedItem.movil" label="Movil"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_password" ref="text_password" v-on:keyup="keymonitor" 
                    
                    v-model="editedItem.password" label="Contraseña"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-select id="text_active" ref="text_active" 
                    v-model="editedItem.active"
                    :items="components"
                    label="Es Activo?"
                  ></v-select>
                </v-col>
              </v-row>
            </v-form>
          </v-container>
        </v-card-text>

        <v-card-actions>
          <div class="flex-grow-1"></div>
          <v-btn color="blue darken-1" text @click="closeDialog();">Cancelar</v-btn>
          <v-btn color="blue darken-1" text @click="savEditDialog();" id="BtnEditAcept" ref="BtnEditAcept">Aceptar</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>


    <v-dialog v-model="confirmDialog" persistent max-width="290">
      <v-card>
        <v-card-title class="title">{{ dialogComponent.title }}</v-card-title>
        <v-card-text class="body-2">
          {{ dialogComponent.msg }}
        </v-card-text>
        <v-card-actions>
          <div class="flex-grow-1"></div>
          <v-btn v-if="dialogComponent.button1 !== ''" color="blue darken-1" text @click="dialogButton(dialogComponent.action1)">{{ dialogComponent.button1 }}</v-btn>
          <v-btn v-if="dialogComponent.button2 !== ''" color="blue darken-1" text @click="dialogButton(dialogComponent.action2)">{{ dialogComponent.button2 }}</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    
  </v-container>
</template>

<script>
// import sharedMethods  from '@/components/shared/sharedMethods.js'
import {mixshared} from '@/mixins/mixshared.js'
export default {
  mixins: [mixshared],
  name: 'Usuario',
  data: () => ({
    //
    data: [{
      id: '',
      sysname: '',
      email: '',
      firstname: '',
      midname: '',
      lastname: '',
      names: '',
      movil: '',
      password: '',
      active: ''
    }],
    editedItem: {
      id: '',
      sysname: '',
      email: '',
      firstname: '',
      midname: '',
      lastname: '',
      names: '',
      movil: '',
      password: '',
      active: 'Si'
    },
    defaultItem: {
      id: '0',
      sysname: '',
      email: '',
      firstname: '',
      midname: '',
      lastname: '',
      names: '',
      movil: '',
      password: '',
      active: 'Si'
    },
    //
    itemRow: [],
    //
    editDialog: false,
    confirmDialog: false,
    dialogComponent: {action: '', title: 'Aviso', msg: 'Mensaje', 
      button1: 'Cancelar', button2: 'Aceptar', 
      action1:'Cancelar', action2:'Aceptar'
      // action1:'closeConfirmDialog', action2:'saveConfirmDialog'
    },
    defaultComponent: {action: '', title: 'Aviso', msg: 'Mensaje', 
      button1: 'Cancelar', button2: 'Aceptar', 
      action1:'Cancelar', action2:'Aceptar'
    },
    headers: [
      {
        text: 'Usuario',
        align: 'left',
        sortable: true,
        value: 'email',
        width: '1'
      },
      {
        text: 'Nombre',
        align: 'left',
        sortable: true,
        value: 'names',
        width: '1'
      },
      {
        text: 'Activo',
        value: 'status',
        sortable: false,
        align: 'left',
        width: '1'
      },		
      {
        text: 'Editar',
        value: 'action',
        sortable: false,
        align: 'action',
        width: '1'
      }
    ],
    components: [
      'Si', 'No'
    ] // revisar

  }),
  methods: {
    createPdf: function () {
    },    
    dialogButton: function (val) {
      if (val === 'Cancelar' && this.dialogComponent.action === 'inactivaUsuario') { 
        // this.$store.dispatch('loadDialog', false) 
        this.$store.dispatch('loadMessage', { msg: 'Procedimiento cancelado', type: 'info' })
        this.itemRow = []
        this.dialogComponent = this.defaultComponent
      }
      if (val === 'Aceptar' && this.dialogComponent.action === 'inactivaUsuario' ) { 
        // this.$store.dispatch('loadDialog', false); this.checkLogout() 
        this.$store.dispatch('loadMessage', { msg: 'Usuario Inactivo', type: 'success' })
        this.itemRow = []
        this.dialogComponent = this.defaultComponent
      }
      this.showConfirmDialog(false)
    },
    keymonitor: function (event) {
      if (event.key === 'Enter') {
        this.savEditDialog()
      }
    },
    validationFields: function () {

        this.editedItem.email = this.trimField(this.editedItem.email)
        this.editedItem.firstname = this.trimField(this.editedItem.firstname)
        this.editedItem.midname = this.trimField(this.editedItem.midname)
        this.editedItem.lastname = this.trimField(this.editedItem.lastname)
        this.editedItem.movil = this.trimField(this.editedItem.movil)
        this.editedItem.password = this.trimField(this.editedItem.password)
        this.editedItem.active = this.trimField(this.editedItem.active)

        let message = ''
        let isValid = true

        if (this.editedItem.email === '' && message === '') {
          message = 'Aviso: Ingresar Usuario'
          document.getElementById('text_email').focus()
        }
        
        if (this.editedItem.firstname === '' && message === '') {
          message = 'Aviso: Ingresar Nombre'
          document.getElementById('text_firstname').focus()
        }
        
        if (this.editedItem.password === '' && message === '' && this.editedIndex === -1) {
          message = 'Aviso: Ingresar Contraseña'
          document.getElementById('text_password').focus()
        }

        if(message!==''){
          this.$store.dispatch('loadMessage', { msg: message, type: 'error' })
          isValid = false
        }
        if(message===''){
          //
        }
        return isValid
    },
    usersList: async function () {
      await this.getList()
    },
    getList: async function () {
      //
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/userlist'
      const dataRespond = this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.data = await this.responseData.data
      this.responseData = await []
    },
    updateUser: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/userupdate'
      const dataRespond = this.typeDataRespond
      const formData = await this.editedItem
      const jwToken = await this.loadKeyPass // this.userData.data.token
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.responseData = await []
    },
    createUser: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/usercreate'
      const dataRespond = this.typeDataRespond
      const formData = await this.editedItem
      const jwToken = await this.loadKeyPass // this.userData.data.token
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.responseData = await []
    },
    showEditDialog: async function (val) {
      this.editDialog = await val
    },
    showConfirmDialog: function (val) {
      this.confirmDialog = val
    },
    newItem: async function () {
      await this.showEditDialog(true)
      setTimeout(() => {
        this.getFocus('text_email')
      }, 1000)
    },
    editItem: async function (item) {
      //
      this.editedIndex = this.data.indexOf(item)
      this.editedItem = Object.assign({}, item)
      await this.showEditDialog(true)
      setTimeout(() => {
        this.getFocus('text_email')
      }, 1000)
    },
    initialize: function () {
      //
    },
    closeConfirmDialog: function () {
      this.showConfirmDialog(false)
    },
    saveConfirmDialog: function () {
      this.showConfirmDialog(false)
    },
    closeDialog: function () {
      this.showEditDialog(false)
      setTimeout(() => {
        this.editedItem = Object.assign({}, this.defaultItem)
        this.editedIndex = -1
      }, 300)
    },
    savEditDialog: async function () {
      let message = ''
      let type = 'info'
      if(this.validationFields()){
        // 
        this.$store.dispatch('loadOverlay', true)
        if (this.editedIndex > -1) {
          await this.updateUser()
        } else {
          await this.createUser()
        }
        if(await this.loadData===1){
          message = this.responseData.message
          if(this.responseData.error===0){
            await this.usersList()
            this.closeDialog()
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
        this.responseData = await []
      }
    },
  },
  created () {
  },
  mounted () {
    // setTimeout(() => { this.loading = false }, 1000)
    this.usersList()
  },
  updated () {
  },
  watch: {
    editDialog (val) {
      val || this.closeDialog()
    }
  },
  computed: {
    //
    formTitle: function () {
      return this.editedIndex === -1 ? 'Nuevo Registro' : 'Editar Registro'
    },

  }
}
</script>