<template>
  <v-container>
    <SystemBr ma-0 pa-0 />
    <DiV v-if="imageHeight!==null">{{ editedItem }}</DiV>

    <QuotaLst ma-0 pa-0 v-if="pageNumber===1" :item="editedItem" @pageChange="loadPage" @setEditedItem="editedItem = $event"/>
    <QuotaEdt ma-0 pa-0 v-if="pageNumber===2" :item="editedItem" @pageChange="loadPage" @setEditedItem="editedItem = $event"/>

  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'
import SystemBr from '@/components/Shared/SystemBr'
import QuotaLst from '@/components/Quota/QuotaLst'
import QuotaEdt from '@/components/Quota/QuotaEdt'

export default {
  name: 'Quota',
  mixins: [mixshared],
  // props: [''],
  components: {
    SystemBr,
    QuotaLst, QuotaEdt
  },
  data: () => ({
    //
    pageNumber: 1,
    editedItem: {},
  }),
  methods: {
    initialize: function () {
      //
    },
    loadPage: function (val) {
      if(val === 1){ this.editedItem = {}}
      this.pageNumber = val
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