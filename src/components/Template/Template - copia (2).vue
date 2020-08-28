<template>
  <v-container >

  <v-data-table
    v-model="selected"
    :headers="headers"
    :items="desserts"
    :single-select="singleSelect"
    :search="search"
    ref="table"
    item-key="ship_id"
    dense
    multi-sort
    show-select
    hide-default-footer
    class="elevation-1"
  >
    <template v-slot:top>
      <!-- v-switch v-model="singleSelect" label="Single select" class="pa-0"></v-switch -->

  <v-card class="d-inline-block mx-auto " color="#FFFFFF"
    
  >
        <v-card-text>
          <v-container>
            <v-form >
              <v-row >


                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_selectAmt" ref="text_selectAmt" readonly
                    v-model="selectAmt" label="Monto Seleccionado"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_totalAmt" ref="text_totalAmt" readonly
                    v-model="totalAmt" label="Monto Total"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">

      <v-text-field
        v-model="search"
        append-icon="search"
        label="Buscar"
        single-line
        hide-details
      ></v-text-field>
                </v-col>

              </v-row>
            </v-form>
          </v-container>
        </v-card-text>
  </v-card>


    </template>

      <template slot="items" slot-scope="props">
        <tr class='grey lighten-2'>
          <td>
            <strong>Mean:</strong>
          </td>
          
          <td>
            {{ props.item.ship_id }}*
          </td>
        </tr>
        <tr class='grey lighten-2'>
          <td>
            <strong>Median:</strong>
          </td>
          <td>
            *
          </td>
        </tr>
        <tr class='grey lighten-2'>
          <td>
            <strong>SD:</strong>
          </td>
          <td>
            *
          </td>
        </tr>
        <tr class='grey lighten-2'>
          <td>
            <strong>Range:</strong>
          </td>
          <td >
            *
          </td>
        </tr>
      </template>



  </v-data-table>
  refs * {{  }} *
  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'

export default {
  name: '',
  mixins: [mixshared],
  // props: [''],
  components: {
    //
  },
  data: () => ({
    //
    selectAmt: 0,
    totalAmt: 0,
    search: 'S04',
    //
    singleSelect: false,
    selected: [],
    headers: [
      {
        text: 'Folio',
        align: 'left',
        sortable: true,
        value: 'ship_id',
      },
      { text: 'Fecha', value: 'shipDate' },
      { text: 'Descripción', value: 'description' },
      { text: 'Total', value: 'total' },
      { text: 'Sem.', value: 'week' },
      
    ],
    desserts: [
      {
        ship_id: 1,
        shipDate: '0000/00/00',
        description: 'number one',
        total: 0,
        week: 0,


      },
      {
        ship_id: 2,
        shipDate: '0000/00/00',
        description: 'number two',
        total: 0,
        week: 0,

      },
    ],
  }),
  methods: {
    initialize: async function () {
      //
      await this.getList()
      await this.getTotal()
    },
    getList: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/invoiceships'
      const dataRespond = this.typeDataRespond
      const formData = await {}
      const jwToken = await this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.desserts = await this.responseData.data
      // this.responseData = await null
    },
    total1: function () {
      // const table = this.$refs.table
      // console.log('table',table)
      // return [column.value]
      // return this.$refs.table.items
      return 0
    },
    total1old: function (column) {
      const table = this.$refs.table
      //console.log('table',table)
      return table ? table.filteredItems.reduce((s, i) => {
        return s + parseInt(i[column.value], 10)
      }, 0) : 0
    },


    initializeold: function () {
      //
    },
    getTotal: function () {
      //
      this.totalAmt = 0
      for (var i = 0; i < this.desserts.length; i++) {
        this.totalAmt += Number(this.desserts[i].total.replace(/[^0-9.-]+/g,""))
      }
      this.totalAmt = this.totalAmt.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,')
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
    selected (val) {
      //
      let totalAmt = 0
      for (var i = 0; i < val.length; i++) {
        // totalAmt += Number(val.total.replace(/[^0-9.-]+/g,""))
        totalAmt += Number(val[i].total.replace(/[^0-9.-]+/g,""))
      }
      totalAmt = totalAmt.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,')
      this.selectAmt = totalAmt
      val = []
    },
    search () {
      //
      this.selected = []
    },
    '$refs.table.filteredItems': function (value) {
        console.log(value);
    }

  },
  computed: {
    //
    selectAmtold: function () {
      return 0
    }
  }
}
</script>