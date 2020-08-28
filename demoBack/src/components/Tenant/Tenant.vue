<template>
  <v-container>
    <SystemBr ma-0 pa-0 />
    <DiV v-if="imageHeight!==null">{{ editedItem }}</DiV>

    <TenanLst ma-0 pa-0 v-if="pageNumber===1" :item="editedItem" @pageChange="loadPage" @setEditedItem="editedItem = $event"/>
    <TenanEdt ma-0 pa-0 v-if="pageNumber===2" :item="editedItem" @pageChange="loadPage" @setEditedItem="editedItem = $event"/>

  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'
import SystemBr from '@/components/Shared/SystemBr'
import TenanLst from '@/components/Tenant/TenanLst'
import TenanEdt from '@/components/Tenant/TenanEdt'

export default {
  name: 'Tenant',
  mixins: [mixshared],
  // props: [''],
  components: {
    SystemBr,
    TenanLst, TenanEdt
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