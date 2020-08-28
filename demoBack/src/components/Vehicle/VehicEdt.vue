<template>
  <v-container>

      <v-card>
        <v-card-title class="primary darken-1">
          <span class="subtitle-2 white--text">{{ formTitle }}</span>
          <v-spacer></v-spacer>
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn dark icon @click.stop="closEditDialog();" v-on="on">
                <v-icon>mdi-chevron-left</v-icon>
              </v-btn>
            </template>
            <span>Salir</span>
          </v-tooltip>&nbsp;
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn dark icon @click.stop="editFocus('text_code');" v-on="on" v-show="!isEditing">
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

                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_code" ref="text_code" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.code" label="Placa"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="8">
                  <v-text-field id="text_description" ref="text_description" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.description" label="Descripción"></v-text-field>
                </v-col>
                
                <v-col cols="12" sm="6" md="8">
                  <v-text-field id="text_parkingspace" ref="text_parkingspace" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.parkingspace" label="Caja estacionamiento"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-select id="text_active" ref="text_active" 
                    v-model="editedItem.active"
                    label="Es Activo?"
                    :items="selectItemYN"
                    :disabled="!isEditing"
                    item-text="item"
                    item-value="val"
                  ></v-select>
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
  name: 'VehicEdt',
  mixins: [mixshared],
  props: ['item'],
  components: {
    //
  },
  data: () => ({
    //
  }),
  methods: {
    initialize: async function () {
      //
      this.editedItem = await this.item
      this.editedItem.user_id = await this.userData.data.userId
      if(await this.editedItem.id===0){
        this.isEditing = await true
        await this.editFocus('text_code')
      }
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
            this.closEditDialog()
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
        this.editedItem.code = this.trimField(this.editedItem.code)
        this.editedItem.description = this.trimField(this.editedItem.description)
        
        let isValid = true
        let message = null


        if (this.editedItem.code === null && message === null) {
          message = 'Aviso: Ingresar Placa'
          document.getElementById('text_code').focus()
        }
        if (this.editedItem.description === null && message === null) {
          message = 'Aviso: Ingresar Descripcion'
          document.getElementById('text_description').focus()
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
      const baseURI = await this.urlApi + '/vehicleupdate'
      const dataRespond = this.typeDataRespond
      const formData = await this.editedItem
      const jwToken = await this.loadKeyPass
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.responseData = await []
    },
    createRow: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/vehiclecreate'
      const dataRespond = await this.typeDataRespond
      this.editedItem.user_id = await this.userData.data.userId
      const formData = await this.editedItem
      const jwToken = await this.loadKeyPass // this.userData.data.token
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.responseData = await []
    },
    keymonitor: function (event) {
      if (event.key === 'Enter') {
        this.savEdit()
      }
    },
    processData: function () {
      //
    }
  },
  created () {
    //
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