<template>
  <v-container>
    <SystemBr ma-0 pa-0 />

    <v-card>
      <v-card-title class="primary darken-1">
        <v-spacer></v-spacer>
        <v-flex xs6 sm5 md5>
          <v-text-field
            v-model="search"
            label="Buscar"
            dark
            flat
            dense
            solo-inverted
            hide-details
            clearable
            clear-icon="mdi-close-circle-outline"
            append-icon="search"
            >
          </v-text-field>
        </v-flex>
        <div class="mx-1"></div>

        <div class="text-center">
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn icon dark v-on="on" @click="printFile();">
                <v-icon>local_printshop</v-icon>
              </v-btn>
            </template>
            <span>Imprimir Lista</span>
          </v-tooltip>

          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn icon dark v-on="on" @click="exitHome();">
                <v-icon>keyboard_arrow_left</v-icon>
              </v-btn>
            </template>
            <span>Salir</span>
          </v-tooltip>
        </div>
      </v-card-title>
    </v-card>

    <v-data-table
      :headers="headers"
      :items="items"
      :single-expand="singleExpand"
      :expanded.sync="expanded"
      :search="search"
      :page.sync="page"
      :items-per-page="itemsPerPage"
      @page-count="pageCount = $event"
      dense
      multi-sort
      item-key="id"
      show-expand
      class="elevation-1"
      hide-default-footer
      >
      <template v-slot:expanded-item="{ item }">
        <td :colspan="headers.length">

          <tr>
            <td> Extra Info {{ item.vehicleCode }}
            </td>


          </tr>
        </td>
      </template>
    </v-data-table>
    
  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'
import SystemBr from '@/components/Shared/SystemBr'

export default {
  name: 'Expensej',
  mixins: [mixshared],
  // props: [''],
  components: {
    SystemBr,
  },
  data: () => ({
    //
    singleExpand: false,
    expanded: [],

    headers: [
      {
        text: 'Fecha',
        align: 'left',
        sortable: true,
        value: 'datedoc',
      },
      {
        text: 'Ppto',
        align: 'left',
        sortable: true,
        value: 'name',
      },
      {
        text: 'Descripcion',
        align: 'left',
        sortable: true,
        value: 'description',
      },
      {
        text: 'Proveedor',
        align: 'left',
        sortable: true,
        value: 'code',
      },
      {
        text: 'Monto',
        align: 'right',
        sortable: true,
        value: 'amount',
      },
      {
        text: 'Status',
        align: 'left',
        sortable: true,
        value: 'status',
      },
      { text: '', value: 'data-table-expand' },

    ],
    items: [
    ],
  }),
  methods: {
    initialize: function () {
      //
    },
    getList: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/expenselist'
      const dataRespond = await this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.items = await this.responseData.data
      this.responseData = await null
    },
    printFile: async function () {
      //
      // const methodWay = await this.methodWay
      // const baseURI = await this.urlApi + '/customerprint'
      // const dataRespond = 'blob' // this.typeDataRespond
      // const formData = await {nameBlade: 'customList'}
      // const jwToken = await this.loadKeyPass // this.userData.data.token
      // this.loading = await true
      this.$store.dispatch('loadOverlay', true)
      // await this.getAxPrint(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.loading = await false
      // this.retrieveData = await this.responseData.data
      // this.responseData = await null
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
    this.getList()
  },
  updated () {
    //
  },
  watch: {
    //
  },
  computed: {
    //
  }
}
</script>