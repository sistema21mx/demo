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
                    v-model="editedItem.code" label="Codigo"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="8">
                  <v-text-field id="text_description" ref="text_description" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.description" label="Descripcion"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_cooperation" ref="text_cooperation" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.cooperation" label="Cuota mantenimiento" :hint="`${hintcooperation}`" persistent-hint></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
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
  name: 'CondTEdt',
  mixins: [mixshared],
  props: ['item'],
  components: {
    //
  },
  data: () => ({
    //
    hintcooperation: '',
  }),
  methods: {
    initialize: function () {
      //
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
        this.editedItem.description = this.trimField(this.editedItem.description)
        this.editedItem.code = this.trimField(this.editedItem.code)
        this.editedItem.cooperation = this.trimField(this.editedItem.cooperation)
        
        let isValid = true
        let message = null

        if (this.editedItem.code === null && message === null) {
          message = 'Aviso: Ingresar Codigo'
          document.getElementById('text_code').focus()
        }
        if (this.editedItem.description === null && message === null) {
          message = 'Aviso: Ingresar Descripcion'
          document.getElementById('text_description').focus()
        }

        if ((this.editedItem.cooperation === null && message === null) || (Number(this.editedItem.cooperation) === 0) && message === null) {
          message = 'Aviso: Ingresar Cuota mantenimiento'
          document.getElementById('text_cooperation').focus()
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
      const baseURI = await this.urlApi + '/condominiaTypeupdate'
      const dataRespond = this.typeDataRespond
      const formData = await this.editedItem
      const jwToken = await this.loadKeyPass
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.responseData = await []
    },
    createRow: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/condominiaTypecreate'
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
    this.editedItem = this.item
    this.editedItem.user_id = this.userData.data.userId
  },
  mounted () {
    //
    if(this.editedItem.id===0){
      this.editFocus('text_code')
    }
  },
  updated () {
    //
  },
  watch: {
    //
    'editedItem.cooperation' (val) {
      if(val!==null){
        this.hintcooperation = val.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
      } else { 
        this.hintcooperation = ''
      }
    },
  },
  computed: {
    //
    formTitle: function () {
      return this.editedItem.id === 0 ? this.labelBar + ' (Nuevo)' : this.labelBar + ' (Editando)' 
    }
  }
}
</script>