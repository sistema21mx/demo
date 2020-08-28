<template>
  <v-row justify="center">
    <v-dialog v-model="dialogForm.show" persistent max-width="290">
      <v-card>
        <v-card-title class="headline">{{ dialogForm.title }}</v-card-title>
        <v-card-text>{{ dialogForm.text }}</v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="green darken-1" text @click="actions(false)">Cancelar</v-btn>
          <v-btn color="green darken-1" text @click="actions(true)">Continuar</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
// import {mixshared} from '@/mixins/mixshared.js'

export default {
  name: 'Dialog01',
  // mixins: [mixshared],
  props: ['dialogForm'],
  components: {
    //
  },
  data: () => ({
    //
    // dialog: false,
  }),
  methods: {
    initialize: function () {
      //
    },
    actions: function (val) {
      //
      this.dialogForm.show = false
      this.$emit('getDialog', val)
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