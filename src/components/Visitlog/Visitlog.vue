<template>
  <v-container>
    <SystemBr ma-0 pa-0 />
    <DiV v-if="imageHeight!==null">{{ editedItem }}</DiV>

    <VisitLst ma-0 pa-0 v-if="pageNumber===1" :item="editedItem" @pageChange="loadPage" @setEditedItem="editedItem = $event"/>
    <VisitEdt ma-0 pa-0 v-if="pageNumber===2" :item="editedItem" @pageChange="loadPage" @setEditedItem="editedItem = $event"/>

  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'
import SystemBr from '@/components/Shared/SystemBr'
import VisitLst from '@/components/Visitlog/VisitLst'
import VisitEdt from '@/components/Visitlog/VisitEdt'

export default {
  name: 'Visitlog',
  mixins: [mixshared],
  // props: [''],
  components: {
    SystemBr,
    VisitLst, VisitEdt
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