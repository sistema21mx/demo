<template>
  <v-container>
      <v-card>
        <v-card-title class="primary darken-1">
          <span class="subtitle-2 white--text">{{ formTitle }}</span>
          <v-spacer></v-spacer>

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
              <v-btn dark icon @click.stop="confirmDialog();" v-on="on" v-show="isEditing">
                <v-icon>save</v-icon>
              </v-btn>
            </template>
            <span>Generar Cuotas</span>
          </v-tooltip>&nbsp;
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn dark icon @click.stop="exitHome();" v-on="on">
                <v-icon>mdi-chevron-left</v-icon>
              </v-btn>
            </template>
            <span>Salir</span>
          </v-tooltip>&nbsp;
        </v-card-title>
        <v-card-text>
          <v-container>
            
            <v-form>
              <v-row>

                <v-col cols="12" sm="6" md="4">
                  <v-dialog
                    ref="dialogdatedoc"
                    v-model="pickModaldatedoc"
                    :return-value.sync="editedItem.datedoc"
                    persistent
                    width="290px">
                    <template v-slot:activator="{ on }">
                      <v-text-field
                        id="text_datedoc" ref="text_datedoc"
                        v-model="editedItem.datedoc"
                        label="Fecha"
                        prepend-icon="event"
                        readonly
                        v-on="on"
                        :disabled="!isEditing"
                        hint="AAAA-MM-DD" persistent-hint
                      ></v-text-field>
                    </template>
                    <v-date-picker 
                      v-model="editedItem.datedoc" 
                      @input="$refs.dialogdatedoc.save(editedItem.datedoc);pickModaldatedoc = false"
                      >
                    </v-date-picker>
                  </v-dialog>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_datedue" ref="text_datedue" v-on:keyup="keymonitor" readonly
                    v-model="editedItem.datedue" label="Fecha Vencimiento"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_amount" ref="text_amount" v-on:keyup="keymonitor" readonly
                    v-model="editedItem.amount" label="Monto total de Cuotas"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="12">
                  <v-text-field id="text_description" ref="text_description" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.description" label="Descripcion"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="2">
                  <h4>Año</h4>
                  <v-select2 
                    class="style-chooser"
                    placeholder="Elija el Año"
                    v-model="editedItem.year" 
                    :options="optSelectYear" 
                    :reduce="opt => opt.val" 
                    :filterable="true"
                    :disabled="!isEditing"
                    id="text_year" ref="text_year"
                    label="opt">
                    <div slot="no-options">No existe coincidencia!</div>
                  </v-select2>
                </v-col>
                <v-col cols="12" sm="6" md="3">
                  <h4>Periodo</h4>
                  <v-select2 
                    class="style-chooser"
                    placeholder="Elija un periodo"
                    v-model="editedItem.period" 
                    :options="optSelectPeriod" 
                    :reduce="opt => opt.val" 
                    :filterable="true"
                    :disabled="!isEditing"
                    id="text_period" ref="text_period"
                    label="opt">
                    <div slot="no-options">No existe coincidencia!</div>
                  </v-select2>
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


              </v-row>
            </v-form>
          </v-container>
        </v-card-text>
        <v-data-table
          v-model="selected"
          :headers="headers"
          :items="items"
          :single-select="singleSelect"
          :items-per-page="itemsPerPage"
          hide-default-footer
          item-key="code"
          show-select
          dense
          class="elevation-1"
          >
        </v-data-table>
        
      </v-card>
      <Dialog01 :dialogForm="dialogForm" @getDialog="getDialog"/>
  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'
import 'vue-select/dist/vue-select.css';
import Dialog01 from '@/components/Shared/Dialog01'

export default {
  name: 'MonthfHd',
  mixins: [mixshared],
  props: ['item'],
  components: {
    Dialog01
  },
  data: () => ({
    //
    quotaRow: null,
    quotaCode: 'CuotaMensual',
    //
    pickModaldatedoc: false,
    optSelectYear: [
      {opt: 'Leyendo', val: null}
    ],
    optSelectPeriod: [
      {opt: 'Leyendo', val: null}
    ],
    optSelectfund_id: [
      {opt: 'Leyendo', val: null}
    ],
    optSelectbudget_incomes_id: [
      {opt: 'Leyendo', val: null}
    ],
    //
    singleSelect: false,
    selected: [],
    headers: [
      {
        text: 'Unidad',
        align: 'start',
        sortable: false,
        value: 'code',
      },
      { text: 'Propietario', value: 'ownerName' },
      { text: 'Tipo', value: 'description' },
      { text: 'Cuota', value: 'cooperation' },
    ],
    items: [
      {
        id: 1,
        owner: '',
        code: '',
        description: '',
        cooperation: '',
        protein: '',
        iron: '',
      },
    ],
    dialogForm: {
      title: 'Generar cuotas',
      text: 'Este proceso genera las cuotas para cada usuario seleccionado, confirme para continuar...',
      show: false,
    }

  }),
  methods: {
    initialize: async function () {
      //
      await this.getList()
      await this.getfund_id()
      await this.getbudget_incomes_id()
      await this.getquotacode()

      this.editedItem = await this.item
      this.editedItem.user_id = await this.userData.data.userId

      this.editedItem.fund_id = await this.quotaRow.fund_id
      this.editedItem.budget_incomes_id = await this.quotaRow.budget_incomes_id
      this.editedItem.dueDays = await this.quotaRow.dueDays
      this.editedItem.doctype = await this.quotaRow.code

      this.editedItem.datedoc = await this.getToday()
      if(await this.editedItem.fund_id!==null){
        this.editedItem.fund_id = await Number(this.editedItem.fund_id)
      }
      if(await this.editedItem.budget_incomes_id!==null){
        this.editedItem.budget_incomes_id = await Number(this.editedItem.budget_incomes_id)
      }
      this.isEditing = await true

    },
    getList: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/condominialist'
      const dataRespond = await this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.items = await this.responseData.data
      this.responseData = await null
    },
    confirmDialog: async function () {
      this.dialogForm.show = true
    },
    savEdit: async function () {
      //
      let isValid = await true
      if(await this.editedItem.year===null && isValid){
        isValid = await false
        let type = await 'error'
        let message = await 'Error: Debe de seleccionar el año para aplicar la cuota'
        await this.$store.dispatch('loadMessage', { msg: message, type: type })
      }
      if(await this.editedItem.period===null && isValid){
        isValid = await false
        let type = await 'error'
        let message = await 'Error: Debe de seleccionar el periodo para aplicar la cuota'
        await this.$store.dispatch('loadMessage', { msg: message, type: type })
      }
      if(await this.editedItem.fund_id===null && isValid){
        isValid = await false
        let type = await 'error'
        let message = await 'Error: Debe de seleccionar un fondo para aplicar la cuota'
        await this.$store.dispatch('loadMessage', { msg: message, type: type })
      }
      if(await this.editedItem.budget_incomes_id===null && isValid){
        isValid = await false
        let type = await 'error'
        let message = await 'Error: Debe de seleccionar un presupuesto para aplicar la cuota'
        await this.$store.dispatch('loadMessage', { msg: message, type: type })
      }
      if(await this.selected.length === await 0 && isValid ){
        isValid = await false
        let type = await 'error'
        let message = await 'Error: Debe de seleccionar al menos alguna unidad de la lista'
        await this.$store.dispatch('loadMessage', { msg: message, type: type })
      }
      if(await this.selected.length != await 0 && isValid ){
        const methodWay = await this.methodWay
        const baseURI = await this.urlApi + '/condominiaQuotacreate'
        const dataRespond = await this.typeDataRespond
        this.editedItem.data = await this.selected
        const formData = await this.editedItem
        const jwToken = await this.loadKeyPass
        await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
        let message = ''
        let type = 'info'
        if(await this.loadData===1 && await this.responseData.length !== 0){
          if(this.responseData.error===0){
            message = 'Aviso: Se generaron las cuotas con exito '
            type = 'info'
          } else {
            type = 'error'
            message = 'Error: No actualizo el registro'
          }
        }
        await this.$store.dispatch('loadMessage', { msg: message, type: type })
        await setTimeout(() => this.exitHome(), 4000)
      }

      // this.responseData = await []
    },
    getDialog: function (val) {
      if(val===true){
        this.savEdit()
      }
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
    getquotacode: async function () {
      //
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/quotafindrow/' + this.quotaCode
      const dataRespond = await this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.quotaRow = await this.responseData.data[0]
      this.responseData = await null
    },
    keymonitor: function (event) {
      if (event.key === 'Enter') {
        this.confirmDialog()
      }
    },
    processData: function () {
      //
    }
  },
  created () {
    //
    this.optSelectPeriod = [
      {opt: '01 Enero', val: 1}, {opt: '02 Febrero', val: 2}, {opt: '03 Marzo', val: 3},
      {opt: '05 Abril', val: 5}, {opt: '05 Mayo', val: 5}, {opt: '06 Junio', val: 6},
      {opt: '07 Julio', val: 7}, {opt: '08 Agosto', val: 8}, {opt: '09 Septiembre', val: 9},
      {opt: '10 Octubre', val: 10}, {opt: '11 Noviembre', val: 11}, {opt: '12 Diciembre', val: 12},
    ],
    this.optSelectYear = [
      {opt: '2020', val: 2020}, {opt: '2021', val: 2021}
    ]
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
    'editedItem.datedoc' (val) {
      if(val!==null){
        this.editedItem.year = Number(val.substring(-1, 4))
        this.editedItem.period = Number(val.substring(5, 7))
        this.editedItem.day = Number(val.substring(8, 10))
        this.editedItem.description = 'Cuota de Mnnto Mensual Periodo ' + this.editedItem.period + ' ' + this.editedItem.year
        let dueDate = new Date(this.editedItem.year, this.editedItem.period - 1, this.editedItem.day)
        if(dueDate!==null){
          // dueDate.setDate(dueDate.getDate() + this.editedItem.dueDays)
          dueDate.setDate(dueDate.getDate() + Number(this.editedItem.dueDays))
          this.editedItem.datedue = dueDate.toISOString().substring(0, 10)
        }
        this.selected = []
      }
    },
    selected (val){
      //
      let amt = 0
      for (var i = 0; i < val.length; i++) {
        amt += Number(val[i].cooperation.replace(/[^0-9.-]+/g,""))
      }
      this.editedItem.amount = amt.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,')
    }
  },
  computed: {
    //
    formTitle: function () {
      return this.labelBar 
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
