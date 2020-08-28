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

                <v-col cols="12" sm="6" md="6">
                  <v-text-field id="text_code" ref="text_code" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.code" label="Codigo"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="6">
                  <h4>Tipo departamento</h4>
                  <v-select2 
                    class="style-chooser"
                    placeholder="Elija tipo departamento"
                    v-model="editedItem.type" 
                    :options="optSelecttype" 
                    :reduce="opt => opt.val" 
                    :filterable="true"
                    :disabled="!isEditing"
                    id="text_type" ref="text_type"
                    label="opt">
                    <div slot="no-options">No existe coincidencia!</div>
                  </v-select2>
                  
                </v-col>
                <v-col cols="12" sm="6" md="6">
                  <h4>Propietario</h4>
                  <v-select2 
                    class="style-chooser"
                    placeholder="Elija propietario"
                    v-model="editedItem.owner_id" 
                    :options="optSelectowner_id" 
                    :reduce="opt => opt.val" 
                    :filterable="true"
                    :disabled="!isEditing"
                    id="text_owner_id" ref="text_owner_id"
                    label="opt">
                    <div slot="no-options">No existe coincidencia!</div>
                  </v-select2>
                </v-col>
                <v-col cols="12" sm="6" md="6">
                  <h4>Inquilino</h4>
                  <v-select2 
                    class="style-chooser"
                    placeholder="Elija inquilino"
                    v-model="editedItem.tenant_id" 
                    :options="optSelecttenant_id" 
                    :reduce="opt => opt.val" 
                    :filterable="true"
                    :disabled="!isEditing"
                    id="text_tenant_id" ref="text_tenant_id"
                    label="opt">
                    <div slot="no-options">No existe coincidencia!</div>
                  </v-select2>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-select id="text_occupied" ref="text_occupied" 
                    v-model="editedItem.occupied"
                    label="Es ocupado?"
                    :items="selectItemYN"
                    :disabled="!isEditing"
                    item-text="item"
                    item-value="val"
                  ></v-select>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-select id="text_active" ref="text_active" 
                    v-model="editedItem.active"
                    label="Es activo?"
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
import 'vue-select/dist/vue-select.css';

export default {
  name: 'CondoEdt',
  mixins: [mixshared],
  props: ['item'],
  components: {
    //
  },
  data: () => ({
    //
    optSelecttype: [
      {opt: 'Leyendo', val: null}
    ],
    optSelectowner_id: [
      {opt: 'Leyendo', val: null}
    ],
    optSelecttenant_id: [
      {opt: 'Leyendo', val: null}
    ],
  }),
  methods: {
    initialize: async function () {
      //
      await this.gettype()
      await this.getowner_id()
      await this.gettenant_id()
      this.editedItem = await this.item
      if(this.editedItem.owner_id!==null){
        this.editedItem.owner_id = await Number(this.editedItem.owner_id)
      }
      if(this.editedItem.tenant_id!==null){
        this.editedItem.tenant_id = await Number(this.editedItem.tenant_id)
      }
      if(this.editedItem.type!==null){
        this.editedItem.type = await Number(this.editedItem.type)
      }
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
        this.editedItem.owner_id = this.trimField(this.editedItem.owner_id)
        // this.editedItem.tenant_id = this.trimField(this.editedItem.tenant_id)
        this.editedItem.code = this.trimField(this.editedItem.code)
        this.editedItem.type = this.trimField(this.editedItem.type)
        
        let isValid = true
        let message = null


        if (this.editedItem.code === null && message === null) {
          message = 'Aviso: Ingresar Codigo'
          document.getElementById('text_code').focus()
        }
        if (this.editedItem.type === null && message === null) {
          message = 'Aviso: Ingresar Tipo de departamento'
          document.getElementById('text_type').focus()
        }
        if (this.editedItem.owner_id === null && message === null) {
          message = 'Aviso: Ingresar Propietario'
          document.getElementById('text_owner_id').focus()
        }
        /*
        if (this.editedItem.tenant_id === null && message === null) {
          message = 'Aviso: Ingresar Inquilino'
          document.getElementById('text_tenant_id').focus()
        }
        */
        //
        if(message!==null){
          this.$store.dispatch('loadMessage', { msg: message, type: 'error' })
          isValid = false
        }
        return isValid
    },
    updateRow: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/condominiaupdate'
      const dataRespond = this.typeDataRespond
      const formData = await this.editedItem
      const jwToken = await this.loadKeyPass
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.responseData = await []
    },
    createRow: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/condominiacreate'
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
    gettype: async function () {
      //
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/condominiaTypeids'
      const dataRespond = this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.optSelecttype = await this.responseData.data
      this.responseData = await null
    },
    getowner_id: async function () {
      //
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/ownerids'
      const dataRespond = this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.optSelectowner_id = await this.responseData.data
      this.responseData = await null
    },
    gettenant_id: async function () {
      //
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/tenantids'
      const dataRespond = this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.optSelecttenant_id = await this.responseData.data
      this.responseData = await null
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
<style scoped lang="scss">
  .style-chooser .vs__no-options{
    color: #ff6347;
    font-size: 14px;
  }
  .style-chooser .vs__dropdown-toggle{
    height: 28px;
    font-size: 14px;
  }
  .style-chooser .vs__search::placeholder,
  .style-chooser .vs__dropdown-menu {
    font-size: 14px;
  }
  .style-chooser .vs__clear,
  .style-chooser .vs__open-indicator {
    fill: #0000FF;
  }
</style>
