<template>
  <v-container>
    <SystemBr ma-0 pa-0 />
    <DiV v-if="imageHeight!==null">{{ editedItem }}</DiV>
    <MonthfHd ma-0 pa-0 v-if="pageNumber===1" :item="editedItem" @pageChange="loadPage" @setEditedItem="editedItem = $event"/>
  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'
import SystemBr from '@/components/Shared/SystemBr'
import MonthfHd from '@/components/Monthf/MonthfHd'

export default {
  name: 'Monthf',
  mixins: [mixshared],
  // props: [''],
  components: {
    SystemBr,
    MonthfHd, 
  },
  data: () => ({
    //
    pageNumber: 1,
    editedItem: {
      id: null,
      year: null,
      period: null,
      day: null,
      datedoc: null,
      datedue: null,
      doctype: null,
      dueDays: 0,
      description: null,
      fund_id: null,
      budget_incomes_id: null,
      amount: 0,
      user_id: 0,
      data: []
    },



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
