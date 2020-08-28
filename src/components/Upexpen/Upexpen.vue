<template>
  <v-container>
    <SystemBr ma-0 pa-0 />

    <v-file-input
      v-model="files"
      color="deep-purple accent-4"
      label="Eliga su archivo"
      placeholder="Seleccione un archivo"
      prepend-icon="mdi-paperclip"
      outlined
      dense
      accept="*.csv"
      :show-size="1000"
      @change="uploadcsv"
      :clearable="clearable"
      >
      <template v-slot:selection="{ index, text }">
        <v-chip
          v-if="index < 2"
          color="deep-purple accent-4"
          dark
          label
          small
          >
          {{ text }}
        </v-chip>
      </template>
    </v-file-input>
    retrieveData {{ responseData }}
    <v-card>
      <v-card-title>
        Importar datos
        <v-spacer></v-spacer>



        <v-btn
          v-show="items.length!==0"
          color="secondary"
          class="ma-2 white--text"
          @click.stop="updata"
          small
        >
          Subir Información
          <v-icon right dark>mdi-cloud-upload</v-icon>
        </v-btn>


        <v-text-field
          v-show="items.length!==0"
          v-model="search"
          append-icon="mdi-magnify"
          label="Buscar"
          single-line
          hide-details>
        </v-text-field>
      </v-card-title>
      <v-data-table
        v-show="items.length!==0"
        :headers="headers"
        :items="items"
        :items-per-page="itemsPerPage"
        dense
        :fixed-header="fixedHeader"
        :search="search"
        multi-sort
        sort-by="number"
        hide-default-footer
        class="elevation-1"
        >
      </v-data-table>
    </v-card>


  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'
import SystemBr from '@/components/Shared/SystemBr'

export default {
  name: 'Upexpen',
  mixins: [mixshared],
  // props: [''],
  components: {
    SystemBr,
  },
  data: () => ({
    //
    columnsname: [
      'presupuesto',
      'factura',
      'fecha',
      'concepto',
      'proveedor',
      'rfc',
      'monto'      
    ],
    stringcsv: [],
    itemdata: [],
    //
    files: [],
    //
    clearable: true,
    fixedHeader: true,
    headers: [
      { text: 'Presupuesto', value: 'presupuesto', align: 'start' },
      { text: 'Factura', value: 'factura', align: 'start' },
      // { text: 'Fecha', value: 'fecha', align: 'start' },
      // { text: 'Concepto', value: 'concepto', align: 'start' },
      // { text: 'Proveedor', value: 'proveedor', align: 'start' },
      // { text: 'RFC', value: 'rfc', align: 'start' },
      { text: 'Monto', value: 'monto', align: 'end' },


    ],
    items: [],
    itemsOld: [
      {
        number: null,
        type: null,
        name: null,
        country: null,
      },
    ],
    loading5: false,

  }),
  methods: {
    initialize: function () {
      //
    },
    loaderold () {
      const l = this.loader5
      this[l] = !this[l]

      setTimeout(() => (this[l] = false), 3000)

      this.loader5 = null
    },
    uploadcsv: function () {
      if(typeof(this.files)==='object'){
        var encoding = 'ISO-8859-1'
        var file = this.files
        var reader = new FileReader()
        reader.onload = (event) => {
          this.stringcsv = event.target.result.split("\r\n")
          this.sendata()
        }
        reader.readAsText(file, encoding)
      } else {
        this.stringcsv = []
        this.itemdata = []
        this.items = []
      }
    },
    sendata: async function () {
      //
      this.itemdata = await []
      for (var i = await 0; i < await this.stringcsv.length; i++) {
        // var BOM = "\uFEFF"
        this.stringcsv[i] = await this.stringcsv[i].replace(/"/g, "")
        // this.stringcsv[i] = await (BOM + this.stringcsv[i])
        var cols = await this.stringcsv[i].split(',')
        if (await cols.length > 1 && cols[9]!=='') {
          
          for (var j = await 0; j < await cols.length; j++) {
            //
          }
          let objeto = await {}
          objeto[this.columnsname[0]] = await cols[0]
          objeto[this.columnsname[1]] = await cols[2]
          objeto[this.columnsname[2]] = await cols[3]
          objeto[this.columnsname[3]] = await cols[4]
          objeto[this.columnsname[4]] = await cols[5]
          objeto[this.columnsname[5]] = await cols[6]
          objeto[this.columnsname[6]] = await ('$ ' + this.getformatNumber(parseFloat(cols[9])))
          this.itemdata.push(
            await objeto
          )
        }
      }
      this.items = await this.itemdata
    },
    updata: async function () {
      //
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/expenseupdata'
      const dataRespond = await this.typeDataRespond
      const formData = await this.items
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
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
