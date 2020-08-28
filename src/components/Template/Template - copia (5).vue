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
    <v-btn rounded color="primary" dark @click.stop="printFile(retrieveData.data);">Recibo</v-btn>
  </div>


      {{ retrieveData.data }}

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
  }),
  methods: {
    initialize: function () {
      //
    },
    getList: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/shipmentpaycheck'
      const dataRespond = this.typeDataRespond
      const formData = await {
        week: 'S0820', operatorCode: 'juan', nameBlade: null, nameFile: null, year: null, month: null, day: null,
      }
      const jwToken = await this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.retrieveData = await this.responseData // .data
      this.responseData = await null
    },
    printFile: async function (val) {
        const methodWay = await this.methodWay
        const baseURI = await this.urlApi + '/shipmentpayprint'
        const dataRespond = await 'blob' // this.typeDataRespond
        val.nameBlade = 'payCheck'
        val.nameFile = 'checkPay' + val.week
        const formData = await val
        const jwToken = await this.userData.data.token
        // this.loading = await true
        this.$store.dispatch('loadOverlay', true)
        await this.getAxPrint(methodWay, baseURI, dataRespond, formData, jwToken)

      await this.$store.dispatch('loadMessage', { msg: 'Aviso: Generando documento. Espere...', type: 'info' })


    },
    processData: function () {
      //
    }
  },
  created () {
    //
  },
  mounted () {
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