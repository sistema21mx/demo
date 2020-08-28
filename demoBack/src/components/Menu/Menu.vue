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
              <span class="caption font-weight-medium font-italic">Lista de Opciones</span>
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
                  <v-text-field id="text_label" ref="text_label" v-on:keyup="keymonitor" :rules="[rules.required]"
                    hint="Etiqueta" persistent-hint
                    v-model="editedItem.label" label="Etiqueta"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_link" ref="text_link" v-on:keyup="keymonitor" :rules="[rules.required]"
                    v-model="editedItem.link" label="Link"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_description" ref="text_description" v-on:keyup="keymonitor"
                    v-model="editedItem.description" label="Descripcion"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_icon" ref="text_icon" v-on:keyup="keymonitor"
                    v-model="editedItem.icon" label="Icono"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-select id="text_type" ref="text_type" 
                    v-model="selectTypeOption"
                    :items="itemsTypeOptions"
                    item-text="label"
                    item-value="val"
                    label="Tipo de Opcion"
                    return-object
                  ></v-select>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-select id="text_active" ref="text_active" 
                    v-model="editedItem.active"
                    :items="selectItems"
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
  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'
// import sharedMethods  from '@/components/shared/sharedMethods.js'
export default {
  mixins: [mixshared],
  name: 'Menu',
  components: {
    //
  },
  data: () => ({
    data: [{
      type: '0',
      desctype: '',
      id: '',
      // orderlist: '',
      label: '',
      link: '',
      description: '',
      icon: '',
      active: 'Si'
    }],
    editedItem: {
      type: '0',
      desctype: '',
      id: '',
      // orderlist: '',
      label: '',
      link: '',
      description: '',
      icon: '',
      active: 'Si'
    },
    defaultItem: {
      type: '0',
      desctype: '',
      id: '',
      // orderlist: '',
      label: '',
      link: '',
      description: '',
      icon: '',
      active: 'Si'
    },
    headers: [
      {
        text: 'Tipo',
        align: 'left',
        sortable: true,
        value: 'desctype',
        width: '1'
      },
      {
        text: 'Etiqueta',
        align: 'left',
        sortable: true,
        value: 'label',
        width: '1'
      },
      {
        text: 'Descripción',
        align: 'left',
        sortable: true,
        value: 'description',
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
    //
    editDialog: false,
    selectItems: [
      'Si', 'No'
    ], // revisar
    selectTypeOption: { label: '', val: '0' },
    itemsTypeOptions: [
      { label: 'Elija...', val: '0' },
      { label: 'Sistema ', val: '1' },
      { label: 'Catálogo', val: '2' },
      { label: 'Registro', val: '3' },
      { label: 'Consulta', val: '4' }
    ]
  }),
  methods: {
    initialize: function () {
      //
    },
    menuList: async function () {
      //
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/menutypelist'
      const dataRespond = this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.data = await this.responseData.data
      this.responseData = await []
    },
    createPdf: function () {
    },
    newItem: async function () {
      this.selectTypeOption = await { label: '', val: '0' }
      await this.showEditDialog(true)
      setTimeout(() => {
        this.getFocus('text_label')
      }, 1000)
    },
    editItem: async function (item) {
      //
      this.editedIndex = await this.data.indexOf(item)
      this.editedItem = await Object.assign({}, item)
      this.selectTypeOption = await { label: '', 'val': String(this.editedItem.type) }
      await this.showEditDialog(true)
      setTimeout(() => {
        this.getFocus('text_label')
      }, 1000)
    },
    showEditDialog: async function (val) {
      this.editDialog = await val
    },
    closeDialog: function () {
      this.showEditDialog(false)
      setTimeout(() => {
        this.editedItem = Object.assign({}, this.defaultItem)
        this.editedIndex = -1
      }, 300)
    },
    keymonitor: function (event) {
      if (event.key === 'Enter') {
        this.savEditDialog()
      }
    },
    savEditDialog: async function () {
      //
      let message = ''
      let type = 'info'
      this.editedItem.type = this.selectTypeOption.val
      if(this.validationFields()){
        // 
        // this.$store.dispatch('loadOverlay', true)
        if (this.editedIndex > -1) {
          await this.updateUser()
        } else {
          await this.createUser()
        }
        if(await this.loadData===1){
          message = this.responseData.message
          if(this.responseData.error===0){
            await this.menuList()
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
        // this.responseData = await []
      }
    },
    validationFields: function () {

        this.editedItem.label = this.trimField(this.editedItem.label)
        this.editedItem.link = this.trimField(this.editedItem.link)
        this.editedItem.description = this.trimField(this.editedItem.description)
        this.editedItem.icon = this.trimField(this.editedItem.icon)
        this.editedItem.type = this.trimField(this.editedItem.type)
        this.editedItem.active = this.trimField(this.editedItem.active)

        let message = ''
        let isValid = true

        if (this.editedItem.label === '' && message === '') {
          message = 'Aviso: Ingresar Etiqueta'
          document.getElementById('text_label').focus()
        }
        
        if (this.editedItem.link === '' && message === '') {
          message = 'Aviso: Ingresar Link'
          document.getElementById('text_link').focus()
        }
        
        if (this.editedItem.description === '' && message === '') {
          message = 'Aviso: Ingresar Descripcion'
          document.getElementById('text_description').focus()
        }

        if (this.editedItem.type === '0' && message === '') {
          message = 'Aviso: Ingresar Tipo de Opción'
          document.getElementById('text_type').focus()
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
    updateUser: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/menupdate'
      const dataRespond = this.typeDataRespond
      const formData = await this.editedItem
      const jwToken = await this.loadKeyPass // this.userData.data.token
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.responseData = await []
    },
    createUser: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/menucreate'
      const dataRespond = this.typeDataRespond
      const formData = await this.editedItem
      const jwToken = await this.loadKeyPass // this.userData.data.token
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.responseData = await []
    }
    
    //
  },
  created () {
  },
  mounted () {
    this.menuList()
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
    }
  }
}
</script>