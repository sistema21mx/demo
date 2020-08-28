<template>
  <v-container grid-list-md>

    <v-row>
      <v-col cols="12">
        <v-row
          align="center"
          justify="end"
          class="grey lighten-5"
          style="height: 50px;"
        >

      <v-tooltip bottom>
        <template v-slot:activator="{ on }">
          <v-btn v-show="isEditing" :disabled="!isEditing" 
            color="primary" fab small v-on="on" @click="saveData();">
            <v-icon>check</v-icon>
          </v-btn>
        </template>
        <span>Salvar</span>
      </v-tooltip>
      <div class="mx-2" v-show="isEditing"></div>

      <v-tooltip bottom>
        <template v-slot:activator="{ on }">
          <v-btn :disabled="isSave" color="primary" fab small v-on="on" @click="editData();">
            <v-icon v-if="isEditing">clear</v-icon>
            <v-icon v-else>create</v-icon>
          </v-btn>
        </template>
        <span v-if="!isEditing">Editar Permisos</span>
        <span v-else>Cancelar Editar</span>
      </v-tooltip>
      <div class="mx-2"></div>

      <v-tooltip bottom>
        <template v-slot:activator="{ on }">
          <v-btn v-show="!isEditing" :disabled="isEditing" 
            color="primary" fab small v-on="on" @click="backPage();">
            <v-icon>keyboard_arrow_left</v-icon>
          </v-btn>
        </template>
        <span>Salir</span>
      </v-tooltip>
      <div class="mx-2" v-show="!isEditing"></div>

        </v-row>
      </v-col>
    </v-row>




    <v-layout wrap justify-center>
      <v-flex xs2 sm1 md1>
        <v-text-field
          id="id"
          name="id"
          :readonly="true"
          v-model="viewData.param.id"
          label="Id"
          outlined
        ></v-text-field>
      </v-flex>



      <v-flex xs6 sm4 md4>
        <v-text-field
          id="usuario"
          name="usuario"
          :readonly="true"
          v-model="viewData.param.email"
          label="Usuario"
          outlined
        ></v-text-field>
      </v-flex>

      <v-flex xs2 sm1 md1>
        <v-text-field
          id="activo"
          name="activo"
          :readonly="true"
          v-model="viewData.param.active"
          label="Activo"
          outlined
        ></v-text-field>
      </v-flex>

      <v-flex xs10 sm4 md4>
        <v-text-field
          id="nombre"
          name="nombre"
          :readonly="true"
          v-model="viewData.param.names"
          label="Nombre"
          outlined
        ></v-text-field>
      </v-flex>


    </v-layout>
    <v-layout v-show="isEditing" wrap justify-center>
      <v-flex xs10 sm3 md3>
        <v-checkbox
          v-model="checkAll"
          label="Elegir todos?"
          primary
          hide-details
          :input-value="checkAll"
          :disabled="!isEditing"
          @change="selectAll();"
        ></v-checkbox>
      </v-flex>
    </v-layout>
    <v-layout wrap justify-center>

      <v-flex xs10 sm10 md10 v-show="mnuItems.length>1">
        <v-layout wrap >
          <v-flex xs10 sm3 md3 v-for="mainOpc in mnuItems" :key="mainOpc.opcId">
            <v-switch v-model="checkedOptions" :label="mainOpc.etiqueta" :value="mainOpc.opcId"
              :input-value="mainOpc.opcId" :id="mainOpc.opcId" :disabled="!isEditing"
              >
            </v-switch>
          </v-flex>
        </v-layout>
      </v-flex>

    </v-layout>

  </v-container>
</template>

<script>
// import sharedMethods  from '@/components/shared/sharedMethods.js'
import {mixshared} from '@/mixins/mixshared.js'
export default {
  mixins: [mixshared],
  name: 'ProfilEdit',
  components: {
    //
  },
  data: () => ({
    //
    isEditing: null,
    isSave: null,
    checkAll: false,
    checkedOptions: [],
    mnuItems: [
      { opcId: '1', etiqueta: 'Opcion 1' }
    ]
  }),
  methods: {
    initialize: function () {
      //
    },
    backPage: function () {
      this.$store.dispatch('loadViewData', { act: 'listing', param: {} } )
    },
    listOptions: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/menuprofile'
      const dataRespond = this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.data = await this.responseData.data
      this.mnuItems = await this.responseData.data
      this.responseData = await []
    },
    userRules: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/profiluser'
      const dataRespond = this.typeDataRespond
      const formData = await {'userId': this.viewData.param.id}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.checkedOptions = await this.responseData.data
      this.responseData = await []
    },
    saveRules: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/profilsave'
      const dataRespond = this.typeDataRespond
      const formData = await {
        'userId': this.viewData.param.id,
        'checkedOptions': this.checkedOptions
      }
      const jwToken = await this.loadKeyPass // this.userData.data.token
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      await this.$store.dispatch('loadMessage', { msg: this.responseData.message, type: 'info' })
      this.responseData = await []
      await this.backPage()
    },
    editData: function () {
      //
      this.isEditing = !this.isEditing
        if (this.isEditing === false) {
          this.backPage()
        }
    },
    selectAll: function () {
      let selectAll = []
      if ( this.checkAll === true ) {
        let myObj = this.mnuItems
        for (var i = 0; i < myObj.length; i++){
            selectAll[i] = myObj[i].opcId.toString()
        }
      }
      this.checkedOptions = selectAll


    },
    saveData: function () {
      this.isSave = true
      this.saveRules()
    }
  },
  created () {
  },
  mounted () {
    this.listOptions()
    this.userRules()
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