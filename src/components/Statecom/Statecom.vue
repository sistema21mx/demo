<template>
  <v-container>
    <SystemBr ma-0 pa-0 />
      <DiV v-if="imageHeight!==null">{{ items }}</DiV>
      <v-select2 
        class="style-chooser"
        placeholder="Elija una Unidad"
        v-model="condominia_id" 
        :options="optSelectcondominia_id" 
        :reduce="opt => opt.val" 
        :filterable="true"
        id="text_condominia_id" ref="text_condominia_id"
        label="opt">
        <div slot="no-options">No existe coincidencia!</div>
      </v-select2>
      <v-data-table
        :headers="headers"
        :items="items"
        :dense="dense"
        :fixed-header="fixedHeader"
        sort-by="datedoc"
        hide-default-footer
        class="elevation-1"
      ></v-data-table>
      <v-row>

        <v-col cols="12" sm="4">
          <v-text-field
            v-model="charges"
            label="Cargos"
            outlined
            dense
          ></v-text-field>
        </v-col>
        <v-col cols="12" sm="4">
          <v-text-field
            v-model="credits"
            label="Abonos"
            outlined
            dense
          ></v-text-field>
        </v-col>
        <v-col cols="12" sm="4">
          <v-text-field
            v-model="balance"
            label="Saldo final"
            outlined
            dense
          ></v-text-field>
        </v-col>

      </v-row>

  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'
import SystemBr from '@/components/Shared/SystemBr'
import 'vue-select/dist/vue-select.css';

export default {
  name: 'Statecom',
  mixins: [mixshared],
  // props: [''],
  components: {
    SystemBr,
  },
  data: () => ({
    //
    dense: true,
    fixedHeader: true,
    condominia_id: null,
    credits: 0,
    charges: 0,
    balance: 0,
    headers: [
      {
        text: 'Fecha',
        align: 'start',
        value: 'datedoc',
      },
      { text: 'Tipo', value: 'type' },
      { text: 'Concepto', value: 'concept' },
      { text: 'Cargo', value: 'charge' },
      { text: 'Abono', value: 'credit' },
      { text: 'Status', value: 'status' },
    ],
    items: [
      {
        datedoc: null,
        type: null,
        concept: null,
        charge: null,
        credit: null,
        status: null,
      },
    ],
    optSelectcondominia_id: [
      {opt: 'Elija un departamento', val: null}
    ],
  }),
  methods: {
    initialize: async function () {
      //
      this.items = await []
      await this.getcondominia_id()
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
    getQuotas: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/condominiaQuotastate'
      const dataRespond = await this.typeDataRespond
      const formData = await {id: this.condominia_id}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      // this.retrieveData = await this.responseData.data
      this.items = await this.items.concat(this.responseData.data)
      this.responseData = await null
    },
    getDeposit: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/depositstate'
      const dataRespond = this.typeDataRespond
      const formData = await {id: this.condominia_id}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      // this.retrieveData = await this.responseData.data
      this.items = await this.items.concat(this.responseData.data)
      this.responseData = await null
    },
    listing: async function () {
      //
      await this.getQuotas()
      await this.getDeposit()
      let charges = await 0; let credits = await 0
      for (var i = await 0; i < await this.items.length; await i++){
        if(typeof(this.items[i].charge)=== await 'string'){
          charges += await Number(this.items[i].charge.replace(/[^0-9.-]+/g,""))
        }
        if(typeof(this.items[i].charge)=== await 'number'){
          charges += await this.items[i].charge
        }
        if(typeof(this.items[i].credit)=== await 'string'){
          credits += await Number(this.items[i].credit.replace(/[^0-9.-]+/g,""))
        }
        if(typeof(this.items[i].credit)=== await 'number'){
          credits += await this.items[i].credit
        }
      }
      this.charges = await charges
      this.credits = await credits
      this.balance = await (this.credits - this.charges)
      this.charges = await this.getcurrencyFormat(this.charges)
      this.credits = await this.getcurrencyFormat(this.credits)
      this.balance = await this.getcurrencyFormat(this.balance)
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
    condominia_id(val){
      this.items = []
      this.charges = 0; this.credits = 0; this.balance = 0;
      if(val!==null){
        this.listing()
      }
    }
  },
  computed: {
    //
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
