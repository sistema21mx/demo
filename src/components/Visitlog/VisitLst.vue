<template>
  <v-container ma-0 pa-0>
    <v-data-table
      :headers="headers"
      :items="items"
      sort-by="datedoc"
      :sort-desc="true"
      hide-default-footer
      dense
      class="elevation-1"
    >
      <template v-slot:top>
        <v-toolbar flat color="white">
          <v-toolbar-title>Visitas</v-toolbar-title>
          <v-divider
            class="mx-4"
            inset
            vertical
          ></v-divider>
          <v-spacer></v-spacer>
          <v-btn
            color="primary"
            dark
            class="mb-2"
            @click.stop="newItem()"
          >Nueva</v-btn>
        </v-toolbar>
      </template>
      <template v-slot:item.actions="{ item }">
        <v-icon
          small
          class="mr-2"
          @click.stop="edit(item)"
        >
          mdi-pencil
        </v-icon>
      </template>
    </v-data-table>


  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'

export default {
  name: 'VisitLst',
  mixins: [mixshared],
  // props: [''],
  components: {
    //
  },
  data: () => ({
    //
    headers: [
      { text: 'Fecha', value: 'datedoc' },
      {
        text: 'Visitante',
        align: 'start',
        sortable: false,
        value: 'name',
      },
      { text: 'Departamento', value: 'condominia' },
      { text: 'Entrada', value: 'timein' },
      { text: 'Salida', value: 'timeout' },
      { text: 'Editar', value: 'actions', sortable: false },
    ],
    items: [],
  }),
  methods: {
    initialize: async function () {
      //
      await this.getList()
      this.items = await this.retrieveData
    },
    getList: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/visitlist'
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
        datedoc: null,
        condominia_id: null,
        datein: null,
        timein: null,
        dateout: null,
        timeout: null,
        reference: null,
        name: null,
        isoIn: null,
        isoOut: null,
        //
        active: '1',
        user_id: this.userData.data.userId
      }
      this.$store.dispatch('loadUpPage')
      this.$emit('setEditedItem', item)
      this.$emit('pageChange', 2)
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