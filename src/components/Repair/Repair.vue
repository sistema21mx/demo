<template>
  <v-container>
    <SystemBr ma-0 pa-0 />
    <DiV v-if="imageHeight!==null">{{ editedItem }}</DiV>
    <RepaiLst ma-0 pa-0 v-if="pageNumber===1" :item="editedItem" @pageChange="loadPage" @setEditedItem="editedItem = $event"/>
    <RepaiEdt ma-0 pa-0 v-if="pageNumber===2" :item="editedItem" @pageChange="loadPage" @setEditedItem="editedItem = $event"/>
  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'
import SystemBr from '@/components/Shared/SystemBr'
import RepaiLst from '@/components/Repair/RepaiLst'
import RepaiEdt from '@/components/Repair/RepaiEdt'

export default {
  name: 'Repair',
  mixins: [mixshared],
  // props: [''],
  components: {
    SystemBr,
    RepaiLst, RepaiEdt
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