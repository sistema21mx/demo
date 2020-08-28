<template>
  <v-container>

    <v-layout justify-center>
      <v-flex xs12 sm12 md12>
        <v-card-title>
          <div class="flex-grow-1"></div>
          <v-flex xs5 md5>
            <v-text-field
              v-model="search"
              append-icon="search"
              label="Buscar"
              single-line
              hide-details
              clearable
            ></v-text-field>
          </v-flex>
          &nbsp;
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn color="primary" fab small v-on="on" @click="exitHome();">
                <v-icon>keyboard_arrow_left</v-icon>
              </v-btn>
            </template>
            <span>Salir</span>
          </v-tooltip>
          &nbsp;
        </v-card-title>
        <v-card>
          <v-card flat>
            <div class="light-blue darken-4 white--text text-xs-center">
              &nbsp;&nbsp;
              <span class="caption font-weight-medium font-italic">Lista de Usuarios</span>
            </div>
          </v-card>
          <v-data-table
            :headers="headers"
            :items="data"
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
              <v-icon  color="green darken-2" v-if="item.active === 'Si' ">done</v-icon>
              <v-icon  color="red darken-2" v-else>clear</v-icon>
            </template>

            <template v-slot:item.action="{ item }" v-if="loading===false">
              <v-tooltip bottom>
                <template v-slot:activator="{ on }">
                  <v-icon  class="mr-2" @click="editRule(item)" v-on="on" color="blue darken-2">
                    edit
                  </v-icon>
                </template>
                <span>Editar Permisos</span>
              </v-tooltip>
            </template>


          </v-data-table>
          <div class="text-center pt-2" @click="pageUp();">
            <v-pagination v-model="page" :length="pageCount" 
              
              >

            </v-pagination>
          </div>


        </v-card>
      </v-flex>
    </v-layout>

  </v-container>
</template>

<script>
// import sharedMethods  from '@/components/shared/sharedMethods.js'
import {mixshared} from '@/mixins/mixshared.js'

export default {
  mixins: [mixshared],
  name: 'ProfiList',
  components: {
    //
  },
  data: () => ({
    //
    data: [{
      id: '',
      sysname: '',
      email: '',
      firstname: '',
      midname: '',
      lastname: '',
      names: '',
      movil: '',
      password: '',
      active: ''
    }],
    headers: [
      {
        text: 'Usuario',
        align: 'left',
        sortable: true,
        value: 'email',
        width: '1'
      },
      {
        text: 'Nombre',
        align: 'left',
        sortable: true,
        value: 'names',
        width: '1'
      },
      {
        text: 'Activo',
        value: 'status',
        sortable: false,
        align: 'left',
        width: '1'
      },		
      {
        text: 'Permisos',
        value: 'action',
        sortable: false,
        align: 'action',
        width: '1'
      }
    ]
  }),
  methods: {

    initialize: function () {
      //
    },
    usersList: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/userlist'
      const dataRespond = this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.data = await this.responseData.data
      this.responseData = await []
    },
    editRule: function (val) {
      this.$store.dispatch('loadViewData', { act: 'editing', param: val } )
    }
  },
  created () {
  },
  mounted () {
    // setTimeout(() => { this.loading = false }, 1000)
    this.usersList()
  },
  updated () {
  },
  watch: {
  },
  computed: {
    //
    viewData: function () {
      return this.$store.getters.getViewData
    }
    
  }
}
</script>