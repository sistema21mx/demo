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
                  <v-text-field id="text_amount" ref="text_amount" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.amount" label="Cuota" :hint="`${hintcooperation}`" persistent-hint></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_dueDays" ref="text_dueDays" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.dueDays" label="Dias de pago"></v-text-field>
                </v-col>
                
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_percentagediscount" ref="text_percentagediscount" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.percentagediscount" label="% Descuento pronto pago"></v-text-field>
                </v-col>

                <v-col cols="12" sm="6" md="3">
                  <h4>Fondo destino</h4>
                  <v-select2 
                    class="style-chooser"
                    placeholder="Elija un fondo"
                    v-model="editedItem.fund_id" 
                    :options="optSelectfund_id" 
                    :reduce="opt => opt.val" 
                    :filterable="true"
                    :disabled="!isEditing"
                    id="text_fund_id" ref="text_fund_id"
                    label="opt">
                    <div slot="no-options">No existe coincidencia!</div>
                  </v-select2>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <h4>Clasificacion presupuestal</h4>
                  <v-select2 
                    class="style-chooser"
                    placeholder="Elija un presupuesto"
                    v-model="editedItem.budget_incomes_id" 
                    :options="optSelectbudget_incomes_id" 
                    :reduce="opt => opt.val" 
                    :filterable="true"
                    :disabled="!isEditing"
                    id="text_budget_incomes_id" ref="text_budget_incomes_id"
                    label="opt">
                    <div slot="no-options">No existe coincidencia!</div>
                  </v-select2>
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
import 'vue-select/dist/vue-select.css';

export default {
  name: 'QuotaEdt',
  mixins: [mixshared],
  props: ['item'],
  components: {
    //
  },
  data: () => ({
    //
    hintcooperation: '',
    optSelectfund_id: [
      {opt: 'Leyendo', val: null}
    ],
    optSelectbudget_incomes_id: [
      {opt: 'Leyendo', val: null}
    ],
  }),
  methods: {
    initialize: async function () {
      //
      await this.getfund_id()
      await this.getbudget_incomes_id()
      this.editedItem = await this.item
      this.editedItem.user_id = await this.userData.data.userId
      if(this.editedItem.fund_id!==null){
        this.editedItem.fund_id = await Number(this.editedItem.fund_id)
      }
      if(this.editedItem.budget_incomes_id!==null){
        this.editedItem.budget_incomes_id = await Number(this.editedItem.budget_incomes_id)
      }
      if(await this.editedItem.id===0){
        this.isEditing= await true
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
        this.editedItem.amount = this.trimField(this.editedItem.amount)
        this.editedItem.dueDays = this.trimField(this.editedItem.dueDays)
        this.editedItem.percentagediscount = this.trimField(this.editedItem.percentagediscount)
        

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
        if ((this.editedItem.amount === null && message === null) || (Number(this.editedItem.amount) === null) && message === null) {
          message = 'Aviso: Ingresar Cuota'
          document.getElementById('text_amount').focus()
        }
        if ((this.editedItem.percentagediscount === null && message === null) || (Number(this.editedItem.percentagediscount) === null) && message === null) {
          message = 'Aviso: Ingresar % Descuento'
          document.getElementById('text_percentagediscount').focus()
        }
        if (this.editedItem.dueDays === null && message === null) {
          message = 'Aviso: Ingresar dias de pago'
          document.getElementById('text_dueDays').focus()
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
      const baseURI = await this.urlApi + '/quotaupdate'
      const dataRespond = this.typeDataRespond
      // this.editedItem.datein = await this.editedItem.isoIn
      // this.editedItem.dateout = await this.editedItem.isoOut
      const formData = await this.editedItem
      const jwToken = await this.loadKeyPass
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.responseData = await []
    },
    createRow: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/quotacreate'
      const dataRespond = await this.typeDataRespond
      this.editedItem.user_id = await this.userData.data.userId
      const formData = await this.editedItem
      const jwToken = await this.loadKeyPass // this.userData.data.token
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.responseData = await []
    },
    getfund_id: async function () {
      //
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/fundids'
      const dataRespond = await this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.optSelectfund_id = await this.responseData.data
      this.responseData = await null
    },
    getbudget_incomes_id: async function () {
      //
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/budgetinids'
      const dataRespond = await this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.optSelectbudget_incomes_id = await this.responseData.data
      this.responseData = await null
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
    'editedItem.amount' (val) {
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
