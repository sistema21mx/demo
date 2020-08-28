<template>
  <v-container>
      <v-card>
        <v-card-title class="primary darken-1">
          <span class="subtitle-2 white--text">{{ formTitle }}</span>
          <v-spacer></v-spacer>
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn dark icon @click.stop="closEditDialog();" v-on="on">
                <v-icon>mdi-chevron-left</v-icon>
              </v-btn>
            </template>
            <span>Salir</span>
          </v-tooltip>&nbsp;
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn dark icon @click.stop="editFocus('text_reference');" v-on="on" v-show="!isEditing">
                <v-icon>mdi-pencil</v-icon>
              </v-btn>
            </template>
            <span>Editar</span>
          </v-tooltip>&nbsp;
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn dark icon @click.stop="savEdit();" v-on="on" v-show="isEditing">
                <v-icon>check</v-icon>
              </v-btn>
            </template>
            <span>Salvar</span>
          </v-tooltip>&nbsp;
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-form>
              <v-row>

                <v-col cols="12" sm="6" md="4">
                <v-dialog
                  ref="dialogdatedoc"
                  v-model="pickModaldatedoc"
                  :return-value.sync="editedItem.datedoc"
                  persistent
                  width="290px">
                  <template v-slot:activator="{ on }">
                    <v-text-field
                      id="text_datedoc" ref="text_datedoc"
                      v-model="editedItem.datedoc"
                      label="Fecha"
                      prepend-icon="event"
                      readonly
                      v-on="on"
                      :disabled="!isEditing"
                      hint="AAAA-MM-DD" persistent-hint
                    ></v-text-field>
                  </template>
                  <v-date-picker 
                    v-model="editedItem.datedoc" 
                    @input="$refs.dialogdatedoc.save(editedItem.datedoc);pickModaldatedoc = false"
                    >
                  </v-date-picker>
                </v-dialog>
                </v-col>
                <v-col cols="12" sm="6" md="8">
                  <v-text-field id="text_reference" ref="text_reference" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.reference" label="Referencia"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="6">
                  <h4>Banco</h4>
                  <v-select2 
                    class="style-chooser"
                    placeholder="Elija un Banco"
                    v-model="editedItem.bank_id" 
                    :options="optSelectbank_id" 
                    :reduce="opt => opt.val" 
                    :filterable="true"
                    :disabled="!isEditing"
                    id="text_bank_id" ref="text_bank_id"
                    label="opt">
                    <div slot="no-options">No existe coincidencia!</div>
                  </v-select2>
                </v-col>
                <v-col cols="12" sm="6" md="6">
                  <h4>Unidad</h4>
                  <v-select2 
                    class="style-chooser"
                    placeholder="Elija un Condominio"
                    v-model="editedItem.condominia_id" 
                    :options="optSelectcondominia_id" 
                    :reduce="opt => opt.val" 
                    :filterable="true"
                    :disabled="!isEditing"
                    id="text_condominia_id" ref="text_condominia_id"
                    label="opt">
                    <div slot="no-options">No existe coincidencia!</div>
                  </v-select2>
                </v-col>
                <v-col cols="12" sm="6" md="8">
                  <v-text-field id="text_comment" ref="text_comment" v-on:keyup="keymonitor" :disabled="!isEditing"
                    v-model="editedItem.comment" label="Comentario"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_amount" ref="text_amount" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.amount" label="Monto" :hint="`${hintcooperation}`" persistent-hint></v-text-field>
                </v-col>

              </v-row>

            </v-form>
          </v-container>
        </v-card-text>

      </v-card>
  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'
import 'vue-select/dist/vue-select.css';

export default {
  name: 'DeposEdt',
  mixins: [mixshared],
  props: ['item'],
  components: {
    //
  },
  data: () => ({
    //
    pickModaldatedoc: false,
    hintcooperation: '',
    optSelectcondominia_id: [
      {opt: 'Leyendo', val: null}
    ],
    optSelectbank_id: [
      {opt: 'Leyendo', val: null}
    ],
  }),
  methods: {
    initialize: async function () {
      //
      await this.getcondominia_id()
      await this.getbank_id()
      this.editedItem = await this.item
      if(this.editedItem.condominia_id!==null){
        this.editedItem.condominia_id = await Number(this.editedItem.condominia_id)
      }
      if(this.editedItem.bank_id!==null){
        this.editedItem.bank_id = await Number(this.editedItem.bank_id)
      }
      this.editedItem.user_id = await this.userData.data.userId
      if(await this.editedItem.id===0){
        await this.editFocus('text_reference')
        this.editedItem.datedoc = await this.getToday()
      }
    },
    getcondominia_id: async function () {
      //
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/condominiaids'
      const dataRespond = await this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.optSelectcondominia_id = await this.responseData.data
      this.responseData = await null
    },
    getbank_id: async function () {
      //
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/bankids'
      const dataRespond = await this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.optSelectbank_id = await this.responseData.data
      this.responseData = await null
    },
    savEdit: async function () {
      this.$store.dispatch('loadUpPage')
      let message = ''
      let type = 'info'
      if(await this.validationFields()){
        //
        this.$store.dispatch('loadOverlay', true)
        if (await this.editedItem.id !== 0) {
          await this.updateRow()
        } else {
          await this.createRow()
        }
        if(await this.loadData===1 && await this.responseData.length !== 0){
          message = this.responseData.message
          if(this.responseData.error===0){
            this.closEditDialog()
          } else {
            type = 'error'
          }
        } else {
          type = 'error'
          message = 'Error: No actualizo el registro'
        }
        await this.$store.dispatch('loadMessage', { msg: message, type: type })
        if(await this.responseData.column){
          await this.getFocus(this.responseData.column)
        }
      }
    },
    validationFields: function () {
        this.editedItem.datedoc = this.trimField(this.editedItem.datedoc)
        this.editedItem.reference = this.trimField(this.editedItem.reference)
        this.editedItem.bank_id = this.trimField(this.editedItem.bank_id)
        this.editedItem.condominia_id = this.trimField(this.editedItem.condominia_id)
        this.editedItem.amount = this.trimField(this.editedItem.amount)

        let isValid = true
        let message = null

        if (this.editedItem.datedoc === null && message === null) {
          message = 'Aviso: Ingresar Fecha'
          document.getElementById('text_datedoc').focus()
        }
        if (this.editedItem.reference === null && message === null) {
          message = 'Aviso: Ingresar Referencia'
          document.getElementById('text_reference').focus()
        }
        if (this.editedItem.condominia_id === null && message === null) {
          message = 'Aviso: Ingresar Condominio'
          document.getElementById('text_condominia_id').focus()
        }
        if (this.editedItem.bank_id === null && message === null) {
          message = 'Aviso: Ingresar Banco'
          document.getElementById('text_bank_id').focus()
        }
        if ((this.editedItem.amount === null && message === null) || (Number(this.editedItem.amount) === 0) && message === null) {
          message = 'Aviso: Ingresar monto'
          document.getElementById('text_amount').focus()
        }

        //
        if(message!==null){
          this.$store.dispatch('loadMessage', { msg: message, type: 'error' })
          isValid = false
        }
        return isValid
    },
    updateRow: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/depositupdate'
      const dataRespond = this.typeDataRespond
      const formData = await this.editedItem
      const jwToken = await this.loadKeyPass
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.responseData = await []
    },
    createRow: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/depositcreate'
      const dataRespond = await this.typeDataRespond
      this.editedItem.user_id = await this.userData.data.userId
      const formData = await this.editedItem
      const jwToken = await this.loadKeyPass // this.userData.data.token
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.responseData = await []
    },
    keymonitor: function (event) {
      if (event.key === 'Enter') {
        this.savEdit()
      }
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
    'editedItem.amount' (val) {
      if(val!==null){
        this.hintcooperation = val.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
      } else { 
        this.hintcooperation = ''
      }
    },
  },
  computed: {
    //
    formTitle: function () {
      return this.editedItem.id === 0 ? this.labelBar + ' (Nuevo)' : this.labelBar + ' (Editando)' 
    }
  }
}
</script>
<style scoped lang="scss">
  .style-chooser .vs__no-options{
    color: #ff6347;
    font-size: 14px;
  }
  .style-chooser .vs__dropdown-toggle{
    height: 28px;
    font-size: 14px;
  }
  .style-chooser .vs__search::placeholder,
  .style-chooser .vs__dropdown-menu {
    font-size: 14px;
  }
  .style-chooser .vs__clear,
  .style-chooser .vs__open-indicator {
    fill: #0000FF;
  }
</style>
