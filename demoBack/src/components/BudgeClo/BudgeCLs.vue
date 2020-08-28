<template>
  <v-container>

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
                <v-btn icon dark v-on="on" @click="saveStat();">
                  <v-icon>save</v-icon>
                </v-btn>
              </template>
              <span>Salvar</span>
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
        <v-data-table
          :headers="headers"
          :items="retrieveData"
          :items-per-page="itemsPerPage"
          :page.sync="page"
          class="elevation-1"
          :search="search"
          :loading="loading"
          hide-default-footer
          dense
          @page-count="pageCount = $event"
          >
          <template v-slot:item.status="{ item }" v-if="loading===false">
            <v-icon  color="green darken-2" v-if="item.active === '1' ">done</v-icon>
            <v-icon  color="red darken-2" v-else>clear</v-icon>
          </template>
          <template v-slot:item.statclosed="{ item }" v-if="loading===false">
            <v-icon  color="green darken-2" v-if="item.closed === '1' ">done</v-icon>
            <v-icon  color="red darken-2" v-else>clear</v-icon>
          </template>
          <template v-slot:item.action="{ item }" v-if="loading===false">
            <v-chip small outlined  color="green" :input-value="item.closedStat" filter v-if="item.closedStat === true " @click="editStat(item);"> Cerrada </v-chip>
            <v-chip small outlined  color="red" :input-value="item.closedStat" filter v-else @click="editStat(item);"> Abierta </v-chip>

          </template>
        </v-data-table>
        
      </v-card>
  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'

export default {
  name: 'BudgeLst',
  mixins: [mixshared],
  // props: [''],
  components: {
    //
  },
  data: () => ({
    //
    headers: [
      {
        text: 'Codigo',
        align: 'left',
        sortable: true,
        value: 'code',
        width: '1'
      },
      {
        text: 'Nombre',
        align: 'left',
        sortable: true,
        value: 'name',
        width: '1'
      },
      {
        text: 'Año',
        align: 'center',
        sortable: true,
        value: 'year',
        width: '1'
      },
      {
        text: 'Monto',
        value: 'netAmt',
        sortable: true,
        align: 'right',
        width: '1'
      },
      {
        text: 'Cerrado',
        value: 'statclosed',
        sortable: false,
        align: 'center',
        width: '1'
      },
      {
        text: 'Activo',
        value: 'status',
        sortable: false,
        align: 'center',
        width: '1'
      },
      {
        text: 'Cerrar',
        value: 'action',
        sortable: false,
        align: 'center',
        width: '1'
      }
    ]
  }),
  methods: {
    initialize: async function () {
      //
      await this.getList()
    },
    getList: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/budgetlist'
      const dataRespond = this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.retrieveData = await this.responseData.data
      this.responseData = await []
    },
    saveStat: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/budgetsaveStat'
      const dataRespond = this.typeDataRespond
      // this.editedItem.user_id = await this.userData.data.userId
      const formData = await this.retrieveData
      const jwToken = await this.loadKeyPass
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      let type = 'info'
      if(this.responseData.error===0){ type = 'info' } else { type = 'error' }
      await this.$store.dispatch('loadMessage', { msg: this.responseData.message, type: type })
      await this.getList()
      // this.responseData = await []
    },
    editStat: function (val) {
      val.closedStat = !val.closedStat
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
  }
}
</script>