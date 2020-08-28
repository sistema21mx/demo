<template>
  <v-container fluid>
    <SystemBr ma-0 pa-0 />
    
    <DiV v-if="imageHeight!==null">{{ editedItem }}</DiV>

    <CondTLst ma-0 pa-0 v-if="pageNumber===1" :item="editedItem" @pageChange="loadPage" @setEditedItem="editedItem = $event"/>
    <CondTEdt ma-0 pa-0 v-if="pageNumber===2" :item="editedItem" @pageChange="loadPage" @setEditedItem="editedItem = $event"/>

  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'
import SystemBr from '@/components/Shared/SystemBr'
import CondTLst from '@/components/CondTyp/CondTLst'
import CondTEdt from '@/components/CondTyp/CondTEdt'

export default {
  name: 'CondTyp',
  mixins: [mixshared],
  // props: [''],
  components: {
    SystemBr,
    CondTLst, CondTEdt
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
    updateTime() {
      const time = new Date();
      this.dateNow.hours = time.getHours();
      this.dateNow.minutes = time.getMinutes();
      this.dateNow.seconds = time.getSeconds();
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