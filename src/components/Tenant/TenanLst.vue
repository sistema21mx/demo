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
                <v-btn icon dark v-on="on" @click="printFile();">
                  <v-icon>local_printshop</v-icon>
                </v-btn>
              </template>
              <span>Imprimir Lista</span>
            </v-tooltip>
            <v-tooltip bottom>
              <template v-slot:activator="{ on }">
                <v-btn icon dark v-on="on" @click="newItem();">
                  <v-icon>add</v-icon>
                </v-btn>
              </template>
              <span>Nuevo</span>
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
          <template v-slot:item.closed="{ item }" v-if="loading===false">
            <v-icon  color="green darken-2" v-if="item.closed === '1' ">done</v-icon>
            <v-icon  color="red darken-2" v-else>clear</v-icon>
          </template>
          <template v-slot:item.action="{ item }" v-if="loading===false">
            <v-tooltip bottom>
              <template v-slot:activator="{ on }">
                <v-icon  class="mr-2" @click="edit(item)" v-on="on" color="blue darken-2">
                  edit
                </v-icon>
              </template>
              <span>Editar</span>
            </v-tooltip>
          </template>
        </v-data-table>
        
      </v-card>

  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'

export default {
  name: 'TenantLst',
  mixins: [mixshared],
  // props: [''],
  components: {
    //
  },
  data: () => ({
    //
    headers: [
      {
        text: 'Nombre',
        align: 'left',
        sortable: true,
        value: 'name',
        width: '1'
      },
      {
        text: 'Movil',
        align: 'left',
        sortable: true,
        value: 'movil',
        width: '1'
      },
      {
        text: 'Correo electrónico',
        align: 'left',
        sortable: true,
        value: 'email',
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
        text: 'Editar',
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
      const baseURI = await this.urlApi + '/tenantlist'
      const dataRespond = this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.retrieveData = await this.responseData.data
      this.responseData = await null
    },
    edit: function (val) {
      //
      let msg = 'Aviso: Editando, Por favor espere...'
      let type = 'info'
      this.$store.dispatch('loadMessage', { msg: msg, type: type })
      this.$emit('setEditedItem', val)
      this.$emit('pageChange', 2)
      this.$store.dispatch('loadUpPage')
    },
    newItem: function () {
      const item = {
        id: 0,
        // condominia_id: null,
        movil: null,
        email: null,
        name: null,
        //
        active: '1',
        user_id: this.userData.data.userId
      }
      this.$store.dispatch('loadUpPage')
      this.$emit('setEditedItem', item)
      this.$emit('pageChange', 2)
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