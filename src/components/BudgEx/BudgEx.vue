<template>
  <v-container fluid>
    <SystemBr ma-0 pa-0 />
    <BudgELst ma-0 pa-0 v-if="pageNumber===1" :item="editedItem" @pageChange="loadPage" @setEditedItem="editedItem = $event"/>
    <BudgEEdt ma-0 pa-0 v-if="pageNumber===2" :item="editedItem" @pageChange="loadPage" @setEditedItem="editedItem = $event"/>
  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'
import SystemBr from '@/components/Shared/SystemBr'
import BudgELst from '@/components/BudgEx/BudgELst'
import BudgEEdt from '@/components/BudgEx/BudgEEdt'

export default {
  name: 'BudgEx',
  mixins: [mixshared],
  // props: [''],
  components: {
    SystemBr,
    BudgELst, BudgEEdt
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