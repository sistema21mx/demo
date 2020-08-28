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
                {{ timeIn }} {{ timeOut }}
          <v-container>
            <v-form>
              <v-row>

                <v-col cols="12" sm="7" md="7">
                  <v-text-field id="text_name" ref="text_name" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.name" label="Visitante"></v-text-field>
                </v-col>
                <v-col cols="12" sm="5" md="5">
                  <v-text-field id="text_reference" ref="text_reference" v-on:keyup="keymonitor" :disabled="!isEditing"
                    v-model="editedItem.reference" label="Referencia"></v-text-field>
                </v-col>

                <v-col cols="12" sm="12" md="12">
                  <h4>Departamento</h4>
                  <v-select2 
                    class="style-chooser"
                    placeholder="Elija un Departamento"
                    v-model="editedItem.condominia_id" 
                    :options="optSelectcondominia_id" 
                    :reduce="opt => opt.val" 
                    :filterable="true"
                    :disabled="!isEditing"
                    id="text_condominia_id" ref="text_condominia_id"
                    label="opt">
                    <div slot="no-options">No existe coincidencia!</div>
                  </v-select2>
                </v-col>

                <v-col cols="12" sm="4" md="4">
                  <v-text-field id="text_datedoc" ref="text_datedoc" v-on:keyup="keymonitor" readonly
                    v-model="editedItem.datedoc" label="Fecha Ingreso"></v-text-field>
                </v-col>

                <v-col cols="12" sm="4" md="4">
                  <h4>Entrada</h4>
                  <vue-timepicker v-model="timeIn" format="hh:mm A" hide-clear-button advanced-keyboard :blur-delay="500" id="text_datein" name="text_datein"></vue-timepicker>
                </v-col>
                
                <v-col cols="12" sm="4" md="4">
                  <h4>Salida</h4>
                  <vue-timepicker v-model="timeOut" format="hh:mm A" hide-clear-button advanced-keyboard :blur-delay="500" id="text_dateout" name="text_dateout"></vue-timepicker>
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
import VueTimepicker from 'vue2-timepicker'
import 'vue2-timepicker/dist/VueTimepicker.css'

export default {
  name: 'VisitEdt',
  mixins: [mixshared],
  props: ['item'],
  components: {
    VueTimepicker
  },
  data: () => ({
    //
    optSelectcondominia_id: [
      {opt: 'Leyendo', val: ''}
    ],
    today: null,
    timeIn: {
      hh: '12',
      mm: '00',
      ss: '00',
      A: 'AM'
    },
    timeOut: {
      hh: '12',
      mm: '00',
      ss: '00',
      A: 'AM'
    },
  }),
  methods: {
    initialize: async function () {
      //
      this.editedItem = await this.item
      this.editedItem.user_id = await this.userData.data.userId
      await this.getcondominia_id()
      if(await this.editedItem.condominia_id!==null){
        this.editedItem.condominia_id = await Number(this.editedItem.condominia_id)
      }
      if(await this.editedItem.id===0){
        this.editedItem.datedoc = await this.getToday()
      }
      if(await this.editedItem.datein===null){
        this.today = await this.getToday()
        let time = new Date();
        let h = time.getHours()
        let m = time.getMinutes()
        let s = time.getSeconds()
        this.editedItem.isoIn = this.today + ' ' + this.leadZero(h,2) + ':' + this.leadZero(m,2) + ':' + this.leadZero(s,2)
        let ampm = h >= 12 ? 'PM' : 'AM'
        h = h % 12
        h = h ? h : 12
        this.timeIn.hh = this.leadZero(h,2)
        this.timeIn.mm = this.leadZero(m,2)
        this.timeIn.ss = this.leadZero(s,2)
        this.timeIn.A = ampm
      }
      if(await this.editedItem.datein!==null){
        //
        this.today = this.editedItem.datedoc
        if(this.editedItem.hhin==='00'){
          this.timeIn.hh = '12'
        } else {
          this.timeIn.hh = await this.leadZero((this.editedItem.hhin % 12),2)
        }
        this.timeIn.mm = await this.leadZero((this.editedItem.mmin),2)
        this.timeIn.ss = await '00'
        this.timeIn.A = this.editedItem.hhin >= 12 ? 'PM' : 'AM'
        if(this.editedItem.dateout===null){
          //
          let time = new Date();
          let h = time.getHours()
          let m = time.getMinutes()
          let s = time.getSeconds()
          this.editedItem.isoOut = this.getToday() + ' ' + this.leadZero(h,2) + ':' + this.leadZero(m,2) + ':' + this.leadZero(s,2)
          let ampm = h >= 12 ? 'PM' : 'AM'
          h = h % 12
          h = h ? h : 12
          this.timeOut.hh = this.leadZero(h,2)
          this.timeOut.mm = this.leadZero(m,2)
          this.timeOut.ss = this.leadZero(s,2)
          this.timeOut.A = ampm
        } else {
          //
          this.today = this.editedItem.datedoc
          if(this.editedItem.hhout==='00'){
            this.timeOut.hh = '12'
          } else {
            this.timeOut.hh = await this.leadZero((this.editedItem.hhout % 12),2)
          }
          this.timeOut.mm = await this.leadZero((this.editedItem.mmout),2)
          this.timeOut.ss = await '00'
          this.timeOut.A = this.editedItem.hhout >= 12 ? 'PM' : 'AM'
        }
      }




      this.isEditing = await true
    },
    getcondominia_id: async function () {
      //
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/condominiaids'
      const dataRespond = await this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.optSelectcondominia_id = await this.responseData.data
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
        this.editedItem.name = this.trimField(this.editedItem.name)
        this.editedItem.datedoc = this.trimField(this.editedItem.datedoc)
        this.editedItem.condominia_id = this.trimField(this.editedItem.condominia_id)
        // this.editedItem.datedoc = this.trimField(this.editedItem.datedoc)


        let isValid = true
        let message = null

        if (this.editedItem.name === null && message === null) {
          message = 'Aviso: Ingresar Visitante'
          document.getElementById('text_name').focus()
        }
        if (this.editedItem.datedoc === null && message === null) {
          message = 'Aviso: Ingresar Fecha Ingreso'
          document.getElementById('text_datedoc').focus()
        }
        if (this.editedItem.condominia_id === null && message === null) {
          message = 'Aviso: Ingresar Departamento'
          document.getElementById('text_condominia_id').focus()
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
      const baseURI = await this.urlApi + '/visitupdate'
      const dataRespond = this.typeDataRespond
      const formData = await this.editedItem
      const jwToken = await this.loadKeyPass
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.responseData = await []
    },
    createRow: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/visitcreate'
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
    timeIn(val){
      //
      if(val.hh!=='12' && val.mm!=='00' && val.ss!=='00' && val.A!=='AM'){
        let hh = val.hh
        if(val.A==='PM'){
          hh = parseInt(hh) + 12
        }
        this.editedItem.isoIn = this.today + ' ' + this.leadZero(hh,2) + ':' + this.leadZero(val.mm,2) + ':' + this.leadZero(0,2)
      }
    },
    timeOut(val){
      //
      if(val.hh!=='12' && val.mm!=='00' && val.ss!=='00' && val.A!=='AM'){
        let hh = val.hh
        if(val.A==='PM'){
          hh = parseInt(hh) + 12
        }
        this.editedItem.isoOut = this.today + ' ' + this.leadZero(hh,2) + ':' + this.leadZero(val.mm,2) + ':' + this.leadZero(0,2)
      }
    }
  },
  computed: {
    //
    formTitle: function () {
      return this.editedItem.id === 0 ? this.labelBar + ' (Nuevo)' : this.labelBar + ' (Editando)' 
    }
  }
}
</script>
<style>
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
