<template>
  <v-container>

      <v-flex>
        <v-img
          :src="require('@/assets/logo.png')"
          class="my-3"
          contain
          height="100"
        ></v-img>
      </v-flex>

  <div class="text-center">
    <v-btn
      :disabled="dialog"
      :loading="dialog"
      class="white--text"
      color="purple darken-2"
      @click="printFile();"
      >
      Imprimir
    </v-btn>
  </div>

  <div class="text-center">
          <v-text-field
            v-model="nameBlade"
            label="Regular"
            single-line
            v-on:keyup="keymonitor"
          ></v-text-field>
  </div>




  <v-dialog
    v-model="dialog"
    hide-overlay
    persistent
    width="300"
    >
    <v-card
      color="primary"
      dark
    >
      <v-card-text>
        Generando Documento... Espere...
        <v-progress-linear
          indeterminate
          color="white"
          class="mb-0"
        ></v-progress-linear>
      </v-card-text>
    </v-card>
  </v-dialog>

  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'

export default {
  name: 'Testprnt',
  mixins: [mixshared],
  // props: [''],
  components: {
    //
  },
  data: () => ({
    //
    dialog: false,
    nameBlade: 'test',
  }),
  methods: {
    initialize: function () {
      //
    },
    printFile: async function () {
      //
      this.dialog = true
      //
      let val = await {}
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/printest'
      const dataRespond = await 'blob' // this.typeDataRespond
      val.nameBlade = await this.nameBlade
      val.nameFile = await 'testing' + this.getTimeStamp(new Date()).replace(/ |-|:/g,"").substring(2)
      const formData = await val
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.$store.dispatch('loadOverlay', true)
      await this.getAxPrint(methodWay, baseURI, dataRespond, formData, jwToken)




    },
    keymonitor: function (event) {
      if (event.key === 'Enter') {
        this.printFile()
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
  },
  updated () {
    //
  },
  watch: {
    //
    dialog (val) {
      if (!val) return
      setTimeout(() => (this.dialog = false), 4000)
    },
  },
  computed: {
    //
  }
}
</script>