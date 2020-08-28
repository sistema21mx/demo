<template>
  <v-container>

      <v-card>
        <v-card-title class="primary darken-1">
          <span class="subtitle-2 white--text">{{ formTitle }}</span>
          <v-spacer></v-spacer>
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn dark icon @click.stop="closeForm();" v-on="on">
                <v-icon>mdi-chevron-left</v-icon>
              </v-btn>
            </template>
            <span>Salir</span>
          </v-tooltip>&nbsp;
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn dark icon @click.stop="editFocus('text_name');" v-on="on" v-show="!isEditing">
                <v-icon>mdi-pencil</v-icon>
              </v-btn>
            </template>
            <span>Editar</span>
          </v-tooltip>&nbsp;
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn dark icon @click.stop="savEdit();" v-on="on" v-show="isEditing">
                <v-icon>check</v-icon>
              </v-btn>
            </template>
            <span>Salvar</span>
          </v-tooltip>&nbsp;
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-form>
              <v-row>

                <v-col cols="12" sm="12" md="12">
                  <v-text-field id="text_name" ref="text_name" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.name" label="Nombre"></v-text-field>
                </v-col>
                <v-col cols="12" sm="12" md="12">
                  <v-text-field id="text_address" ref="text_address" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.address" label="Dirección"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="6">
                  <v-text-field id="text_url" ref="text_url" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.url" label="URL"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="6">
                  <v-text-field id="text_webpage" ref="text_webpage" v-on:keyup="keymonitor" :disabled="!isEditing"
                    v-model="editedItem.webpage" label="Pagina Web"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="6">
                  <v-text-field id="text_email" ref="text_email" v-on:keyup="keymonitor" :disabled="!isEditing"
                    v-model="editedItem.email" label="Email"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="6">
                  <v-text-field id="text_management" ref="text_management" v-on:keyup="keymonitor" :disabled="!isEditing"
                    v-model="editedItem.management" label="Administradora"></v-text-field>
                </v-col>


              </v-row>
            </v-form>
          </v-container>
        </v-card-text>

      </v-card>

  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'

export default {
  name: 'ResidEdt',
  mixins: [mixshared],
  props: ['item'],
  components: {
    //
  },
  data: () => ({
    //
    editedItem: {},
  }),
  methods: {
    initialize: async function () {
      //
      this.editedItem.id = await 0
      this.editedItem.name = await null
      this.editedItem.address = await null
      this.editedItem.url = await null
      await this.getResidence()
      this.editedItem.user_id = await this.userData.data.userId
      this.$emit('setEditedItem', this.editedItem)
      if(await this.editedItem.id===0){
        await this.editFocus('text_name')
      }
    },
    getResidence: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/residencelist'
      const dataRespond = this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.editedItem = await this.responseData.data[0]
      this.responseData = await null
    },
    savEdit: async function () {
      this.$store.dispatch('loadUpPage')
      let message = ''
      let type = 'info'
      if(await this.validationFields()){
        //
        this.$store.dispatch('loadOverlay', true)
        if (await this.editedItem.id !== 0) {
          await this.updateRow()
        } else {
          await this.createRow()
        }
        if(await this.loadData===1 && await this.responseData.length !== 0){
          message = this.responseData.message
          if(this.responseData.error===0){
            // this.closEditDialog()
            this.isEditing=false
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
    validationFields: function () {
        this.editedItem.name = this.trimField(this.editedItem.name)
        this.editedItem.address = this.trimField(this.editedItem.address)
        this.editedItem.url = this.trimField(this.editedItem.url)

        let isValid = true
        let message = null


        if (this.editedItem.name === null && message === null) {
          message = 'Aviso: Ingresar Nombre'
          document.getElementById('text_name').focus()
        }
        if (this.editedItem.address === null && message === null) {
          message = 'Aviso: Ingresar Dirección'
          document.getElementById('text_address').focus()
        }
        if (this.editedItem.url === null && message === null) {
          message = 'Aviso: Ingresar URL'
          document.getElementById('text_url').focus()
        }
        //
        if(message!==null){
          this.$store.dispatch('loadMessage', { msg: message, type: 'error' })
          isValid = false
        }
        return isValid
    },
    updateRow: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/residenceupdate'
      const dataRespond = await this.typeDataRespond
      const formData = await this.editedItem
      const jwToken = await this.loadKeyPass
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.responseData = await []
    },
    keymonitor: function (event) {
      if (event.key === 'Enter') {
        this.savEdit()
      }
    },
    closeForm: function () {
      //
      if(this.isEditing===true){
        this.$store.dispatch('loadMessage', 
          { msg: 'Aviso: Se cancelo actualizar registro.', type: 'error' }
        )
      }
      setTimeout(() => {
        this.exitHome()
      }, 1000)
    },
    processData: function () {
      //
    }
  },
  created () {
    //
    // this.editedItem = this.item
  },
  mounted () {
    //
    this.initialize()
  },
  updated () {
    //
  },
  watch: {
    //
  },
  computed: {
    //
    formTitle: function () {
      return this.editedItem.id === 0 ? this.labelBar + ' (Nuevo)' : this.labelBar + ' (Editando)' 
    }
  }
}
</script>